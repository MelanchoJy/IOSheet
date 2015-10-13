//
//  DBManager.m
//  IOSheet
//
//  Created by 季阳 on 15/9/25.
//  Copyright © 2015年 季阳. All rights reserved.
//
#import "DBManager.h"
#import "Event.h"

#define DB_NAME @"IOSheet.db"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

#define DATABASE_ERROR @"databaseErr"

@implementation DBManager

+ (DBManager*)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (void)createDBwithCompletionHandler:(DatabaseCompletionHandler)completionHandler {
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:DB_NAME]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if (![filemgr fileExistsAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *create_table_sql_stmt = "CREATE TABLE IF NOT EXISTS events(id integer PRIMARY KEY, amount varchar(255) NOT NULL, insert_date date NOT NULL, type integer DEFAULT 0)";
            
            if (sqlite3_exec(database, create_table_sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                completionHandler(NO, [NSError errorWithDomain:DATABASE_ERROR
                                                          code:500
                                                      userInfo:[[NSDictionary alloc] initWithObjects:@[[NSString stringWithFormat:@"Failed to create table: %s",errMsg]]
                                                                                             forKeys:@[NSLocalizedDescriptionKey]]]);
            } else {
                completionHandler(YES,nil);
            }
            
            sqlite3_close(database);
        } else {
            completionHandler(NO, [NSError errorWithDomain:DATABASE_ERROR
                                                      code:500
                                                  userInfo:[[NSDictionary alloc] initWithObjects:@[@"Failed to open/create database"]
                                                                                         forKeys:@[NSLocalizedDescriptionKey]]]);
        }
    } else {
        completionHandler(YES,nil);
    }
}

- (BOOL)removeDB
{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:DB_NAME]];
    BOOL suc = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:databasePath] != NO) {
        if (![filemgr removeItemAtPath:databasePath error:nil]) {
            suc = NO;
            NSLog(@"Remove failed.");
        };
    } else {
        suc = NO;
        NSLog(@"Database not exist.");
    }
    
    return suc;
}

- (void)saveWithType:(NSInteger)type
              amount:(NSString *)amount
                Date:(NSString *)date
andCompletionHandler:(DatabaseCompletionHandler)completionHandler {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO events(amount,insert_date,type) VALUES (\"%@\",\"%@\",%ld)",amount,date,(long)type];

        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            sqlite3_reset(statement);
            completionHandler(YES, nil);
        } else {
            sqlite3_reset(statement);
            completionHandler(NO,[NSError errorWithDomain:DATABASE_ERROR
                                                     code:500
                                                 userInfo:[[NSDictionary alloc] initWithObjects:@[@"Insert failed."]
                                                                                        forKeys:@[NSLocalizedDescriptionKey]]]);
        }
        sqlite3_close (database);
    } else {
        completionHandler(NO,[NSError errorWithDomain:DATABASE_ERROR
                                                 code:500
                                             userInfo:[[NSDictionary alloc] initWithObjects:@[@"Cannot open database."]
                                                                                    forKeys:@[NSLocalizedDescriptionKey]]]);
    }
}

- (void)getEventsForDate:(NSString *)dateString withCompletionHandler:(DataRetrieveCompletionHandler)completionHandler {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM events WHERE (insert_date = '%@')",dateString];
        
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *rowID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *amount = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *startDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *type = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                Event *event = [[Event alloc] initEventWithDetail:[rowID integerValue] andAmount:amount andStarDate:startDate andEventType:type];
                [resultArray addObject:event];
            }
            
            sqlite3_finalize(statement);
            completionHandler(YES, resultArray, nil);
        } else {
            sqlite3_finalize(statement);
            completionHandler(NO, nil, [NSError errorWithDomain:DATABASE_ERROR
                                                           code:500
                                                       userInfo:[[NSDictionary alloc] initWithObjects:@[@"Retrieve failed."]
                                                                                              forKeys:@[NSLocalizedDescriptionKey]]]);
        }
        sqlite3_close (database);
    } else {
        completionHandler (NO, nil, [NSError errorWithDomain:DATABASE_ERROR
                                                        code:404
                                                    userInfo:[[NSDictionary alloc] initWithObjects:@[@"Cannot open database."]
                                                                                           forKeys:@[NSLocalizedDescriptionKey]]]);
    }
}

@end
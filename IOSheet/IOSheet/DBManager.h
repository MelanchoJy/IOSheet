//
//  DBManager.h
//  IOSheet
//
//  Created by 季阳 on 15/9/25.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

typedef void(^DatabaseCompletionHandler)(BOOL finished, NSError *error);
typedef void(^DataRetrieveCompletionHandler)(BOOL finished, NSArray *result, NSError *error);

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+ (DBManager*)getSharedInstance;

- (void)createDBwithCompletionHandler:(DatabaseCompletionHandler)completionHandler;

- (void)saveWithType:(NSInteger)type
              amount:(NSString *)amount
                Date:(NSString *)date
andCompletionHandler:(DatabaseCompletionHandler)completionHandler;

- (void)getEventsForDate:(NSString *)dateString withCompletionHandler:(DataRetrieveCompletionHandler)completionHandler;

@end

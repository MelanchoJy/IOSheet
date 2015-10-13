//
//  DayObject.m
//  IOSheet
//
//  Created by 季阳 on 15/9/10.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "DayObject.h"
#import "DBManager.h"

@interface DayObject()
@property (strong, nonatomic) DBManager *dbManger;
@property (strong, nonatomic) NSString *full_date;
@end

@implementation DayObject

- (DBManager *)dbManger {
    if (!_dbManger) {
        _dbManger = [DBManager getSharedInstance];
    }
    return _dbManger;
}

- (void)getEventForDay {
    [self.dbManger getEventsForDate:self.full_date
              withCompletionHandler:^(BOOL finished, NSArray *result, NSError *error) {
                  if (finished) {
                      self.events = result;
                  }
              }];
}

- (instancetype)initDayWithDay:(NSString *)day InThisMonth:(BOOL)this_month {
    self = [super init];
    if (self) {
        self.day = day;
        self.this_month = this_month;
    }
    return self;
}

- (instancetype)initDayWithDay:(NSString *)day InThisMonth:(BOOL)this_month AndQueryDate:(NSString *)date {
    self = [super init];
    if (self) {
        self.day = day;
        self.this_month = this_month;
        self.full_date = date;
        
        [self getEventForDay];
    }
    return self;
}

@end

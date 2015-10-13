//
//  DayObject.h
//  IOSheet
//
//  Created by 季阳 on 15/9/10.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayObject : NSObject
@property (strong, nonatomic) NSString *day;
@property (nonatomic) BOOL this_month;
@property (nonatomic) NSArray *events;

- (instancetype)initDayWithDay:(NSString *)day InThisMonth:(BOOL)this_month;
- (instancetype)initDayWithDay:(NSString *)day InThisMonth:(BOOL)this_month AndQueryDate:(NSString *)date;
@end

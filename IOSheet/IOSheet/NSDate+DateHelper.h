//
//  NSDate+DateHelper.h
//  IOSheet
//
//  Created by 季阳 on 15/9/9.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateHelper)
+ (NSDate *)getDateTimeFromString:(NSString *)date;
+ (NSInteger)monthsBetweenDate:(NSDate *)date1 andDate:(NSDate *)date2;
+ (NSString *)getYearFromString:(NSString *)string;
+ (NSString *)getMonthFromString:(NSString *)string;
+ (NSString *)getCurrentDateTime;
+ (NSInteger)getDaysCountInMonth:(NSDate *)date;
+ (NSInteger)getDayNumOfWeek:(NSDate *)date;
@end

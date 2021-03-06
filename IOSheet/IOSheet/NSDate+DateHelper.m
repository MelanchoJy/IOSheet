//
//  NSDate+DateHelper.m
//  IOSheet
//
//  Created by 季阳 on 15/9/9.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "NSDate+DateHelper.h"

@implementation NSDate (DateHelper)

+ (NSDate *)getDateTimeFromString:(NSString *)date {
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    return [formatter dateFromString:date];
}

+ (NSInteger)monthsBetweenDate:(NSDate *)date1 andDate:(NSDate *)date2 {
    return [[[NSCalendar currentCalendar] components: NSCalendarUnitMonth
                                            fromDate: date1
                                              toDate: date2
                                             options: 0] month];
}

+ (NSString *)getYearFromString:(NSString *)string {
    NSDate *date = [self getDateTimeFromString:string];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    [formatter setTimeZone:timeZone];
    return [formatter stringFromDate:date];
}

+ (NSString *)getMonthFromString:(NSString *)string {
    NSDate *date = [self getDateTimeFromString:string];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    [formatter setTimeZone:timeZone];
    return [formatter stringFromDate:date];
}

+ (NSString *)getCurrentDateTime {
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [DateFormatter stringFromDate:[NSDate date]];
}

+ (NSInteger)getDaysCountInMonth:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange days = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return days.length;
}

+ (NSInteger)getDayNumOfWeek:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:zone];
    formatter.dateFormat=@"e";
    return [[formatter stringFromDate:date] integerValue];
}

+ (NSString *)getDateStringWithYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day {
    NSString *dateString = [NSString stringWithFormat:@"%ld", (long)year];
    if (month<=9) {
        dateString = [NSString stringWithFormat:@"%@-0%ld", dateString, (long)month];
    } else {
        dateString = [NSString stringWithFormat:@"%@-%ld", dateString, (long)month];
    }
    
    if (day<=9) {
        dateString = [NSString stringWithFormat:@"%@-0%ld", dateString, (long)day];
    } else {
        dateString = [NSString stringWithFormat:@"%@-%ld", dateString, (long)day];
    }
    
    return dateString;
}

@end

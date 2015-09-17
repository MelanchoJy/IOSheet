//
//  MonthObject.m
//  IOSheet
//
//  Created by 季阳 on 15/9/9.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "MonthObject.h"
#import "NSDate+DateHelper.h"
#import "define.h"
#import "DayObject.h"

@interface MonthObject()
@property (strong, nonatomic) NSDateFormatter *formater;
@property (nonatomic) NSInteger days_in_month;
@property (nonatomic) NSInteger start_pos;
@property (nonatomic) BOOL has_today;
@end

@implementation MonthObject

- (NSMutableArray *)days {
    if (!_days) {
        _days = [[NSMutableArray alloc] init];
    }
    return _days;
}

- (NSDateFormatter *)formater {
    if (!_formater) {
        NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"UTC"];
        
        _formater = [[NSDateFormatter alloc] init];
        _formater.dateFormat = @"yyyy-MM-dd";
        [_formater setTimeZone:zone];
    }
    return _formater;
}

- (NSInteger)getDaysCountInMonthFromYear:(NSInteger)year AndMonth:(NSInteger)month {
    NSDate *date = [self.formater dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d", year, month, 1]];
    return [NSDate getDaysCountInMonth:date];
}

- (NSInteger)getDaysCountInPrevmouthFromYear:(NSInteger)year AndMonth:(NSInteger)month {
    month = month - 1 == 0 ? 12 : month - 1;
    year = month == 12 ? year - 1 : year;
    return [self getDaysCountInMonthFromYear:year AndMonth:month];
}

- (NSInteger)getStartPosInWeekOfThisMonthFromYear:(NSInteger)year AndMonth:(NSInteger)month {
    NSDate *date = [self.formater dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d", year, month, 1]];
    return [NSDate getDayNumOfWeek:date];
}

- (BOOL)hasToday {
    NSInteger year = [[NSDate getYearFromString:[NSDate getCurrentDateTime]] integerValue];
    NSInteger month = [[NSDate getMonthFromString:[NSDate getCurrentDateTime]] integerValue];
    return self.year == year && self.month == month;
}

- (void)createDays {
    NSInteger prev_month_count = [self getDaysCountInPrevmouthFromYear:self.year AndMonth:self.month];
    for (NSInteger i = self.start_pos - 1; i > 0; i--) {
        DayObject *day = [[DayObject alloc] initDayWithDay:[NSString stringWithFormat:@"%li", prev_month_count - (i - 1)] InThisMonth:NO];
        [self.days addObject:day];
    }
    
    for (NSInteger i = 0; i < self.days_in_month; i++) {
        DayObject *day = [[DayObject alloc] initDayWithDay:[NSString stringWithFormat:@"%li", i + 1] InThisMonth:YES];
        [self.days addObject:day];
    }
    
    int i = 1;
    while ([self.days count] <= 35) {
        DayObject *day = [[DayObject alloc] initDayWithDay:[NSString stringWithFormat:@"%i", i++] InThisMonth:NO];
        [self.days addObject:day];
    }
}

- (instancetype)initCalendarWithRow:(NSInteger)row {
    self = [self init];
    if (self) {
        self.month_index = row;
        self.year = [[NSDate getYearFromString:startDate] integerValue] + row / 12;
        self.month = row % 12 + 1;
        self.days_in_month = [self getDaysCountInMonthFromYear:self.year AndMonth:self.month];
        self.start_pos = [self getStartPosInWeekOfThisMonthFromYear:self.year AndMonth:self.month];
        self.has_today = [self hasToday];
        [self createDays];
    }
    return self;
}

@end

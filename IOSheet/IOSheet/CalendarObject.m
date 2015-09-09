//
//  CalendarObject.m
//  IOSheet
//
//  Created by 季阳 on 15/9/9.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "CalendarObject.h"
#import "NSDate+DateHelper.h"
#import "define.h"

@interface CalendarObject()
@property (strong, nonatomic) NSDateFormatter *formater;
@property (nonatomic) BOOL has_today;
@end

@implementation CalendarObject

- (NSDateFormatter*)formater {
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

- (BOOL)hasToday {
    NSInteger year = [[NSDate getYearFromString:[NSDate getCurrentDateTime]] integerValue];
    NSInteger month = [[NSDate getMonthFromString:[NSDate getCurrentDateTime]] integerValue];
    return self.year == year && self.month == month;
}

- (instancetype)initCalendarWithRow:(NSInteger)row {
    self = [self init];
    if (self) {
        self.month_index = row;
        self.year = [[NSDate getYearFromString:startDate] integerValue] + row / 12;
        self.month = row % 12 + 1;
        self.days_in_month = [self getDaysCountInMonthFromYear:self.year AndMonth:self.month];
        self.has_today = [self hasToday];
    }
    return self;
}

@end

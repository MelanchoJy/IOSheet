//
//  CalendarObject.h
//  IOSheet
//
//  Created by 季阳 on 15/9/9.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarObject : NSObject
@property (nonatomic) NSInteger month_index;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger days_in_month;
@property (readonly, nonatomic) BOOL has_today;

- (instancetype)initCalendarWithRow:(NSInteger)row;
@end

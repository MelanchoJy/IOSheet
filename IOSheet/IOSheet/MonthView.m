//
//  MonthView.m
//  IOSheet
//
//  Created by 季阳 on 15/9/7.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "MonthView.h"
#import "MonthObject.h"

@interface MonthView()
@property (weak, nonatomic) IBOutlet UILabel *month;
@end

@implementation MonthView

- (void)setCalendarObj:(MonthObject *)cal {
    self.month.text = [NSString stringWithFormat:@"%li年%li月", cal.year, cal.month];
}

@end

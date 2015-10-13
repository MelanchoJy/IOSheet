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
@property (weak, nonatomic) IBOutlet UILabel *cover_month;
@end

@implementation MonthView

- (void)setCalendarObj:(MonthObject *)cal {
    self.month.text = [NSString stringWithFormat:@"%li年%li月", cal.year, cal.month];
    self.cover_month.text = [NSString stringWithFormat:@"%li年%li月", cal.year, cal.month];
}

- (void)beginDragging {
    [UIView animateWithDuration:0.5f animations:^{
        self.month_cover.alpha = 1;
    }];
}

- (void)endDragging {
    [UIView animateWithDuration:0.5f animations:^{
        self.month_cover.alpha = 0;
    }];
}

- (void)hideCover {
    self.month_cover.alpha = 0;
}

@end
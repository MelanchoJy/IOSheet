//
//  DayView.m
//  IOSheet
//
//  Created by 季阳 on 15/9/8.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "DayView.h"

@interface DayView()
@property (strong, nonatomic) UILabel *day;
@end

@implementation DayView

- (instancetype)initDayViewWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.day = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36, 23)];
        self.day.text = @"1";
        [self.day setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        [self addSubview:self.day];
    }
    
    return self;
}

@end

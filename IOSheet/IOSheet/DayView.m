//
//  DayView.m
//  IOSheet
//
//  Created by 季阳 on 15/9/8.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "DayView.h"
#import "DayObject.h"

@interface DayView()
@property (strong, nonatomic) UILabel *day;
@property (nonatomic) BOOL this_month;
@end

@implementation DayView

- (instancetype)initDayViewWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.day = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36, 23)];
        [self.day setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        [self addSubview:self.day];
    }
    
    return self;
}

- (void)setDayObject:(DayObject *)obj {
    self.day.text = [obj day];
    self.this_month = [obj this_month];
    
    if (obj.this_month)
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    else
        self.backgroundColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1.0];
}

@end

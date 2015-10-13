//
//  DayView.m
//  IOSheet
//
//  Created by 季阳 on 15/9/8.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "DayView.h"
#import "DayObject.h"
#import "Event.h"

@interface DayView()
@property (strong, nonatomic) UILabel *day;
@property (nonatomic) BOOL this_month;

@property (nonatomic, strong) UILabel *incomeAmount;
@property (nonatomic, strong) UILabel *outlayAmount;
@property (nonatomic, strong) UIView *incomeView;
@property (nonatomic, strong) UIView *outlayView;
@end

@implementation DayView

- (instancetype)initDayViewWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.day = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36, 23)];
        [self.day setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        [self addSubview:self.day];
        
        self.incomeView = [[UIView alloc] initWithFrame:CGRectMake(0, 23-4, frame.size.width, (frame.size.height-23+4)/2)];
        [self.incomeView setBackgroundColor:[UIColor colorWithRed:102/255.0 green:212/255.0 blue:80/255.0 alpha:1.0]];
        self.incomeAmount = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, frame.size.width-16, self.incomeView.frame.size.height)];
        self.incomeAmount.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 11.0f];
        self.incomeAmount.textColor = [UIColor whiteColor];
        [self.incomeAmount setTextAlignment:NSTextAlignmentRight];
        [self.incomeView addSubview:self.incomeAmount];
        [self addSubview:self.incomeView];
        
        self.outlayView = [[UIView alloc] initWithFrame:CGRectMake(0, self.incomeView.frame.origin.y + self.incomeView.frame.size.height, frame.size.width, (frame.size.height-23+4)/2)];
        [self.outlayView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:99/255.0 blue:64/255.0 alpha:1.0]];
        self.outlayAmount = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, frame.size.width-16, self.outlayView.frame.size.height)];
        self.outlayAmount.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 11.0f];
        self.outlayAmount.textColor = [UIColor whiteColor];
        [self.outlayAmount setTextAlignment:NSTextAlignmentRight];
        [self.outlayView addSubview:self.outlayAmount];
        [self addSubview:self.outlayView];
        
        self.incomeView.hidden = YES;
        self.outlayView.hidden = YES;
    }
    
    return self;
}

- (void)setDayObject:(DayObject *)obj {
    self.day.text = [obj day];
    self.this_month = [obj this_month];
    
    if (obj.this_month)
        self.backgroundColor = [UIColor whiteColor];
    else
        self.backgroundColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1.0];
    
    NSInteger sum_in = 0;
    NSInteger sum_out = 0;
    
    for (Event *event in obj.events) {
        if ([[event type] intValue] == 0) {
            sum_out += [[event amount] intValue];
        }
        else if ([[event type] intValue] == 1) {
            sum_in += [[event amount] intValue];
        }
    }
    
    if (sum_out) {
        self.outlayAmount.text = [NSString stringWithFormat:@"￥-%0.2li", sum_out];
        self.outlayView.hidden = NO;
    }
    
    if (sum_in) {
        self.incomeAmount.text = [NSString stringWithFormat:@"￥+%0.2li", sum_in];
        self.incomeView.hidden = NO;
    }
}

@end

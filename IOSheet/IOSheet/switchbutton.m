//
//  switchbutton.m
//  IOSheet
//
//  Created by 季阳 on 15/9/25.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import "SwitchButton.h"

@interface SwitchButton()
@property (strong, nonatomic) UILabel *income;
@property (strong, nonatomic) UILabel *outcome;
@property (strong, nonatomic) UIView *button;
@property (nonatomic) BOOL out;
@end

@implementation SwitchButton

- (UILabel *)income {
    if (!_income) {
        _income = [[UILabel alloc] init];
        _income.text = [NSString stringWithFormat:@"收"];
        _income.textColor = [UIColor whiteColor];
    }
    return _income;
}

- (UILabel *)outcome {
    if (!_outcome) {
        _outcome = [[UILabel alloc] init];
        _outcome.text = [NSString stringWithFormat:@"支"];
        _outcome.textColor = [UIColor whiteColor];
    }
    return _outcome;
}

- (UIView *)button {
    if (!_button) {
        _button = [[UIView alloc] init];
        _button.backgroundColor = [UIColor blackColor];
    }
    return _button;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.out = YES;
        self.backgroundColor = [UIColor grayColor];
        
        self.income.frame = CGRectMake(7, 0, 18, 30);
        [self addSubview:self.income];
        
        self.outcome.frame = CGRectMake(37, 0, 18, 30);
        [self addSubview:self.outcome];
        
        self.button.frame = CGRectMake(0, 0, 30, 30);
        [self addSubview:self.button];
    }
    return self;
}

- (void)switch {
    if (self.out) {
        [UIView animateWithDuration:0.5f animations:^{
            self.button.frame = CGRectMake(30, 0, 30, 30);
        }];
    }
    else {
        [UIView animateWithDuration:0.5f animations:^{
            self.button.frame = CGRectMake(0, 0, 30, 30);
        }];
    }
    self.out = !self.out;
}

- (BOOL)isOutcome {
    return self.out;
}

@end

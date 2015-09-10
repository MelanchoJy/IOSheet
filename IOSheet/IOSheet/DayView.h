//
//  DayView.h
//  IOSheet
//
//  Created by 季阳 on 15/9/8.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayObject;

@interface DayView : UIView
- (instancetype)initDayViewWithFrame:(CGRect)frame;
- (void)setDayObject:(DayObject *)obj;
@end

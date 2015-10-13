//
//  MonthView.h
//  IOSheet
//
//  Created by 季阳 on 15/9/7.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MonthObject;

@interface MonthView : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *day_container;
@property (weak, nonatomic) IBOutlet UIView *month_cover;

- (void)setCalendarObj:(MonthObject *)cal;
- (void)beginDragging;
- (void)endDragging;
- (void)hideCover;
@end

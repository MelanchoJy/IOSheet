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

- (void)setCalendarObj:(MonthObject *)cal;
@end

//
//  MonthViewController.m
//  IOSheet
//
//  Created by 季阳 on 15/9/7.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "MonthViewController.h"
#import "MonthView.h"
#import "DayView.h"
#import "define.h"
#import "NSDate+DateHelper.h"
#import "MonthObject.h"
#import "DayObject.h"

@interface MonthViewController ()
@property (nonatomic) NSInteger current_row;
@property (strong, nonatomic) UIView* last_select;
@end

@implementation MonthViewController

static NSString * const reuseIdentifier = @"MONTH_CELL";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger month = [NSDate monthsBetweenDate:[NSDate getDateTimeFromString:startDate] andDate:[NSDate getDateTimeFromString:[NSDate getCurrentDateTime]]];
    NSIndexPath *index = [NSIndexPath indexPathForRow:month inSection:0];
    [self.collectionView scrollToItemAtIndexPath:index
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [tap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [NSDate monthsBetweenDate:[NSDate getDateTimeFromString:startDate] andDate:[NSDate getDateTimeFromString:endDate]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.current_row = [indexPath row];
    
    MonthView *cell = (MonthView*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    MonthObject *cal = [[MonthObject alloc] initCalendarWithRow:[indexPath row]];
    [cell setCalendarObj:cal];
    
    for (NSUInteger i = 0; i < [cal.days count]; i++) {
        DayView *day = [[DayView alloc] initDayViewWithFrame:CGRectMake(1 + (95 * (i % 7)), 0 + (61 * (i / 7)), 95, 61)];
        [day setDayObject:[cal.days objectAtIndex:i]];
        [cell.day_container addSubview:day];
    }
    
    return cell;
}

#pragma mark - Actions
- (void)tapHandler:(UITapGestureRecognizer *)gesture {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.current_row inSection:0];
    MonthView *cell = (MonthView *)[self.collectionView cellForItemAtIndexPath:path];
    CGPoint touchLocation = [gesture locationInView:cell.day_container];
    
    for (UIView *view in cell.day_container.subviews) {
        if ([view isKindOfClass:[DayView class]] && CGRectContainsPoint(view.frame, touchLocation) && [(DayView *)view this_month]) {
            self.last_select.backgroundColor = [UIColor whiteColor];
            self.last_select = view;
            self.last_select.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        }
    }
}

@end

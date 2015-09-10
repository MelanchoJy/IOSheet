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

@interface MonthViewController ()

@end

@implementation MonthViewController

static NSString * const reuseIdentifier = @"MONTH_CELL";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [NSDate monthsBetweenDate:[NSDate getDateTimeFromString:startDate] andDate:[NSDate getDateTimeFromString:endDate]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
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

@end

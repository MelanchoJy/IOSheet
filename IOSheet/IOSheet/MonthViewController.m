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
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MonthView *cell = (MonthView*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    for (int i = 0; i < 35; i++) {
    DayView *day = [[DayView alloc] initDayViewWithFrame:CGRectMake(1 + (95 * (i % 7)), 0 + (61 * (i / 7)), 95, 61)];
    day.backgroundColor = [UIColor colorWithRed:60/255.0 green:175/255.0 blue:240/255.0 alpha:1.0];
    
    [cell.day_container addSubview:day];
    }
    
    return cell;
}

@end

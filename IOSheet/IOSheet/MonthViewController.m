//
//  MonthViewController.m
//  IOSheet
//
//  Created by 季阳 on 15/9/7.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "MonthViewController.h"
#import "MonthView.h"

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
    return cell;
}

@end

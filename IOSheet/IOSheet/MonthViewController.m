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
#import "AddViewController.h"

@interface MonthViewController ()
- (IBAction)OnClickPiggy:(id)sender;

@property (nonatomic) NSInteger current_row;
@property (nonatomic) NSInteger next_row;
@property (strong, nonatomic) UIView *last_select;
@property (nonatomic) BOOL didStop;
@property (nonatomic) BOOL didDisplayCell;
@end

@implementation MonthViewController

static NSString * const reuseIdentifier = @"MONTH_CELL";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.didStop = YES;
    self.didDisplayCell = YES;
    
    self.current_row = [NSDate monthsBetweenDate:[NSDate getDateTimeFromString:startDate] andDate:[NSDate getDateTimeFromString:[NSDate getCurrentDateTime]]];
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.current_row inSection:0];
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

#pragma mark UICollectionViewDelegate & DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [NSDate monthsBetweenDate:[NSDate getDateTimeFromString:startDate] andDate:[NSDate getDateTimeFromString:endDate]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.next_row = [indexPath row];
    
    MonthView *cell = (MonthView*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    MonthObject *cal = [[MonthObject alloc] initCalendarWithRow:[indexPath row]];
    [cell setCalendarObj:cal];
    
    for (NSUInteger i = 0; i < [cal.days count]; i++) {
        DayView *day = [[DayView alloc] initDayViewWithFrame:CGRectMake(1 + (95 * (i % 7)), 0 + (61 * (i / 7)), 95, 61)];
        [day setDayObject:[cal.days objectAtIndex:i]];
        [cell.day_container addSubview:day];
    }
    
    static BOOL first = YES;
    if (first) {
        [cell hideCover];
        first = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.didDisplayCell = YES;
    
    if (self.next_row != [indexPath row]) {
        self.current_row = self.next_row;
    }
    
    if (self.didStop) {
        [self.collectionView.superview setUserInteractionEnabled:YES];
        MonthView *cell = (MonthView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.current_row inSection:0]];
        [cell endDragging];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.didStop = NO;
    self.didDisplayCell = NO;
    
    [self.collectionView.superview setUserInteractionEnabled:NO];
    MonthView *cell = (MonthView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.current_row inSection:0]];
    [cell beginDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.didStop = YES;
    
    if (self.didDisplayCell) {
        [self.collectionView.superview setUserInteractionEnabled:YES];
        MonthView *cell = (MonthView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.current_row inSection:0]];
        [cell endDragging];
    }
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

- (IBAction)OnClickPiggy:(id)sender {
    [self performSegueWithIdentifier:@"add_segue" sender:sender];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"add_segue"]) {
        AddViewController *add = (AddViewController *)segue.destinationViewController;
        [add setBarTitle:@"记一笔"];
        add.collection = self.collectionView;
    }
}

@end

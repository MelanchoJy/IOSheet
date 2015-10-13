//
//  AddViewController.h
//  IOSheet
//
//  Created by 季阳 on 15/9/24.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController <UITableViewDelegate, UITableViewDataSource
                                                ,UITextFieldDelegate>
@property (weak, nonatomic) UICollectionView *collection;

- (void)setBarTitle:(NSString *)str;
@end
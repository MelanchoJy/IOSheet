//
//  AddViewController.m
//  IOSheet
//
//  Created by 季阳 on 15/9/24.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import "AddViewController.h"
#import "AddViewCell.h"
#import "SwitchButton.h"
#import "AppDelegate.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navi;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSString *bar_title;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) UITextField *money_field;
@property (weak, nonatomic) UITextField *date_field;
@property (strong, nonatomic) SwitchButton *button;

- (IBAction)OnClickCancel:(id)sender;
- (IBAction)OnClickDone:(id)sender;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.navi.title = self.bar_title;
    
    self.button = [[SwitchButton alloc] init];
    self.button.frame = CGRectMake(240, 7, 60, 30);
    self.button.tintColor = [UIColor blackColor];
    [self.tableview addSubview:self.button];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [tap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)OnClickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)OnClickDone:(id)sender {
    if (self.money_field.text.length == 0
        || self.date_field.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"信息不全" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.dbManger saveWithType:self.button.isOutcome ? 0 : 1
                             amount:self.money_field.text
                               Date:self.date_field.text
               andCompletionHandler:^(BOOL finished, NSError *error) {
                   if (finished) {
                       [self.collection reloadData];
                       [self dismissViewControllerAnimated:YES completion:nil];
                   }
               }];
    
}

- (void)setBarTitle:(NSString *)str {
    self.bar_title = str;
}

#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddViewCell *cell;
    
    if ([indexPath row] == 0) {
        cell = (AddViewCell *)[tableView dequeueReusableCellWithIdentifier:@"money"];
        self.money_field = cell.text_field;
    }
    else if ([indexPath row] == 1) {
        cell = (AddViewCell *)[tableView dequeueReusableCellWithIdentifier:@"date"];
        cell.text_field.delegate = self;
        self.date_field = cell.text_field;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark UITextFieldDelegate
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    _datePicker = [[UIDatePicker alloc]init];
    NSLocale *datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.locale = datelocale;
    _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    self.date_field.inputView = _datePicker;
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(cancelPicker)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                           target:nil
                                                                           action:nil];
    toolBar.items = [NSArray arrayWithObjects:space,right,nil];
    self.date_field.inputAccessoryView = toolBar;
}

-(void) cancelPicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.date_field.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]];
    [self.date_field resignFirstResponder];
}

#pragma mark Action
- (void)tapHandler:(UITapGestureRecognizer *)gesture {
    CGPoint touchLocation = [gesture locationInView:self.tableview];
    if (CGRectContainsPoint(self.button.frame, touchLocation)) {
        [self.button switch];
    }
}

@end

//
//  DayObject.m
//  IOSheet
//
//  Created by 季阳 on 15/9/10.
//  Copyright (c) 2015年 季阳. All rights reserved.
//

#import "DayObject.h"

@implementation DayObject

- (instancetype)initDayWithDay:(NSString *)day InThisMonth:(BOOL)this_month {
    self = [super init];
    if (self) {
        self.day = day;
        self.this_month = this_month;
    }
    return self;
}

@end

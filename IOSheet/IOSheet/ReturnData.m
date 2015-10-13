//
//  ReturnData.m
//  IOSheet
//
//  Created by 季阳 on 15/9/25.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import "ReturnData.h"

@implementation ReturnData

- (ReturnData *)initDataWithRowID:(NSInteger)rowID {
    self = [super init];
    
    if (self) {
        _rowID = rowID;
    }
    return self;
}

@end

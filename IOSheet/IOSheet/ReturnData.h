//
//  ReturnData.h
//  IOSheet
//
//  Created by 季阳 on 15/9/25.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnData : NSObject
@property (nonatomic) NSInteger rowID;

- (ReturnData *)initDataWithRowID:(NSInteger)rowID;
@end

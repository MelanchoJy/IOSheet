//
//  Event.h
//  IOSheet
//
//  Created by 季阳 on 15/9/25.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReturnData.h"

@interface Event : ReturnData

@property (nonatomic, strong) NSString *eventStartDate;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *type;

- (Event *)initEventWithDetail:(NSInteger)rowID
                     andAmount:(NSString *)amount
                   andStarDate:(NSString *)date
                  andEventType:(NSString *)type;

@end

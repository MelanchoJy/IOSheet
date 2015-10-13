//
//  Event.m
//  IOSheet
//
//  Created by 季阳 on 15/9/25.
//  Copyright © 2015年 季阳. All rights reserved.
//

#import "Event.h"

@implementation Event

- (Event *)initEventWithDetail:(NSInteger)rowID
                     andAmount:(NSString *)amount
                   andStarDate:(NSString *)startDate
                  andEventType:(NSString *)type

{
    self = [super initDataWithRowID:rowID];
    
    if (self) {
        _amount = amount;
        _eventStartDate = startDate==nil?@"0000-00-00":startDate;
        _type = type;
    }
    return self;
}

@end

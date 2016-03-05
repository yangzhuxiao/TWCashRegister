//
//  Badminton.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "Badminton.h"

@implementation Badminton

- (id)initWithBadmintonQuantity:(NSInteger)quantity
{
    self = [super initWithItemName:@"羽毛球"
                         itemPrice:1.00
                      itemQuantity:quantity
                      itemUnitName:@"个"
             isOneFreeInEveryThree:YES
             isFivePercentDiscount:NO];
    if (self) {
        
    }
    
    return self;
}


@end

//
//  Ultraman.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "Ultraman.h"

@implementation Ultraman

- (id)initWithUltramanQuantity:(NSInteger)quantity
{
    self = [super initWithItemName:@"奥特曼"
                         itemPrice:20.00
                      itemQuantity:quantity
                      itemUnitName:@"个"
             isOneFreeInEveryThree:NO
             isFivePercentDiscount:NO];
    if (self) {
        
    }
    
    return self;
}

@end

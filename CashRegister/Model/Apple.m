//
//  Apple.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "Apple.h"

@implementation Apple

- (id)initWithAppleQuantity:(NSInteger)quantity
{
    self = [super initWithItemName:@"苹果"
                         itemPrice:5.50
                      itemQuantity:quantity
                      itemUnitName:@"斤"
             isOneFreeInEveryThree:NO
             isFivePercentDiscount:YES];
    if (self) {

    }
    
    return self;
}

@end

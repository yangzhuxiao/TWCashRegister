//
//  Cocacola.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "Cocacola.h"

@implementation Cocacola

- (id)initWithCocacolaQuantity:(NSInteger)quantity
{
    self = [super initWithItemName:@"可口可乐"
                         itemPrice:3.00
                      itemQuantity:quantity
                      itemUnitName:@"瓶"
             isOneFreeInEveryThree:YES
             isFivePercentDiscount:NO];
    if (self) {
        
    }
    
    return self;
}

@end

//
//  ShoppingItem.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "ShoppingItem.h"

@implementation ShoppingItem

- (id)initWithItemName:(NSString *)itemName
             itemPrice:(CGFloat)itemPrice
          itemQuantity:(NSInteger)itemQuantity
          itemUnitName:(NSString *)itemUnitName
 isOneFreeInEveryThree:(BOOL)isOneFreeInEveryThree
 isFivePercentDiscount:(BOOL)isFivePercentDiscount
{
    self = [super init];
    if (self) {
        _itemName = itemName;
        _itemPrice = itemPrice;
        _itemQuantity = itemQuantity;
        _itemUnitName = itemUnitName;
        _isOneFreeInEveryThree = isOneFreeInEveryThree;
        _isFivePercentDiscount = isFivePercentDiscount;
    }
    return self;
}

@end

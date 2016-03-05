//
//  ShoppingItem.h
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShoppingItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, assign) CGFloat itemPrice;
@property (nonatomic, assign) NSInteger itemQuantity;
@property (nonatomic, strong) NSString *itemUnitName;
@property (nonatomic, assign) BOOL isOneFreeInEveryThree;
@property (nonatomic, assign) BOOL isFivePercentDiscount;

- (id)initWithItemName:(NSString *)itemName
             itemPrice:(CGFloat)itemPrice
          itemQuantity:(NSInteger)itemQuantity
          itemUnitName:(NSString *)itemUnitName
 isOneFreeInEveryThree:(BOOL)isOneFreeInEveryThree
 isFivePercentDiscount:(BOOL)isFivePercentDiscount;


@end

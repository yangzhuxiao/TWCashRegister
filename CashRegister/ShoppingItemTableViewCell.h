//
//  ShoppingItemTableViewCell.h
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"

@protocol ShoppingItemTableViewCellDelegate <NSObject>

- (void)shoppingItemQuantityHasChangedWithIndexPath:(NSIndexPath *)indexPath quantity:(NSInteger)quantity;

@end

@interface ShoppingItemTableViewCell : UITableViewCell

@property (nonatomic, weak) id <ShoppingItemTableViewCellDelegate> delegate;
- (void)setCellContentWithShoppingItem:(ShoppingItem *)item indexPath:(NSIndexPath *)indexPath;

@end

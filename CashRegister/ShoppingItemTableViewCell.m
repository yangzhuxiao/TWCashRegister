//
//  ShoppingItemTableViewCell.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "ShoppingItemTableViewCell.h"

@interface ShoppingItemTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemUnitNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *itemQuantityTextField;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ShoppingItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldInputChanged) name:UITextFieldTextDidChangeNotification object:_itemQuantityTextField];
}

- (void)setCellContentWithShoppingItem:(ShoppingItem *)item indexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    _itemNameLabel.text = item.itemName;
    _itemUnitNameLabel.text = item.itemUnitName;
    if (item.itemQuantity > 0) {
        _itemQuantityTextField.text = [@(item.itemQuantity) stringValue];
    } else {
        _itemQuantityTextField.text = @"0";
    }
}

#pragma mark - Notification Handler
- (void)textFieldInputChanged
{
    if ([self.delegate respondsToSelector:@selector(shoppingItemQuantityHasChangedWithIndexPath:quantity:)]) {
        [self.delegate shoppingItemQuantityHasChangedWithIndexPath:_indexPath quantity:[_itemQuantityTextField.text integerValue]];
    }
}


@end

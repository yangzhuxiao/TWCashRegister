//
//  ShoppingListViewController.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "ShoppingListViewController.h"
#import "Consts.h"
#import "ShoppingItem.h"

@interface ShoppingListViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *shoppingListLabel;

@end

@implementation ShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubviews];
    [self setUpFormattedTextWithContentDict:_shoppingListDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSubviews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    CGFloat btXMargin = 10.f;
    CGFloat btYMargin = 20.f;
    CGFloat btWidth = 60.f;
    CGFloat btHeight = 30.f;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(btXMargin, btYMargin, btWidth, btHeight)];
    backButton.backgroundColor = [UIColor blueColor];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [backButton setTitle:@"< 返回" forState:UIControlStateNormal];
    backButton.layer.cornerRadius = 3.f;
    [backButton addTarget:self action:@selector(backToSelectShoppingItemsPage) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:backButton];
    
    
    CGFloat lbXMargin = btXMargin;
    CGFloat lbYTopMargin = 60.f;
    CGFloat lbYBottomMargin = 20.f;
    _shoppingListLabel = [[UILabel alloc] initWithFrame:CGRectMake(lbXMargin, lbYTopMargin, SCREEN_WIDTH - 2*lbXMargin, SCREEN_HEIGHT - lbYTopMargin - lbYBottomMargin)];
    _shoppingListLabel.textColor = [UIColor darkGrayColor];
    _shoppingListLabel.font = [UIFont systemFontOfSize:10.f];
    _shoppingListLabel.numberOfLines = 0;
    [_scrollView addSubview:_shoppingListLabel];
    
}

- (void)setUpFormattedTextWithContentDict:(NSDictionary *)dict
{
    // 0:买二赠一 1:95折 2:95折
    NSString *itemsStringPart1 = @"***<没钱赚商店>购物清单***\n";
    __block NSString *itemsStringPart2 = nil;
    __block NSString *itemsStringPart3 = nil;
    
    __block CGFloat totalCost = 0;
    __block CGFloat savedCost = 0;

    NSMutableArray *oneFreeInEveryThreeItemsArray = [[NSMutableArray alloc] init];
    NSMutableArray *fivePercentDiscountItemsArray = [[NSMutableArray alloc] init];
    NSMutableArray *ordinaryItemsArray = [[NSMutableArray alloc] init];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock:^(ShoppingItem *obj, NSUInteger idx, BOOL *stop) {
            if (obj.itemQuantity > 0) {
                NSString *itemString = nil;
                if (obj.isOneFreeInEveryThree) {
                    NSInteger itemEffectiveNum = obj.itemQuantity - obj.itemQuantity/3;
                    CGFloat itemTotalCost = itemEffectiveNum * obj.itemPrice;
                    itemString = [NSString stringWithFormat:@"名称: %@, 数量: %ld%@, 单价: %.2f(元), 小计: %.2f(元)", obj.itemName, (long)obj.itemQuantity, obj.itemUnitName, obj.itemPrice, itemTotalCost];
                    [oneFreeInEveryThreeItemsArray addObject:itemString];
                    totalCost += itemTotalCost;
                } else if (obj.isFivePercentDiscount) {
                    CGFloat itemTotalCost = obj.itemQuantity * obj.itemPrice * 0.95;
                    itemString = [NSString stringWithFormat:@"名称: %@, 数量: %ld%@, 单价: %.2f(元), 小计: %.2f(元), 节省: %.2f(元)", obj.itemName, (long)obj.itemQuantity, obj.itemUnitName, obj.itemPrice, itemTotalCost, itemTotalCost/0.95*0.5];
                    [fivePercentDiscountItemsArray addObject:itemString];
                    totalCost += itemTotalCost;
                    savedCost += itemTotalCost/0.95*0.5;
                } else {
                    CGFloat itemTotalCost = obj.itemQuantity * obj.itemPrice;
                    itemString = [NSString stringWithFormat:@"名称: %@, 数量: %ld%@, 单价: %.2f(元), 小计: %.2f(元)", obj.itemName, (long)obj.itemQuantity, obj.itemUnitName, obj.itemPrice, itemTotalCost];
                    [ordinaryItemsArray addObject:itemString];
                    totalCost += itemTotalCost;
                }
            }
        }];
    }];
    
    // Part 1: All Items
    if (oneFreeInEveryThreeItemsArray.count > 0) {
        itemsStringPart1 = [itemsStringPart1 stringByAppendingString:[oneFreeInEveryThreeItemsArray componentsJoinedByString:@"\n"]];
        itemsStringPart1 = [itemsStringPart1 stringByAppendingString:@"\n"];
    }
    if (fivePercentDiscountItemsArray.count > 0) {
        itemsStringPart1 = [itemsStringPart1 stringByAppendingString:[fivePercentDiscountItemsArray componentsJoinedByString:@"\n"]];
        itemsStringPart1 = [itemsStringPart1 stringByAppendingString:@"\n"];
    }
    if (ordinaryItemsArray.count > 0) {
        itemsStringPart1 = [itemsStringPart1 stringByAppendingString:[ordinaryItemsArray componentsJoinedByString:@"\n"]];
        itemsStringPart1 = [itemsStringPart1 stringByAppendingString:@"\n"];
    }
    
    // Part 2: oneFreeInEveryThreeItems
    if (oneFreeInEveryThreeItemsArray.count > 0) {
        [oneFreeInEveryThreeItemsArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * stop) {
            NSMutableArray *partialArray = [[NSMutableArray alloc] init];
            [partialArray addObject:[obj componentsSeparatedByString:@", "][0]];
            [partialArray addObject:[obj componentsSeparatedByString:@", "][1]];
            
            if (!itemsStringPart2) {
                itemsStringPart2 = [partialArray componentsJoinedByString:@", "];
            } else {
                itemsStringPart2 = [itemsStringPart2 stringByAppendingString:[partialArray componentsJoinedByString:@", "]];
            }
            itemsStringPart2 = [itemsStringPart2 stringByAppendingString:@"\n"];
        }];
    }
    
    // Part 3: Total
    if (savedCost > 0) {
        itemsStringPart3 = [NSString stringWithFormat:@"总计: %.2f(元)\n节省: %.2f(元)\n**********************", totalCost, savedCost];
    } else {
        itemsStringPart3 = [NSString stringWithFormat:@"总计: %.2f(元)\n**********************", totalCost];
    }
    
    // combine the three parts together
    NSMutableArray *finalStringsArray = [[NSMutableArray alloc] init];
    [finalStringsArray addObject:itemsStringPart1];
    if (itemsStringPart2 != nil) {
        [finalStringsArray addObject:itemsStringPart2];
    }
    [finalStringsArray addObject:itemsStringPart3];
    
    _shoppingListLabel.text = [finalStringsArray componentsJoinedByString:@"----------------------\n"];
    
}

#pragma mark - Actions
- (void)backToSelectShoppingItemsPage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end

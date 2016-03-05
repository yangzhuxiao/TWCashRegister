//
//  ViewController.m
//  CashRegister
//
//  Created by 小柱 杨 on 3/5/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingItemTableViewCell.h"
#import "Apple.h"
#import "Badminton.h"
#import "Cocacola.h"
#import "Ultraman.h"
#import "Consts.h"
#import "ShoppingListViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ShoppingItemTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *shoppingItemsDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Badminton *badmintons = [[Badminton alloc] initWithBadmintonQuantity:0];
    Cocacola *cocacolas = [[Cocacola alloc] initWithCocacolaQuantity:0];
    Apple *apples = [[Apple alloc] initWithAppleQuantity:0];
    Ultraman *ultramen = [[Ultraman alloc] initWithUltramanQuantity:0];
    
    _shoppingItemsDict = [@{@0:@[badmintons, cocacolas], // 买二赠一
                            @1:@[apples], // 95折
                            @2:@[ultramen]} // 普通商品
                          mutableCopy];
    [self setUpTableFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shoppingItemsDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_shoppingItemsDict[@(section)] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShoppingItemTableViewCell class])];
    [cell setCellContentWithShoppingItem:_shoppingItemsDict[@(indexPath.section)][indexPath.row] indexPath:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24.f)];
    headerLb.font = [UIFont systemFontOfSize:14.f];
    headerLb.backgroundColor = [UIColor lightGrayColor];
    headerLb.textColor = [UIColor whiteColor];
    switch (section) {
        case 0:
            headerLb.text = @" 买二赠一区:";
            break;
        case 1:
            headerLb.text = @" 95折区:";
            break;
        case 2:
            headerLb.text = @" 普通商品区:";
            break;
        default:
            break;
    }
    return  headerLb;
}

#pragma mark - ShoppingItemTableViewCellDelegate
- (void)shoppingItemQuantityHasChangedWithIndexPath:(NSIndexPath *)indexPath quantity:(NSInteger)quantity
{
    ShoppingItem *selectedItem = _shoppingItemsDict[@(indexPath.section)][indexPath.row];
    selectedItem.itemQuantity = quantity;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - Actions
- (void)showShoppingList
{
    // go to show shopping list
    ShoppingListViewController *listVC = [[ShoppingListViewController alloc] init];
    listVC.shoppingListDict = _shoppingItemsDict;
    [self presentViewController:listVC animated:YES completion:NO];
}

#pragma mark - Private
- (void)setUpTableFooterView
{
    UIView *footerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.f)];
    footerContainer.backgroundColor = [UIColor whiteColor];
    
    CGFloat btXMargin = 20.f;
    CGFloat btYMargin = 8.f;
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(btXMargin, btYMargin, SCREEN_WIDTH - 2*btXMargin, footerContainer.frame.size.height - 2*btYMargin)];
    submitButton.backgroundColor = [UIColor blueColor];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [submitButton setTitle:@"提 交" forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 3.f;
    [submitButton addTarget:self action:@selector(showShoppingList) forControlEvents:UIControlEventTouchUpInside];
    [footerContainer addSubview:submitButton];
    
    self.tableView.tableFooterView = footerContainer;
}





@end

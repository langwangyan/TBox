//
//  TBBalanceViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/15.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBBalanceViewController.h"

@interface TBBalanceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;

@end

@implementation TBBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
    [self initBalanceView];
}
//初始化view
- (void) initBalanceView {
    //冻结保证金label
    self.balanceTipLabel.text = @"已冻结保证金";
    [self.balanceTipLabel setFrame:CGRectMake(20, 64+20, SCREEN_WIDTH-40, 30)];
    
    //保证金金额
    self.balanceNumLabel.text = [NSString stringWithFormat:@"￥%@",@"100000"];
    [self.balanceNumLabel setFrame:CGRectMake(20, self.balanceTipLabel.frame.origin.y+self.balanceTipLabel.frame.size.height+10, SCREEN_WIDTH-40, 30)];
    
    //充值保证金btn
    [self.rechargeBtn setTitle:@"余额充值" forState:UIControlStateNormal];
    [self.rechargeBtn setFrame:CGRectMake(30, self.balanceNumLabel.frame.origin.y+self.balanceNumLabel.frame.size.height+20, SCREEN_WIDTH-60, 40)];
    
    //余额提现btn
    [self.withdrawBtn setTitle:@"保证金提现" forState:UIControlStateNormal];
    [self.withdrawBtn setFrame:CGRectMake(30, self.rechargeBtn.frame.origin.y+self.rechargeBtn.frame.size.height+20, SCREEN_WIDTH-60, 40)];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"账户余额";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"账单" style:UIBarButtonItemStyleDone target:self action:@selector(showBillView)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.navigationController setNavigationBarHidden:NO];
}
//返回
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
//显示账单VC
- (void) showBillView{
    
}
//余额充值
- (IBAction)rechargeBtnOnclick:(id)sender {
}
//余额提现
- (IBAction)withdrawBtnOnclick:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  TBBondViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/15.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBBondViewController.h"

@interface TBBondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *frozenBondLabel;
@property (weak, nonatomic) IBOutlet UILabel *bondNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *bondTipLabel;
@property (weak, nonatomic) IBOutlet UIView *bondTipView;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBondBtn;
@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;

@end

@implementation TBBondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
    [self initBondView];
}

//初始化view
- (void) initBondView {
    //冻结保证金label
    self.frozenBondLabel.text = @"已冻结保证金";
    [self.frozenBondLabel setFrame:CGRectMake(20, 64+20, SCREEN_WIDTH-40, 30)];
    
    //保证金金额
    self.bondNumLabel.text = [NSString stringWithFormat:@"￥%@",@"100000"];
    [self.bondNumLabel setFrame:CGRectMake(20, self.frozenBondLabel.frame.origin.y+self.frozenBondLabel.frame.size.height+10, SCREEN_WIDTH-40, 30)];
    
    //保证金tip view
    [self.bondTipView setFrame:CGRectMake(0, self.bondNumLabel.frame.origin.y+self.bondNumLabel.frame.size.height+10, SCREEN_WIDTH, 50)];
    
    //保证金tip
    self.bondTipLabel.text = @"您还需要支付1500元保证金";
    [self.bondTipLabel setFrame:CGRectMake(20, 10, SCREEN_WIDTH, 30)];
    
    //充值保证金btn
    [self.rechargeBondBtn setTitle:@"充值保证金" forState:UIControlStateNormal];
    [self.rechargeBondBtn setFrame:CGRectMake(30, self.bondTipView.frame.origin.y+self.bondTipView.frame.size.height+20, SCREEN_WIDTH-60, 40)];
    
    //保证金提现btn
    [self.withdrawBtn setTitle:@"保证金提现" forState:UIControlStateNormal];
    [self.withdrawBtn setFrame:CGRectMake(30, self.rechargeBondBtn.frame.origin.y+self.rechargeBondBtn.frame.size.height+20, SCREEN_WIDTH-60, 40)];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"保证金";
    
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
- (IBAction)rechargeBtnOnclick:(id)sender {
}

- (IBAction)withdrawBtnOnclick:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

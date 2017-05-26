//
//  TBRechargeViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/9.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBRechargeViewController.h"

#define MARGIN 20.f

@interface TBRechargeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *moneyNumTF;
@property (weak, nonatomic) IBOutlet UIView *alipayView;
@property (weak, nonatomic) IBOutlet UIImageView *alipayImgView;
@property (weak, nonatomic) IBOutlet UILabel *alipayLabel;
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;


@property(nonatomic,strong) TBRegisterStatusView *registerView;
@end

@implementation TBRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
    [self initView];
}

//初始化view
-(void)initView {
    self.registerView = [[TBRegisterStatusView alloc]initWithStatus:4];
    [self.registerView setFrame:CGRectMake(0, 44+20, SCREEN_WIDTH, 60)];
    
    [self.view addSubview:self.registerView];
    
    [self.moneyNumTF setFrame:CGRectMake(MARGIN, self.registerView.frame.origin.y+self.registerView.frame.size.height+5, SCREEN_WIDTH-MARGIN*2, 30)];
    
    [self.alipayView setFrame:CGRectMake(0, self.moneyNumTF.frame.origin.y+self.moneyNumTF.frame.size.height+5, SCREEN_WIDTH, 70)];
    [self.alipayImgView setFrame:CGRectMake(MARGIN, 10, 50, 50)];
    [self.alipayLabel setFrame:CGRectMake(self.alipayImgView.frame.size.width+self.alipayImgView.frame.origin.x+MARGIN, 10, 50, 30)];
    [self.alipayBtn setFrame:CGRectMake(SCREEN_WIDTH-60-MARGIN, 10, 60, 30)];
    
    [self.rechargeBtn setFrame:CGRectMake((SCREEN_WIDTH-100)/2, self.alipayView.frame.size.height+self.alipayView.frame.origin.y+5, 100, 40)];
}

- (IBAction)alipayBtnOnclick:(id)sender {
}
- (IBAction)rechargeBtnOnclick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"充值押金";
    
    [self.navigationController setNavigationBarHidden:NO];
}

//返回
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
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

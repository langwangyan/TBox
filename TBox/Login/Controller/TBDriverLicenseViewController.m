//
//  TBDriverLicenseViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/9.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBDriverLicenseViewController.h"
#import "TBRechargeViewController.h"

#define MARGIN 20.f

@interface TBDriverLicenseViewController ()

@property (weak, nonatomic) IBOutlet UITextField *driverLicenseNumTF;

@property (weak, nonatomic) IBOutlet UITextField *archivesNumTF;
@property (weak, nonatomic) IBOutlet UILabel *driverLicenseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *registerImgView;
@property (weak, nonatomic) IBOutlet UIButton *registerDLTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@property(nonatomic,strong) TBRegisterStatusView *registerView;

@end

@implementation TBDriverLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
    [self initView];
}

//初始化view
-(void)initView {
    self.registerView = [[TBRegisterStatusView alloc]initWithStatus:3];
    [self.registerView setFrame:CGRectMake(0, 44+20, SCREEN_WIDTH, 60)];
    
    [self.view addSubview:self.registerView];
    
    [self.driverLicenseNumTF setFrame:CGRectMake(MARGIN, self.registerView.frame.origin.y+self.registerView.frame.size.height+5, SCREEN_WIDTH-MARGIN*2, 30)];
    [self.archivesNumTF setFrame:CGRectMake(MARGIN, self.driverLicenseNumTF.frame.origin.y+self.driverLicenseNumTF.frame.size.height+5, SCREEN_WIDTH-MARGIN*2, 30)];
    [self.driverLicenseLabel setFrame:CGRectMake((SCREEN_WIDTH-100)/2, self.archivesNumTF.frame.origin.y+self.archivesNumTF.frame.size.height+5, 100, 30)];
    [self.registerImgView setFrame:CGRectMake(MARGIN, self.driverLicenseLabel.frame.origin.y+self.driverLicenseLabel.frame.size.height+5, SCREEN_WIDTH-MARGIN*2, 150)];
    
    [self.registerDLTipLabel setFrame:CGRectMake((SCREEN_WIDTH-250)/2, self.registerImgView.frame.origin.y+self.registerImgView.frame.size.height+10, 250, 30)];
    
    [self.nextStepBtn setFrame:CGRectMake((SCREEN_WIDTH-100)/2, self.registerDLTipLabel.frame.size.height+self.registerDLTipLabel.frame.origin.y+5, 100, 40)];
}

- (IBAction)nextStepBtnOnclick:(id)sender {
    TBRechargeViewController *tbRechargeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_rechargeVC"];
    [self.navigationController pushViewController:tbRechargeVC animated:YES];
}

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"驾驶证验证";
    
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

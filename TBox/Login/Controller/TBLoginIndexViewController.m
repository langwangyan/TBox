//
//  TBLoginIndexViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/6.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBLoginIndexViewController.h"
#import "TBRegisterViewController.h"

#define MARGIN 20.f

@interface TBLoginIndexViewController ()

@property(nonatomic,strong) TBRegisterStatusView *registerView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *identityCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *generateIdentifyCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation TBLoginIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    [self initView];
}
- (IBAction)generateIdentifyCodeBtnOnclick:(id)sender {
}

- (IBAction)loginBtnClick:(id)sender {
    
    //登录成功，pop登录页面
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registerBtnClick:(id)sender {
    
    TBRegisterViewController *tbRegisterVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_registerVC"];
    [self.navigationController pushViewController:tbRegisterVC animated:YES];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"系统登录";
    
    [self.navigationController setNavigationBarHidden:NO];
}

//初始化view
-(void)initView {
    self.registerView = [[TBRegisterStatusView alloc]initWithStatus:0];
    [self.registerView setFrame:CGRectMake(0, 44+20, SCREEN_WIDTH, 60)];
    
    [self.view addSubview:self.registerView];
    
    [self.phoneNumTF setFrame:CGRectMake(MARGIN, self.registerView.frame.origin.y+self.registerView.frame.size.height+5, SCREEN_WIDTH-MARGIN*2, 30)];
    [self.identityCodeTF setFrame:CGRectMake(MARGIN, self.phoneNumTF.frame.origin.y+self.phoneNumTF.frame.size.height+5, SCREEN_WIDTH-MARGIN*3-100, 30)];
    [self.generateIdentifyCodeBtn setFrame:CGRectMake(MARGIN+self.identityCodeTF.frame.size.width+self.identityCodeTF.frame.origin.x, self.phoneNumTF.frame.origin.y+self.phoneNumTF.frame.size.height+5, 100, 30)];
    
    [self.loginBtn setFrame:CGRectMake(MARGIN*2, self.generateIdentifyCodeBtn.frame.size.height+self.generateIdentifyCodeBtn.frame.origin.y+5, 100, 30)];
    [self.registerBtn setFrame:CGRectMake(SCREEN_WIDTH-MARGIN*2-100, self.loginBtn.frame.origin.y, 100, 30)];

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

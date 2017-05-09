//
//  TBLoginIndexViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/6.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBLoginIndexViewController.h"
#import "TBRegisterViewController.h"

@interface TBLoginIndexViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *identityCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *generateIdentifyCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation TBLoginIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTopBar];
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

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"系统登录";
    
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

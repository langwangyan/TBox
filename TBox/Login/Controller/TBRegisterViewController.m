//
//  TBRegisterViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/6.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBRegisterViewController.h"
#import "TBIDCardVerficationViewController.h"

@interface TBRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *identityCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *generateIdentityCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitRegisterBtn;


@end

@implementation TBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
}
- (IBAction)generateIdentityCodeBtnOnClick:(id)sender {
}
- (IBAction)submitRegisterBtnOnclick:(id)sender {
    
    TBIDCardVerficationViewController *tbIDCardVerficationVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_iDCardVerficationVC"];
    [self.navigationController pushViewController:tbIDCardVerficationVC animated:YES];
}

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"用户注册";
    
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

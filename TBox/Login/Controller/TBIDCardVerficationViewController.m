//
//  TBIDCardVerficationViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/9.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBIDCardVerficationViewController.h"
#import "TBDriverLicenseViewController.h"

@interface TBIDCardVerficationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *trueNameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardVerficationTF;
@property (weak, nonatomic) IBOutlet UIImageView *idCardImgView;
@property (weak, nonatomic) IBOutlet UIButton *updateIDCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation TBIDCardVerficationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
}

- (IBAction)uploadIDCardBtnOnclick:(id)sender {
}

- (IBAction)nextStepBtnOnclick:(id)sender {
    TBDriverLicenseViewController *tbDriverLicenseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_driverLicenseVC"];
    [self.navigationController pushViewController:tbDriverLicenseVC animated:YES];
}

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"身份证验证";
    
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

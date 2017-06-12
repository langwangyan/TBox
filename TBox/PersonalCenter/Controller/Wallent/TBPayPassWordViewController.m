//
//  TBPayPassWordViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/15.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBPayPassWordViewController.h"

@interface TBPayPassWordViewController ()

@end

@implementation TBPayPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
}
//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"支付密码";
    
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

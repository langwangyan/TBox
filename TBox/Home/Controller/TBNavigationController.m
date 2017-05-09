//
//  TBNavigationController.m
//  TBox
//
//  Created by 王言 on 2017/4/26.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBNavigationController.h"

@interface TBNavigationController ()

@end

@implementation TBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.navigationBar.barTintColor = [UIColor colorWithRed:25/255. green:182/255. blue:160/255.0 alpha:1];
    //设置title文字的颜色
    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f], NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = dic;
    //设置left和right文字颜色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
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

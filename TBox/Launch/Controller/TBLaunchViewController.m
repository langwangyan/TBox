//
//  TBLaunchViewController.m
//  TBox
//
//  Created by 王言 on 2017/4/25.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBLaunchViewController.h"

@interface TBLaunchViewController ()

@property(nonatomic,strong) TBFirstView *firstView;
@property(nonatomic,strong) TBSecondView *secondView;

@end

@implementation TBLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self isAppFirstRun]) {
        //首次启动或更新安装
        self.firstView = [[TBFirstView alloc]initWithFrame:self.view.frame];
        
    }else {
        //第二次打开
        self.secondView = [[TBSecondView alloc]initWithFrame:self.view.frame];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) isAppFirstRun{
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunKey = [defaults objectForKey:@"last_run_version_key"];
    
    if (!lastRunKey) {
        //上次运行版本为空，说明程序第一次运行
        [defaults setObject:currentVersion forKey:@"last_run_version_key"];
        return YES;
    }else if (![lastRunKey isEqualToString:currentVersion]) {
        //有版本号，但是和当前版本号不同，说明程序已经更新了版本
        [defaults setObject:currentVersion forKey:@"last_run_version_key"];
        return YES;
    }
    return NO;
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

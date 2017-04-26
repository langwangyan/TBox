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
@property(nonatomic,strong) TBIndexView *indexView;
@end

@implementation TBLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self isAppFirstRun]) {
        //首次启动或更新安装
        NSArray *array = @[@"IMG_0123.JPG", @"IMG_0128.JPG", @"IMG_0132.JPG", @"IMG_0137.JPG"];
        [TBFirstView showGudieView:array];
        
    }else {
        //第二次打开
        self.secondView = [[TBSecondView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:self.secondView];

    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0.2 blue:0.4 alpha:1];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f], NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    
//    [NSThread sleepForTimeInterval:1.0f];
    
//    __weak typeof(self) weakSelf = self;
//    [UIView animateWithDuration:1.0 animations:^{
//        [weakSelf.firstView setHidden:YES];
//        [weakSelf.secondView setHidden:YES];
//        weakSelf.firstView = nil;
//        weakSelf.secondView = nil;
//        
//        [weakSelf.view addSubview:weakSelf.indexView];
////        [_indexView setFrame:CGRectMake(0, 100, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height)];
//    }];
    
    
}

- (TBIndexView *)indexView {
    if (!_indexView) {
        _indexView = [[TBIndexView alloc]initWithFrame:self.view.frame];
//        [_indexView setFrame:CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _indexView;
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

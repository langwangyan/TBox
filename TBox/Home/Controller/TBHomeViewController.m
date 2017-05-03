//
//  TBHomeViewController.m
//  TBox
//
//  Created by 王言 on 2017/4/25.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBHomeViewController.h"

@interface TBHomeViewController ()

@property(nonatomic,strong) TBFirstView *firstView;
@property(nonatomic,strong) TBSecondView *secondView;
@end

@implementation TBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initHomeVC];
    
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
    
}

/**初始化首页*/
- (void) initHomeVC {
    TBLeftViewController *leftVC = [[TBLeftViewController alloc] init];
    TBCenterViewController *centerVC = [[TBCenterViewController alloc] init];
    
    [leftVC.view setFrame:self.view.frame];
    
    [self setLeftControl:leftVC];
    [self setMainControl:centerVC];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setSpeedf:0.5];
    
    //点击视图是是否恢复位置
    self.sideslipTapGes.enabled = YES;
    
    //滑动手势
//    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
//    [self.mainControl.view addGestureRecognizer:pan];
    
    
    //单击手势
    self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
    [self.sideslipTapGes setNumberOfTapsRequired:1];
    
    [self.mainControl.view addGestureRecognizer:self.sideslipTapGes];
    
    self.leftControl.view.hidden = YES;
    [self.view addSubview:self.leftControl.view];
    [self.view addSubview:self.mainControl.view];
    
    //添加左滑button
    [self.view addSubview:self.showLeftBtn];
    
}


/**判断是App否为首次启动*/
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)showLeftBtn {
    if (!_showLeftBtn) {
        _showLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 100, 50)];
        [_showLeftBtn setTitle:@"点击显示左边" forState:UIControlStateNormal];
        [_showLeftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_showLeftBtn setBackgroundColor:[UIColor whiteColor]];
        [_showLeftBtn addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showLeftBtn;
}

#pragma mark - 滑动手势
//滑动手势
//- (void) handlePan: (UIPanGestureRecognizer *)rec{
//    
//    CGPoint point = [rec translationInView:self.view];
//    
//    self.scalef = (point.x*self.speedf+self.scalef);
//    
//    //根据视图位置判断是左滑还是右边滑动
//    rec.view.center = CGPointMake(rec.view.center.x + point.x*self.speedf,rec.view.center.y);
//    rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-self.scalef/1000,1.0);
//    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
//    
//    self.leftControl.view.hidden = NO;
//    
//    //手势结束后修正位置
//    if (rec.state == UIGestureRecognizerStateEnded) {
//        if (self.scalef>140*self.speedf){
//            [self showLeftView];
//        }else{
//            [self showMainView];
//            self.scalef = 0;
//        }
//    }
//    
//}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
        self.scalef = 0;
    }
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    self.leftControl.view.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    self.mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    self.leftControl.view.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    self.mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainControl.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    
}

#pragma mark 为了界面美观，所以隐藏了状态栏。如果需要显示则去掉此代码
- (BOOL)prefersStatusBarHidden
{
    return NO; //返回NO表示要显示，返回YES将hiden
}
@end

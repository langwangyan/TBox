//
//  TBHomeViewController.m
//  TBox
//
//  Created by 王言 on 2017/4/25.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBHomeViewController.h"
#import "TBLoginIndexViewController.h"

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
    
    self.centerVC = [[TBCenterViewController alloc] init];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setSpeedf:0.5];

    //单击手势
    self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
    [self.sideslipTapGes setNumberOfTapsRequired:1];
    
    [self.centerVC.view addGestureRecognizer:self.sideslipTapGes];
    
    [self.view addSubview:self.centerVC.view];
    [self.view addSubview:self.leftVC.view];
    
    //初始化页面按钮
    [self initTopBar];
    [self initBottomBar];
}

/**初始化顶部bar*/
- (void) initTopBar {
    //添加左滑button
    [self.view addSubview:self.showLeftBtn];
}

/**初始化底部bar*/
- (void) initBottomBar {
    //添加左滑button
    [self.view addSubview:self.orderCarBtn];
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

- (TBLeftViewController *)leftVC {
    if (!_leftVC) {
        _leftVC = [[TBLeftViewController alloc] init];
        [_leftVC.view setFrame:CGRectMake(-LEFTVIEW_WIDTH, 0, LEFTVIEW_WIDTH, SCREEN_HEIGHT)];
        
        //滑动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [_leftVC.view addGestureRecognizer:pan];
    }
    return _leftVC;
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

- (UIButton *)orderCarBtn {
    if (!_orderCarBtn) {
        _orderCarBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT-150, SCREEN_WIDTH/3, 50)];
        [_orderCarBtn setTitle:@"点击约车" forState:UIControlStateNormal];
        [_orderCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_orderCarBtn setBackgroundColor:[UIColor whiteColor]];
        [_orderCarBtn addTarget:self action:@selector(orderCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderCarBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击预约车辆按钮
- (void) orderCarBtnClick{
//    TBUser *user = [[TBUser alloc]init];
//    [user setUsername:@"王言"];
//    
//    [TBStoreDataUtil storeUser:user];
//    
    TBUser *user = [TBStoreDataUtil restoreUser];
    
    if (!user.username && [user.username isEqualToString:@""]) {
        //说明已经登录
        
    }else {
        //说明未登录
       TBLoginIndexViewController *tbLoginIndexVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_loginIndeVC"];
        [self showMainView];
        [self.navigationController pushViewController:tbLoginIndexVC animated:YES];
    }
}

#pragma mark - 滑动手势
//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    
    self.scalef = (point.x*self.speedf+self.scalef);
    
    //根据视图位置判断是左滑还是右边滑动
    if (self.leftVC.view.center.x<LEFTVIEW_WIDTH/2){
        rec.view.center = CGPointMake(rec.view.center.x + point.x*self.speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-self.scalef/1000,1.0);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (self.scalef>140*self.speedf){
            [self showLeftView];
        }else{
            [self showMainView];
            self.scalef = 0;
        }
    }
    
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self showMainView];
        self.scalef = 0;
    }
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.leftVC.view.center = CGPointMake(-LEFTVIEW_WIDTH/2,SCREEN_HEIGHT/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.leftVC.view.center = CGPointMake(LEFTVIEW_WIDTH/2,SCREEN_HEIGHT/2);
    [self.view bringSubviewToFront:self.leftVC.view];
    [UIView commitAnimations];
    
}

@end

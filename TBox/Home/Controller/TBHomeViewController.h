//
//  TBHomeViewController.h
//  TBox
//
//  Created by 王言 on 2017/4/25.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <UIKit/UIKit.h>
/**启动页*/
#import "TBFirstView.h"
#import "TBSecondView.h"

/**主页左侧和中间*/
#import "TBLeftViewController.h"
#import "TBCenterViewController.h"

@interface TBHomeViewController : UIViewController

@property(nonatomic,strong) UIButton *showLeftBtn;

@property(nonatomic,strong) TBLeftViewController *leftVC;
@property(nonatomic,strong) TBCenterViewController *centerVC;

@property(nonatomic,assign) CGFloat scalef;

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat speedf;

//是否允许点击视图恢复视图位置。默认为yes
@property (strong) UITapGestureRecognizer *sideslipTapGes;

//恢复位置
-(void)showMainView;

//显示左视图
-(void)showLeftView;

@end

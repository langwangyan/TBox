//
//  TBProgressUtil.m
//  TBox
//
//  Created by 王言 on 2017/5/16.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBProgressUtil.h"

@implementation TBProgressUtil

+(void)showToast2View:(UIView *)view WithMsg:(NSString *)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [view bringSubviewToFront:hud];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = msg;
    [hud.label setTextColor:[UIColor whiteColor]];
    
    hud.margin = 10.f;
    
    [hud setOffset:CGPointMake(0, 150.f)];
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

-(void) showLoading2View:(UIView *)view {
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    [view addSubview:self.hud];
    [view bringSubviewToFront:self.hud];
    
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    
    self.hud.label.text = @"加载中...";
    
}

-(void) showLoading2View:(UIView *)view msg:(NSString *)msg{
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    [view addSubview:self.hud];
    [view bringSubviewToFront:self.hud];
    
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    
    self.hud.label.text = msg;
    
}

-(void) hideLoadingView {
    [self.hud showAnimated:YES];
    [self.hud setHidden:YES];
}

@end

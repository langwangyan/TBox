//
//  TBProgressUtil.h
//  TBox
//
//  Created by 王言 on 2017/5/16.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface TBProgressUtil : NSObject

@property(nonatomic,weak) MBProgressHUD *hud;

+(void)showToast2View:(UIView *)view WithMsg:(NSString *)msg;

-(void)showLoading2View:(UIView *) view;

-(void) hideLoadingView;

-(void) showLoading2View:(UIView *)view msg:(NSString *)msg;

@end

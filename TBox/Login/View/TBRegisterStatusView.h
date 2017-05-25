//
//  TBRegisterStatusView.h
//  TBox
//
//  Created by 王言 on 2017/5/19.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBRegisterStatusView : UIView

@property(nonatomic,strong) UIButton *phoneBtn;
@property(nonatomic,strong) UIImageView *arrowImgView1;
@property(nonatomic,strong) UIImageView *arrowImgView2;
@property(nonatomic,strong) UIImageView *arrowImgView3;
@property(nonatomic,strong) UIImageView *arrowImgView4;
@property(nonatomic,strong) UIButton *uploadIDBtn;
@property(nonatomic,strong) UIButton *uploadDLBtn;
@property(nonatomic,strong) UIButton *rechargeBtn;
@property(nonatomic,strong) UIButton *startDLBtn;

-(instancetype) initWithStatus:(NSInteger)status;

@end

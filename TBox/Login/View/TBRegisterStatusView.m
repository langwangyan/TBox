//
//  TBRegisterStatusView.m
//  TBox
//
//  Created by 王言 on 2017/5/19.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBRegisterStatusView.h"
#define BUTTON_Font [UIFont systemFontOfSize:11]
#define TOP_MARGIN 10.f
#define BUTTON_WIDTH 60.f
#define BUTTON_HEIGHT 35.f
#define ARROW_WIDTH 25.f
#define ARROW_HEIGHT 10.f
#define PADDING 10.f

#define LEFT_MARGIN (SCREEN_WIDTH-5*BUTTON_WIDTH-4*(ARROW_WIDTH-2*PADDING))/2

@implementation TBRegisterStatusView

- (void)layoutSubviews {
    [super layoutSubviews];

}

-(instancetype) initWithStatus:(NSInteger)status {
    self = [super init];
    
    switch (status) {
        case 0:
            [self.phoneBtn setImage:[UIImage imageNamed:@"login_phone_1"] forState:UIControlStateNormal];
            [self.uploadIDBtn setImage:[UIImage imageNamed:@"login_upload_ID_1"] forState:UIControlStateNormal];
            [self.uploadDLBtn setImage:[UIImage imageNamed:@"login_upload_DL_1"] forState:UIControlStateNormal];
            [self.rechargeBtn setImage:[UIImage imageNamed:@"login_deposit_1"] forState:UIControlStateNormal];
            [self.startDLBtn setImage:[UIImage imageNamed:@"login_start_1"] forState:UIControlStateNormal];
            break;
        case 1:
            [self.phoneBtn setImage:[UIImage imageNamed:@"login_phone_2"] forState:UIControlStateNormal];
            [self.uploadIDBtn setImage:[UIImage imageNamed:@"login_upload_ID_1"] forState:UIControlStateNormal];
            [self.uploadDLBtn setImage:[UIImage imageNamed:@"login_upload_DL_1"] forState:UIControlStateNormal];
            [self.rechargeBtn setImage:[UIImage imageNamed:@"login_deposit_1"] forState:UIControlStateNormal];
            [self.startDLBtn setImage:[UIImage imageNamed:@"login_start_1"] forState:UIControlStateNormal];
            break;
        case 2:
            [self.phoneBtn setImage:[UIImage imageNamed:@"login_phone_3"] forState:UIControlStateNormal];
            [self.uploadIDBtn setImage:[UIImage imageNamed:@"login_upload_ID_2"] forState:UIControlStateNormal];
            [self.uploadDLBtn setImage:[UIImage imageNamed:@"login_upload_DL_1"] forState:UIControlStateNormal];
            [self.rechargeBtn setImage:[UIImage imageNamed:@"login_deposit_1"] forState:UIControlStateNormal];
            [self.startDLBtn setImage:[UIImage imageNamed:@"login_start_1"] forState:UIControlStateNormal];
            break;
        case 3:
            [self.phoneBtn setImage:[UIImage imageNamed:@"login_phone_3"] forState:UIControlStateNormal];
            [self.uploadIDBtn setImage:[UIImage imageNamed:@"login_upload_ID_3"] forState:UIControlStateNormal];
            [self.uploadDLBtn setImage:[UIImage imageNamed:@"login_upload_DL_2"] forState:UIControlStateNormal];
            [self.rechargeBtn setImage:[UIImage imageNamed:@"login_deposit_1"] forState:UIControlStateNormal];
            [self.startDLBtn setImage:[UIImage imageNamed:@"login_start_1"] forState:UIControlStateNormal];
            break;
        case 4:
            [self.phoneBtn setImage:[UIImage imageNamed:@"login_phone_3"] forState:UIControlStateNormal];
            [self.uploadIDBtn setImage:[UIImage imageNamed:@"login_upload_ID_3"] forState:UIControlStateNormal];
            [self.uploadDLBtn setImage:[UIImage imageNamed:@"login_upload_DL_3"] forState:UIControlStateNormal];
            [self.rechargeBtn setImage:[UIImage imageNamed:@"login_deposit_2"] forState:UIControlStateNormal];
            [self.startDLBtn setImage:[UIImage imageNamed:@"login_start_1"] forState:UIControlStateNormal];
            break;
        case 5:
            [self.phoneBtn setImage:[UIImage imageNamed:@"login_phone_3"] forState:UIControlStateNormal];
            [self.uploadIDBtn setImage:[UIImage imageNamed:@"login_upload_ID_3"] forState:UIControlStateNormal];
            [self.uploadDLBtn setImage:[UIImage imageNamed:@"login_upload_DL_3"] forState:UIControlStateNormal];
            [self.rechargeBtn setImage:[UIImage imageNamed:@"login_deposit_3"] forState:UIControlStateNormal];
            [self.startDLBtn setImage:[UIImage imageNamed:@"login_start_2"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    [self addSubview:self.phoneBtn];
    [self addSubview:self.arrowImgView1];
    [self addSubview:self.uploadIDBtn];
    [self addSubview:self.arrowImgView2];
    [self addSubview:self.uploadDLBtn];
    [self addSubview:self.arrowImgView3];
    [self addSubview:self.rechargeBtn];
    [self addSubview:self.arrowImgView4];
    [self addSubview:self.startDLBtn];
    
    return self;
}

- (UIButton *)phoneBtn {
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(LEFT_MARGIN, TOP_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_phoneBtn setTitle:@"手机验证" forState:UIControlStateNormal];
        [_phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_phoneBtn.titleLabel setFont:BUTTON_Font];
        [_phoneBtn setImage:[UIImage imageNamed:@"login_phone_2"] forState:UIControlStateNormal];
        
        _phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        
        [_phoneBtn setTitleEdgeInsets:UIEdgeInsetsMake(_phoneBtn.imageView.frame.size.height+10 ,-_phoneBtn.imageView.frame.size.width, 0.0,0.0)];
        
        CGFloat padding = (BUTTON_WIDTH-_phoneBtn.imageView.frame.size.width)/2;
        [_phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, padding,0.0,padding)];
    }
    return _phoneBtn;
}

- (UIButton *)uploadIDBtn {
    if (!_uploadIDBtn) {
        _uploadIDBtn = [[UIButton alloc]initWithFrame:CGRectMake(LEFT_MARGIN+BUTTON_WIDTH+ARROW_WIDTH-2*PADDING, TOP_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_uploadIDBtn setTitle:@"上传身份证" forState:UIControlStateNormal];
        [_uploadIDBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_uploadIDBtn.titleLabel setFont:BUTTON_Font];
        [_uploadIDBtn setImage:[UIImage imageNamed:@"login_upload_ID_2"] forState:UIControlStateNormal];
        
        _uploadIDBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        
        [_uploadIDBtn setTitleEdgeInsets:UIEdgeInsetsMake(_uploadIDBtn.imageView.frame.size.height+10 ,-_uploadIDBtn.imageView.frame.size.width, 0.0,0.0)];
        
        CGFloat padding = (BUTTON_WIDTH-_uploadIDBtn.imageView.frame.size.width)/2;
        [_uploadIDBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, padding,0.0,padding)];
    }
    return _uploadIDBtn;
}

- (UIButton *)uploadDLBtn {
    if (!_uploadDLBtn) {
        _uploadDLBtn = [[UIButton alloc]initWithFrame:CGRectMake(LEFT_MARGIN+2*BUTTON_WIDTH+2*ARROW_WIDTH-4*PADDING, TOP_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_uploadDLBtn setTitle:@"上传驾驶证" forState:UIControlStateNormal];
        [_uploadDLBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_uploadDLBtn.titleLabel setFont:BUTTON_Font];
        [_uploadDLBtn setImage:[UIImage imageNamed:@"login_upload_DL_2"] forState:UIControlStateNormal];
        
        _uploadDLBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        
        [_uploadDLBtn setTitleEdgeInsets:UIEdgeInsetsMake(_uploadDLBtn.imageView.frame.size.height+10 ,-_uploadDLBtn.imageView.frame.size.width, 0.0,0.0)];
        
        CGFloat padding = (BUTTON_WIDTH-_uploadDLBtn.imageView.frame.size.width)/2;
        [_uploadDLBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, padding,0.0,padding)];
    }
    return _uploadDLBtn;
}

- (UIButton *)rechargeBtn {
    if (!_rechargeBtn) {
        _rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(LEFT_MARGIN+3*BUTTON_WIDTH+3*ARROW_WIDTH-6*PADDING, TOP_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_rechargeBtn setTitle:@"押金充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rechargeBtn.titleLabel setFont:BUTTON_Font];
        [_rechargeBtn setImage:[UIImage imageNamed:@"login_deposit_2"] forState:UIControlStateNormal];
        
        _rechargeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        
        [_rechargeBtn setTitleEdgeInsets:UIEdgeInsetsMake(_rechargeBtn.imageView.frame.size.height+10 ,-_rechargeBtn.imageView.frame.size.width, 0.0,0.0)];
        
        CGFloat padding = (BUTTON_WIDTH-_rechargeBtn.imageView.frame.size.width)/2;
        [_rechargeBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, padding,0.0,padding)];
    }
    return _rechargeBtn;
}

- (UIButton *)startDLBtn {
    if (!_startDLBtn) {
        _startDLBtn = [[UIButton alloc]initWithFrame:CGRectMake(LEFT_MARGIN+4*BUTTON_WIDTH+4*ARROW_WIDTH-8*PADDING, TOP_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_startDLBtn setTitle:@"开始用车" forState:UIControlStateNormal];
        [_startDLBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startDLBtn.titleLabel setFont:BUTTON_Font];
        [_startDLBtn setImage:[UIImage imageNamed:@"login_start_2"] forState:UIControlStateNormal];
        
        _startDLBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        
        [_startDLBtn setTitleEdgeInsets:UIEdgeInsetsMake(_startDLBtn.imageView.frame.size.height+10 ,-_startDLBtn.imageView.frame.size.width, 0.0,0.0)];
        
        CGFloat padding = (BUTTON_WIDTH-_startDLBtn.imageView.frame.size.width)/2;
        [_startDLBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, padding,0.0,padding)];
    }
    return _startDLBtn;
}

- (UIImageView *)arrowImgView1 {
    if (!_arrowImgView1) {
        _arrowImgView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_arrow"]];
        [_arrowImgView1 setFrame:CGRectMake(LEFT_MARGIN+BUTTON_WIDTH-PADDING, TOP_MARGIN+(BUTTON_HEIGHT-ARROW_HEIGHT)/2, ARROW_WIDTH, ARROW_HEIGHT)];
    }
    return _arrowImgView1;
}

- (UIImageView *)arrowImgView2 {
    if (!_arrowImgView2) {
        _arrowImgView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_arrow"]];
        [_arrowImgView2 setFrame:CGRectMake(LEFT_MARGIN+BUTTON_WIDTH*2+ARROW_WIDTH-3*PADDING, TOP_MARGIN+(BUTTON_HEIGHT-ARROW_HEIGHT)/2, ARROW_WIDTH, ARROW_HEIGHT)];
    }
    return _arrowImgView2;
}

- (UIImageView *)arrowImgView3 {
    if (!_arrowImgView3) {
        _arrowImgView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_arrow"]];
        [_arrowImgView3 setFrame:CGRectMake(LEFT_MARGIN+BUTTON_WIDTH*3+2*ARROW_WIDTH-5*PADDING, TOP_MARGIN+(BUTTON_HEIGHT-ARROW_HEIGHT)/2, ARROW_WIDTH, ARROW_HEIGHT)];
    }
    return _arrowImgView3;
}

- (UIImageView *)arrowImgView4 {
    if (!_arrowImgView4) {
        _arrowImgView4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_arrow"]];
        [_arrowImgView4 setFrame:CGRectMake(LEFT_MARGIN+BUTTON_WIDTH*4+3*ARROW_WIDTH-7*PADDING, TOP_MARGIN+(BUTTON_HEIGHT-ARROW_HEIGHT)/2, ARROW_WIDTH, ARROW_HEIGHT)];
    }
    return _arrowImgView4;
}

@end

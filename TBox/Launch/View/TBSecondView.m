//
//  TBSecondView.m
//  TBox
//
//  Created by 王言 on 2017/4/25.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBSecondView.h"
#import "BFKit.h"

@implementation TBSecondView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor blackColor]];
    
    float screen_width  = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:frame];
    img.image=[UIImage imageNamed:@"IMG_0123.JPG"];
    
    [self addSubview:img];
    
    CGRect skiprect = CGRectMake(screen_width - 70, 25, 45, 26);
    
    UIButton *passbtn = [[UIButton alloc] initWithFrame:skiprect];
    [passbtn createBordersWithColor:[UIColor whiteColor] withCornerRadius:7 andWidth:1];
    [passbtn addTarget:self action:@selector(dismissGuideView) forControlEvents:(UIControlEventTouchUpInside)];
    passbtn.backgroundColor = [UIColor clearColor];
    [passbtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [passbtn setTitleColor:[UIColor whiteColor]];
    NSString *title = @"跳过";
    [passbtn setTitle:title forState:(UIControlStateNormal)];
    
    [self addSubview:passbtn];
    
    return self;
}

-(void)dismissGuideView {
    [UIView animateWithDuration:0.6f animations:^{
        //发出notification
        [[NSNotificationCenter defaultCenter] postNotificationName:TB_LANUCH_NF_NAME object:self userInfo:nil];
        
        //让scrollview 渐变消失
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

@end

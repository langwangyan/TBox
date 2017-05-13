//
//  TBShareViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/13.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBShareViewController.h"

@interface TBShareViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareContastLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end

@implementation TBShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    [self initVC];
}

- (IBAction)shareBtnOnclick:(id)sender {
    
}

/**初始化view*/
- (void) initVC {
    //初始化topImageView
    [self.topImageView setImage:[UIImage imageNamed:@"IMG_0123.JPG"]];
    [self.topImageView setFrame:CGRectMake(20, 64+20, SCREEN_WIDTH-40, 200)];
    //初始化introLabel
    self.introLabel.text = @"分享给好友，TA可以在注册时填入您的邀请码，注册认证成功，您和好友均可获得30元优惠券";
    [self.introLabel setFrame:CGRectMake(20, self.topImageView.frame.origin.y+self.topImageView.frame.size.height+20, SCREEN_WIDTH-40, 80)];
    //初始化shareContastLabel
    self.shareContastLabel.text = @"您的邀请码为：";
    [self.shareContastLabel setFrame:CGRectMake((SCREEN_WIDTH-240)/2, self.introLabel.frame.origin.y+100+20, 200, 30)];
    //初始化邀请码shareCodeLabel
    self.shareCodeLabel.text = @"U3KFBI";
    [self.shareCodeLabel setFrame:CGRectMake((SCREEN_WIDTH-140)/2, self.shareContastLabel.frame.origin.y+self.shareContastLabel.frame.size.height+20, 100, 30)];
    //初始化shareBtn
    [self.shareBtn setFrame:CGRectMake(20, self.shareCodeLabel.frame.origin.y+self.shareCodeLabel.frame.size.height+20, SCREEN_WIDTH-40, 40)];
    self.shareBtn.layer.cornerRadius = 15;
}

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"分享有礼";
    
    [self.navigationController setNavigationBarHidden:NO];
}
//返回
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

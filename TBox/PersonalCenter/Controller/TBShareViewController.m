//
//  TBShareViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/13.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBShareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define SHARECODE_API @"share"

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
    [self initShareCode];
}

- (IBAction)shareBtnOnclick:(id)sender {
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"login_start_2"],[UIImage imageNamed:@"login_start_2"],[UIImage imageNamed:@"login_start_2"],[UIImage imageNamed:@"login_start_2"],[UIImage imageNamed:@"login_start_2"]];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:imageArray url:[NSURL URLWithString:@"http://mob.com"] title:@"分享标题" type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
//        // 定制新浪微博的分享内容
//        [shareParams SSDKSetupSinaWeiboShareParamsByText:@"定制新浪微博的分享内容"                                       title:nil image:[UIImage imageNamed:@"login_start_2"] url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
//        
//        // 定制微信好友的分享内容
//        [shareParams SSDKSetupWeChatParamsByText:@"定制微信的分享内容" title:@"title" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:nil image:[UIImage imageNamed:@"login_start_1"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];// 微信好友子平台

        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet: nil//要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
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
    [self.shareCodeLabel setFrame:CGRectMake((SCREEN_WIDTH-140)/2, self.shareContastLabel.frame.origin.y+self.shareContastLabel.frame.size.height+20, 100, 30)];
    //初始化shareBtn
    [self.shareBtn setFrame:CGRectMake(20, self.shareCodeLabel.frame.origin.y+self.shareCodeLabel.frame.size.height+20, SCREEN_WIDTH-40, 40)];
    self.shareBtn.layer.cornerRadius = 15;
}

/**获取邀请码*/
- (void) initShareCode {
    //获取短信验证码
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_PRE_URL, SHARECODE_API];
    TBUser *user = [TBStoreDataUtil restoreUser];;
    NSDictionary *dict =@{@"userId":user.userId};
    __weak typeof(self) weakself = self;
    
    // 写请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 接收的输入类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    TBProgressUtil *tb_progress = [[TBProgressUtil alloc]init];
    [tb_progress showLoading2View:self.view];
    //post请求
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *responseCode = [NSString stringWithFormat:@"%@", responseDict[@"code"]];
        if (responseDict && [responseCode isEqualToString:@"200"]) {
            
            NSDictionary *dataDict = responseDict[@"data"];
            
            
            self.shareCodeLabel.text = @"U3KFBI";
            
        }else {
            [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
            
            [weakself.navigationController popViewControllerAnimated:YES];
            
        }
        
        [tb_progress hideLoadingView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [TBProgressUtil showToast2View:weakself.view WithMsg:error.description];
//        [weakself.navigationController popViewControllerAnimated:YES];
        
        [tb_progress hideLoadingView];
    }];
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

@end

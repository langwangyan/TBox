//
//  TBFeedBackViewController.m
//  TBox
//
//  Created by 王言 on 2017/6/12.
//  Copyright © 2017年 tbox. All rights reserved.
//

#define FEEDBACK_API @"saveFeedback"

#import "TBFeedBackViewController.h"

@interface TBFeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userInfoTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation TBFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
    [self initView];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"意见反馈";
    
    [self.navigationController setNavigationBarHidden:NO];
}
//返回
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
//初始化view
- (void) initView {
    self.userInfoTF.layer.borderWidth = 1.0f;
    self.userInfoTF.layer.cornerRadius = 5;
    self.userInfoTF.layer.borderColor = [UIColor colorWithRed:14/255.0 green:174/255.0 blue:131/255.0 alpha:1].CGColor;
    [self.userInfoTF setFrame:CGRectMake(40, 44+30, SCREEN_WIDTH-80, 40)];
    self.contentTV.layer.borderWidth = 1.0f;
    self.contentTV.layer.cornerRadius = 5;
    self.contentTV.layer.borderColor = [UIColor colorWithRed:14/255.0 green:174/255.0 blue:131/255.0 alpha:1].CGColor;
    [self.contentTV setFrame:CGRectMake(40, 44+30+40+20, SCREEN_WIDTH-80, 150)];
    
    [self.submitBtn setFrame:CGRectMake((SCREEN_WIDTH-100)/2, self.contentTV.frame.origin.y+150+20, 100, 40)];
    [self.submitBtn setBackgroundColor:[UIColor colorWithRed:231/255.0 green:111/255.0 blue:8/255.0 alpha:.8]];
    self.submitBtn.clipsToBounds = YES;
    self.submitBtn.layer.cornerRadius=15;
    [self.submitBtn addTarget:self action:@selector(submitFeedback) forControlEvents:UIControlEventTouchUpInside];
}

//提交用户反馈
-(void) submitFeedback {
    if (!self.contentTV.text || [self.contentTV.text isEqualToString:@""]) {
        [TBProgressUtil showToast2View:self.view WithMsg:@"亲，反馈内容不能为空哦~"];
    }else {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_PRE_URL, FEEDBACK_API];
        
        TBUser *user = [TBStoreDataUtil restoreUser];;
        NSDictionary *dict =@{@"userId":user.userId,@"content":self.contentTV.text};
        __weak typeof(self) weakself = self;
        
        // 写请求对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 接收的输入类型
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        TBProgressUtil *tb_progress = [[TBProgressUtil alloc]init];
        [tb_progress showLoading2View:self.view msg:@"提交中..."];
        //post请求
        [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSString *responseCode = [NSString stringWithFormat:@"%@", responseDict[@"code"]];
            if (responseDict && [responseCode isEqualToString:@"200"]) {
                
                NSDictionary *dataDict = responseDict[@"data"];
                
                [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
            }else {
                [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
                
                [weakself.navigationController popViewControllerAnimated:YES];
                
            }
            
            [tb_progress hideLoadingView];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [TBProgressUtil showToast2View:weakself.view WithMsg:error.description];
            
            [tb_progress hideLoadingView];
        }];
    }
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

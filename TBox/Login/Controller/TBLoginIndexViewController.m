//
//  TBLoginIndexViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/6.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBLoginIndexViewController.h"
#import "TBRegisterViewController.h"

#define MARGIN 20.f
#define GET_SMS_CODE @"getSMSCode"
#define LOGIN @"login"

@interface TBLoginIndexViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *identityCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *generateIdentifyCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property(nonatomic,strong) TBUser *user;

@end

@implementation TBLoginIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    [self initView];
}
- (IBAction)generateIdentifyCodeBtnOnclick:(id)sender {
    __weak typeof(self) weakself = self;
    
    //获取验证码url
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_PRE_URL,GET_SMS_CODE];
    NSDictionary *dict =@{@"mobile":self.phoneNumTF.text};
    
    // 写请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 接收的输入类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //post请求
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSString *responseCode = [NSString stringWithFormat:@"%@", responseDict[@"code"]];
        if (responseDict && [responseCode isEqualToString:@"200"]) {
            
            NSDictionary *dataDict = responseDict[@"data"];
            
            [TBProgressUtil showToast2View:weakself.view WithMsg:@"验证码获取成功！"];
            
        }else {
            
            [TBProgressUtil showToast2View:weakself.view WithMsg:dict[@"message"]];
        }
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [TBProgressUtil showToast2View:weakself.view WithMsg:error.description];
    }];
}

- (IBAction)loginBtnClick:(id)sender {
    __weak typeof(self) weakself = self;
    
    //获取验证码url
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_PRE_URL,LOGIN];
    NSDictionary *dict =@{@"mobile":self.phoneNumTF.text,@"checkCode":self.identityCodeTF.text};
    
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
            
            [weakself.user setUserId:dataDict[@"userId"]];
            
            [weakself.user setIdCardAuthStatus:dataDict[@"idCardAuthStatus"]];
            [weakself.user setDrivingAuthStatus:dataDict[@"drivingAuthStatus"]];
            [weakself.user setBikeDeposit:dataDict[@"bikeDeposit"]];
            [weakself.user setCarDeposit:dataDict[@"carDeposit"]];
            [weakself.user setPaidDepositAmount:dataDict[@"paidDepositAmount"]];
            [weakself.user setGrade:dataDict[@"grade"]];
            
            [TBStoreDataUtil storeUser:weakself.user];
            
            [tb_progress hideLoadingView];
            
            //登录成功，pop登录页面
            [weakself.navigationController popViewControllerAnimated:YES];
            
        }else {
            [tb_progress hideLoadingView];
            
            [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [tb_progress hideLoadingView];
        
        [TBProgressUtil showToast2View:weakself.view WithMsg:error.description];
    }];
    
}
- (IBAction)registerBtnClick:(id)sender {
    
    TBRegisterViewController *tbRegisterVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_registerVC"];
    [self.navigationController pushViewController:tbRegisterVC animated:YES];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"用户登录";
    
    [self.navigationController setNavigationBarHidden:NO];
}

//初始化view
-(void)initView {
    self.generateIdentifyCodeBtn.layer.cornerRadius = 8;
    self.loginBtn.layer.cornerRadius = 10;
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

//
//  TBRegisterViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/6.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBRegisterViewController.h"
#import "TBIDCardVerficationViewController.h"

#define MARGIN 20.f
#define GET_SMS_CODE @"getSMSCode"

@interface TBRegisterViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *identityCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;
@property (weak, nonatomic) IBOutlet UIButton *generateIdentityCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitRegisterBtn;

@property(nonatomic,strong) TBRegisterStatusView *registerView;
@property(nonatomic,strong) UIAlertView *alertView;

@end

@implementation TBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
    [self initView];
    
    self.alertView.delegate = self;
}

//初始化view
-(void)initView {
    self.registerView = [[TBRegisterStatusView alloc]initWithStatus:1];
    [self.registerView setFrame:CGRectMake(0, 44+20, SCREEN_WIDTH, 60)];
    
    [self.view addSubview:self.registerView];
    
    [self.phoneNumTF setFrame:CGRectMake(MARGIN, self.registerView.frame.origin.y+self.registerView.frame.size.height+5, SCREEN_WIDTH-MARGIN*2, 30)];
    [self.identityCodeTF setFrame:CGRectMake(MARGIN, self.phoneNumTF.frame.origin.y+self.phoneNumTF.frame.size.height+5, SCREEN_WIDTH-MARGIN*3-100, 30)];
    [self.generateIdentityCodeBtn setFrame:CGRectMake(MARGIN+self.identityCodeTF.frame.size.width+self.identityCodeTF.frame.origin.x, self.phoneNumTF.frame.origin.y+self.phoneNumTF.frame.size.height+5, 100, 30)];
    
    [self.inviteCodeTF setFrame:CGRectMake(MARGIN, self.identityCodeTF.frame.origin.y+self.identityCodeTF.frame.size.height+5, SCREEN_WIDTH-MARGIN*3-100, 30)];
    
    [self.chooseLabel setFrame:CGRectMake(MARGIN+self.inviteCodeTF.frame.size.width+self.inviteCodeTF.frame.origin.x, self.identityCodeTF.frame.origin.y+self.identityCodeTF.frame.size.height+5, 100, 30)];
    
    [self.submitRegisterBtn setFrame:CGRectMake((SCREEN_WIDTH-100)/2, self.inviteCodeTF.frame.size.height+self.inviteCodeTF.frame.origin.y+5, 100, 30)];
}

- (IBAction)generateIdentityCodeBtnOnClick:(id)sender {
    //获取短信验证码
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
        NSLog(@" %@",responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
- (IBAction)submitRegisterBtnOnclick:(id)sender {
//    TBIDCardVerficationViewController *tbIDCardVerficationVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_iDCardVerficationVC"];
//    [self.navigationController pushViewController:tbIDCardVerficationVC animated:YES];
    
    __weak typeof(self) weakself = self;

    //注册url
    NSString *urlStr = [NSString stringWithFormat:@"%@register",API_PRE_URL];
    NSDictionary *dict =@{@"mobile":self.phoneNumTF.text,@"checkCode":self.identityCodeTF.text};
    
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
            TBUser *user = [[TBUser alloc]init];
            [user setUserId:dataDict[@"userId"]];
            [user setMobile:self.phoneNumTF.text];
            
            [TBStoreDataUtil storeUser:user];
            
            TBIDCardVerficationViewController *tbIDCardVerficationVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_iDCardVerficationVC"];
            [weakself.navigationController pushViewController:tbIDCardVerficationVC animated:YES];
        }else {
            weakself.alertView = [[UIAlertView alloc]initWithTitle:@"注册失败" message:responseDict[@"message"] delegate:weakself cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [weakself.alertView show];
            
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        weakself.alertView = [[UIAlertView alloc]initWithTitle:@"注册失败" message:@"注册失败，请稍后重试" delegate:weakself cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [weakself.alertView show];
        
    }];
}

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"用户注册";
    
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

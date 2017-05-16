//
//  TBWallentViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/13.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBWallentViewController.h"
#import "TBBondViewController.h"
#import "TBBalanceViewController.h"
#import "TBCouponViewController.h"
#import "TBPayPassWordViewController.h"

#define WALLENT_API @"getMyWallet"

@interface TBWallentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *menuArray;
@property(nonatomic,strong) NSArray *rightStrArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TBWallentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initTableView];
}

//初始化data
-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"保证金",@"账户余额",@"优惠卡券",@"支付密码", nil];
    //获取短信验证码
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_PRE_URL,WALLENT_API];
    TBUser *user = [TBStoreDataUtil restoreUser];
    NSDictionary *dict =@{@"userId":user.userId};
    __weak typeof(self) weakself = self;
    
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
            _rightStrArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"￥%@",dataDict[@"deposit"]],[NSString stringWithFormat:@"￥%@",dataDict[@"balance"]],[NSString stringWithFormat:@"%@张",dataDict[@"couponNum"]], nil];
        }else {
            [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
            _rightStrArray = [NSArray arrayWithObjects:@"￥0",@"￥0",@"0张", nil];
        }
        
        [weakself.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [TBProgressUtil showToast2View:weakself.view WithMsg:error.description];
    }];

}
//初始化tableView
-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"我的钱包";
    
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
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TABLE_VIEW_ID = @"wallent_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_VIEW_ID];
    }
    NSString *cellStr = [_menuArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.textLabel.text = cellStr;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    UILabel *rightLabel = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
    rightLabel.font = [UIFont boldSystemFontOfSize:15];
    [rightLabel sizeToFit];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.frame =CGRectMake(SCREEN_WIDTH - 80 - 10,12, 80, 23);
    
    [cell.contentView addSubview:rightLabel];
    rightLabel.textColor = [UIColor orangeColor];
    
    if ([cellStr isEqualToString:@"支付密码"]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }else {
        rightLabel.text = self.rightStrArray[indexPath.row];
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击之后去掉灰色背景
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_menuArray[indexPath.row] isEqualToString:@"保证金"]) {
        
        TBBondViewController *bondVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_bondVC"];
        
        [self.navigationController pushViewController:bondVC animated:YES];

    }else if ([_menuArray[indexPath.row] isEqualToString:@"账户余额"]) {
        
        TBBalanceViewController *balanceVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_balanceVC"];
        
        [self.navigationController pushViewController:balanceVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"优惠卡券"]) {
        
        TBCouponViewController *couponVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_couponVC"];
        
        [self.navigationController pushViewController:couponVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"支付密码"]) {
        
        TBPayPassWordViewController *payPasswordVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_payPasswordVC"];
        
        [self.navigationController pushViewController:payPasswordVC animated:YES];
        
    }
    
    
}

@end

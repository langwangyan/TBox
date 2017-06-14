//
//  TBSettingViewController.m
//  TBox
//
//  Created by 王言 on 2017/6/12.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBSettingViewController.h"
#import "SDImageCache.h"
#import "TBFeedBackViewController.h"

@interface TBSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSArray *menuArray;
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong) UIButton *exitBtn;

@end

@implementation TBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initView];
    
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"设置";
    
    [self.navigationController setNavigationBarHidden:NO];
}
//返回
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

//初始化data
-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"我的消息",@"关于我们",@"联系我们",@"意见反馈",@"清理缓存",@"系统版本",nil];
}

//初始化tableView
-(void)initView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [_tableView setScrollEnabled:NO];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _exitBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, self.menuArray.count*55+20, 200, 40)];
    [_exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _exitBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [_exitBtn setBackgroundColor:[UIColor colorWithRed:137/255.0 green:194/255.0 blue:193/255.0 alpha:.8]];
    
    _exitBtn.clipsToBounds = YES;
    _exitBtn.layer.cornerRadius=8;
    [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_exitBtn];
}

-(void) exitBtnClick {
//    [TBStoreDataUtil storeUser:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TABLE_VIEW_ID = @"setting_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_VIEW_ID];
    }
    NSString *cellStr = [_menuArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.textLabel.text = cellStr;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击之后去掉灰色背景
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_menuArray[indexPath.row] isEqualToString:@"我的消息"]) {
        
//        TBBondViewController *bondVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_bondVC"];
//        
//        [self.navigationController pushViewController:bondVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"关于我们"]) {
        
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"联系我们"]) {
        
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"意见反馈"]) {
        
        TBFeedBackViewController *feedbackVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_feedbackVC"];
        
        [self.navigationController pushViewController:feedbackVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"清理缓存"]) {
        [self clearCache];
    }else if ([_menuArray[indexPath.row] isEqualToString:@"系统版本"]) {
        [self appInfo];
    }
    
}

//清理缓存
-(void)clearCache {
    __weak typeof(self) weakself = self;
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [TBProgressUtil showToast2View:weakself.view WithMsg:@"缓存清理成功！"];
            });   
        });
    }];
}

//系统版本
-(void)appInfo {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    [TBProgressUtil showToast2View:self.view WithMsg:[NSString stringWithFormat:@"%@ : %@ ( %@ )",app_Name,app_Version,app_build]];
}

@end

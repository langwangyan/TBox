//
//  TBGuideViewController.m
//  TBox
//
//  Created by 王言 on 2017/6/14.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBGuideViewController.h"

@interface TBGuideViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSArray *menuArray;
@property(nonatomic,strong) NSArray *rightStrArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TBGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initTableView];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"用户指南";
    
    [self.navigationController setNavigationBarHidden:NO];
}
//返回
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

//初始化data
-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"开不了锁",@"发现车辆故障",@"押金说明",@"充值说明",@"举报违停",@"找不到车",nil];
}

//初始化tableView
-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
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
    static NSString *TABLE_VIEW_ID = @"guide_cell_id";
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
    if ([_menuArray[indexPath.row] isEqualToString:@"开不了锁"]) {
        
        //        TBBondViewController *bondVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_bondVC"];
        //
        //        [self.navigationController pushViewController:bondVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"发现车辆故障"]) {
        
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"押金说明"]) {
        
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"充值说明"]) {
        
//        TBFeedBackViewController *feedbackVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_feedbackVC"];
//        
//        [self.navigationController pushViewController:feedbackVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"举报违停"]) {
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"找不到车"]) {
        
    }
    
}

@end

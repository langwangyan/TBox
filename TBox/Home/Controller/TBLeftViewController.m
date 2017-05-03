//
//  TBLeftViewController.m
//  TBox
//
//  Created by 王言 on 2017/4/26.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBLeftViewController.h"

@interface TBLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSArray *menuArray;

@end

@implementation TBLeftViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"测试的呀1",@"测试的呀2", nil];
}

-(void)initView{
    self.view.backgroundColor = [UIColor colorWithRed:150.f green:205.f blue:205.f alpha:0.5];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TABLE_VIEW_ID = @"table_view_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_VIEW_ID];
    }
    cell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController;
    
    switch (indexPath.row) {
        case 0:
            viewController = [[UIViewController alloc] init];
            break;
        case 1:
            viewController = [[UIViewController alloc] init];
            break;
        default:
            break;
    }
    //调用pushFrontViewController进行页面切换
    
//    [revealViewController pushFrontViewController:viewController animated:YES];
    
}

@end

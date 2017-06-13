//
//  TBLeftViewController.m
//  TBox
//
//  Created by 王言 on 2017/4/26.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBLeftViewController.h"
#import "TBShareViewController.h"
#import "TBWallentViewController.h"
#import "TBSettingViewController.h"
#import "TBGuideViewController.h"
#import "TBStoreDataUtil.h"

@interface TBLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UIView *headView;

@property(nonatomic,strong) UIImageView *headerImgView;
@property(nonatomic,strong) UILabel *nameLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *menuArray;

@property(nonatomic,strong) NSDictionary *meanuDict;

@property(nonatomic,strong) TBUser *user;

@end

@implementation TBLeftViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTableView];
}

-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"我的行程",@"我的钱包",@"分享有礼",@"用户指南",@"我的消息",@"救援中心",@"设置", nil];
    _meanuDict = @{@"我的行程":@"main_xingcheng",@"我的钱包":@"main_mywallent",@"分享有礼":@"main_share",@"用户指南":@"main_userguide",@"我的消息":@"main_message",@"救援中心":@"main_help_center",@"设置":@"main_setting"};
}

//初始化tableView
-(void)initTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LEFTVIEW_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}


#pragma tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TABLE_VIEW_ID = @"info_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_VIEW_ID];
    }
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
    
    [cell.imageView setImage:[UIImage imageNamed:self.meanuDict[cell.textLabel.text]]];
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TBUser *user = [TBStoreDataUtil restoreUser];
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LEFTVIEW_WIDTH, 120)];
    [_headView setBackgroundColor:[UIColor whiteColor]];
    
    _headerImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IMG_0123.JPG"]];
    _headerImgView.layer.cornerRadius=40;
    [_headerImgView setFrame:CGRectMake(20, 40, 60, 60)];
    
    [self.headView addSubview:_headerImgView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, tableView.frame.size.width-100, 50)];
    _nameLabel.text=user.userId ;
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    
    [self.headView addSubview:_nameLabel];
    
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击之后去掉灰色背景
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.menuArray[indexPath.row] isEqualToString:@"我的行程"]) {
        if ([self validateIsLogin]) {
            TBWallentViewController *wallentVC = [[TBWallentViewController alloc]init];
            
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:wallentVC];
            }
        }else {
            //说明未登录
            TBLoginIndexViewController *tbLoginIndexVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_loginIndeVC"];
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:tbLoginIndexVC];
            }
        }
        
    }else if ([self.menuArray[indexPath.row] isEqualToString:@"我的钱包"]) {
        
        if ([self validateIsLogin]) {
            TBWallentViewController *wallentVC = [[TBWallentViewController alloc]init];
            
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:wallentVC];
            }
        }else {
            //说明未登录
            TBLoginIndexViewController *tbLoginIndexVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_loginIndeVC"];
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:tbLoginIndexVC];
            }
        }
        
    }else if ([self.menuArray[indexPath.row] isEqualToString:@"分享有礼"]) {
        
        if ([self validateIsLogin]) {
            TBShareViewController *shareVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_shareVC"];
            
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:shareVC];
            }
        }else {
            //说明未登录
            TBLoginIndexViewController *tbLoginIndexVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_loginIndeVC"];
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:tbLoginIndexVC];
            }
        }
    }else if ([self.menuArray[indexPath.row] isEqualToString:@"用户指南"]) {
        if ([self validateIsLogin]) {
            TBGuideViewController *guideVC = [[TBGuideViewController alloc]init];
            
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:guideVC];
            }
        }else {
            //说明未登录
            TBLoginIndexViewController *tbLoginIndexVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_loginIndeVC"];
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:tbLoginIndexVC];
            }
        }
        
    }else if ([self.menuArray[indexPath.row] isEqualToString:@"我的消息"]) {
        if ([self validateIsLogin]) {
            TBWallentViewController *wallentVC = [[TBWallentViewController alloc]init];
            
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:wallentVC];
            }
        }else {
            //说明未登录
            TBLoginIndexViewController *tbLoginIndexVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_loginIndeVC"];
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:tbLoginIndexVC];
            }
        }
        
    }else if ([self.menuArray[indexPath.row] isEqualToString:@"救援中心"]) {
        if ([self validateIsLogin]) {
            TBWallentViewController *wallentVC = [[TBWallentViewController alloc]init];
            
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:wallentVC];
            }
        }else {
            //说明未登录
            TBLoginIndexViewController *tbLoginIndexVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_loginIndeVC"];
            if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
                [self.delegate pushVC:tbLoginIndexVC];
            }
        }
        
    }else if ([self.menuArray[indexPath.row] isEqualToString:@"设置"]) {
        
        TBSettingViewController *settingVC = [[TBSettingViewController alloc]init];
        
        if ([self.delegate respondsToSelector:@selector(pushVC:)]) {
            [self.delegate pushVC:settingVC];
        }
        
    }
}

//校验是否登录
-(Boolean) validateIsLogin {
    self.user = [TBStoreDataUtil restoreUser];
    if(!self.user || !self.user.userId || !self.user.mobile) {
        return NO;
    }
    return YES;
}


@end

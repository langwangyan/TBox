//
//  TBUserViewController.m
//  TBox
//
//  Created by 王言 on 2017/6/14.
//  Copyright © 2017年 tbox. All rights reserved.
//

#define USERCENTER_API @"getUserInfo"
#import "TBUserCenterViewController.h"

@interface TBUserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong) UIImagePickerController *imagePickerController;
@property(nonatomic,strong) UIActionSheet *actionSheet;
@property(nonatomic,strong) UIAlertView *alertView;

@property(nonatomic,strong) UIButton *imgBtn;//用户头像
@property(nonatomic,strong) UILabel *userNickLabel;//用户昵称
@property(nonatomic,strong) UILabel *scoreLabel;//积分

@property(nonatomic,strong) UIButton *scoreRuleBtn;//积分规则
@property(nonatomic,strong) UIButton *scoreHistoryBtn;//积分历史

@property(nonatomic,strong) NSArray *menuArray;
@property(nonatomic,strong) TBUser *user;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TBUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initView];
    [self reloadData];
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"个人中心";
    
    [self.navigationController setNavigationBarHidden:NO];
}
//返回
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

//初始化data
-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"用户昵称",@"性别",@"出生年月",@"实名认证*",@"电子邮箱",nil];
}

//初始化tableView
-(void)initView{
    
    _imgBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, 70, 70)];
    [_imgBtn setImage:[UIImage imageNamed:@"IMG_0123.JPG"] forState:UIControlStateNormal];
    _imgBtn.clipsToBounds = YES;
    _imgBtn.layer.cornerRadius=35;
    [_imgBtn addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_imgBtn];
    
    _userNickLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 80, SCREEN_WIDTH-100, 20)];
    [_userNickLabel setFont:[UIFont systemFontOfSize:13]];
    
    [self.view addSubview:_userNickLabel];
    
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 80+25, SCREEN_WIDTH-100, 20)];
    [_scoreLabel setFont:[UIFont systemFontOfSize:13]];
    
    [self.view addSubview:_scoreLabel];
    
    CGFloat width = (SCREEN_WIDTH-100-30)/2;
    _scoreRuleBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 80+25+25, width, 20)];
    [_scoreRuleBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_scoreRuleBtn setTitle:@"积分规则" forState:UIControlStateNormal];
    [_scoreRuleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_scoreRuleBtn addTarget:self action:@selector(scoreRuleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_scoreRuleBtn];
    
    _scoreHistoryBtn = [[UIButton alloc]initWithFrame:CGRectMake(100+width+10, 80+25+25, (SCREEN_WIDTH-100-30)/2, 20)];
    [_scoreHistoryBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_scoreHistoryBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_scoreHistoryBtn addTarget:self action:@selector(scoreHistoryClick) forControlEvents:UIControlEventTouchUpInside];
    [_scoreHistoryBtn setTitle:@"积分历史" forState:UIControlStateNormal];
    
    [self.view addSubview:_scoreHistoryBtn];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [_tableView setScrollEnabled:NO];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

//上传头像
-(void) imgBtnClick {
    self.imagePickerController.delegate = self;
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照",nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [self.actionSheet showInView:self.view];

}

//积分规则
-(void) scoreRuleClick{
    
}

//积分历史
-(void) scoreHistoryClick{
    
}

//重新加载数据
-(void)reloadData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_PRE_URL,USERCENTER_API];
    self.user = [TBStoreDataUtil restoreUser];
    NSDictionary *dict =@{@"userId":self.user.userId};
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
            [weakself.user setBikeDeposit:[dataDict[@"bikeDeposit"] floatValue]];
            [weakself.user setBirthday:dataDict[@"birthday"]];
            [weakself.user setCarDeposit:[dataDict[@"carDeposit"] floatValue]];
            [weakself.user setDrivingAuthStatus:[dataDict[@"drivingAuthStatus"] intValue]];
            [weakself.user setGender:dataDict[@"gender"]];
            [weakself.user setGrade:[dataDict[@"grade"] intValue]];
            [weakself.user setHeadIconBase64:dataDict[@"headIconBase64"]];
            [weakself.user setIdCardAuthStatus:[dataDict[@"idCardAuthStatus"] intValue]];
            [weakself.user setNickname:dataDict[@"nickname"]];
            [weakself.user setPaidDepositAmount:dataDict[@"paidDepositAmount"]];
            
            [TBStoreDataUtil storeUser:weakself.user];
            
        }else {
            [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
            
        }
        
        //设置头像
        if (weakself.user.headIconBase64 && ![weakself.user.headIconBase64 isEqual:[NSNull null]] && ![@"" isEqualToString:weakself.user.headIconBase64]) {
            [_imgBtn setImage:[UIImage imageWithData:[weakself.user.headIconBase64 dataUsingEncoding:NSUTF8StringEncoding]] forState:UIControlStateNormal];
        }
        
        //设置nickname
        if (weakself.user.nickname && ![weakself.user.nickname isEqual:[NSNull null]] && [@"" isEqualToString:weakself.user.nickname]) {
            weakself.userNickLabel.text = [NSString stringWithFormat:@"用户昵称：%@", weakself.user.nickname];
        }else {
            weakself.userNickLabel.text = [NSString stringWithFormat:@"用户昵称：%@", weakself.user.userId];
        }
        
        //设置积分
        weakself.scoreLabel.text = [NSString stringWithFormat:@"积分：%d", weakself.user.grade];
        
        [weakself.tableView reloadData];
        
        [tb_progress hideLoadingView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [tb_progress hideLoadingView];
        
        [TBProgressUtil showToast2View:weakself.view WithMsg:error.description];
    }];
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
    self.user = [TBStoreDataUtil restoreUser];
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
    UILabel *rightLabel = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
    rightLabel.font = [UIFont boldSystemFontOfSize:15];
    [rightLabel sizeToFit];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.frame =CGRectMake(SCREEN_WIDTH - 80 - 10,12, 80, 23);
    
    [cell.contentView addSubview:rightLabel];
    rightLabel.textColor = [UIColor orangeColor];
    
    if ([_menuArray[indexPath.row] isEqualToString:@"用户昵称"]) {
        
        if (self.user.nickname && ![self.user.nickname isEqual:[NSNull null]] && [@"" isEqualToString:self.user.nickname]) {
            rightLabel.text = self.user.nickname;
        }else {
            rightLabel.text = self.user.userId;
        }

        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"性别"]) {
        rightLabel.text = self.user.gender?self.user.gender:@"保密";
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"出生年月"]) {
        rightLabel.text = self.user.birthday?self.user.birthday:@"未填写";
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"实名认证*"]) {
        rightLabel.text = self.user.idCardAuthStatus?@"已认证":@"未认证";
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"电子邮箱"]) {
        
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击之后去掉灰色背景
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_menuArray[indexPath.row] isEqualToString:@"用户昵称"]) {
        
        //        TBBondViewController *bondVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_bondVC"];
        //
        //        [self.navigationController pushViewController:bondVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"性别"]) {
        
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"出生年月"]) {
        
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"实名认证*"]) {
        
//        TBFeedBackViewController *feedbackVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_feedbackVC"];
//        
//        [self.navigationController pushViewController:feedbackVC animated:YES];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"电子邮箱"]) {
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}
#pragma UIActionSheetDelegate方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self selectImageFromAlbum];
    }else if(buttonIndex==1){
        [self selectImageFromCamera];
    }
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        [self.imgBtn setImage:image forState:UIControlStateNormal];
    }];
}


@end

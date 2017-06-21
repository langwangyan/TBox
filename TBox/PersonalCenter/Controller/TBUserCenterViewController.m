//
//  TBUserViewController.m
//  TBox
//
//  Created by 王言 on 2017/6/14.
//  Copyright © 2017年 tbox. All rights reserved.
//
#define SAVE_INFO_API @"saveUserInfo"
#define USERCENTER_API @"getUserInfo"
#import "TBUserCenterViewController.h"
#import "TBCenterTableViewCell.h"

@interface TBUserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

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

@property(nonatomic,strong) UIPickerView * genderPV;
@property(nonatomic,strong) NSArray *genderArray;
@property(nonatomic,strong) UIButton *genderSaveBtn;
@property(nonatomic,strong) NSString *gender;
@property(nonatomic,strong) UIView *genderView;

@property(nonatomic,strong) UIDatePicker *birthDP;
@property(nonatomic,strong) UIButton *birthSaveBtn;
@property(nonatomic,strong) NSString *birth;
@property(nonatomic,strong) UIView *birthView;

@property(nonatomic,assign) BOOL isSave;

@end

@implementation TBUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    
    [self initHeadView];
    
    [self loadData];
    
}

//初始化顶部bar
- (void) initTopBar {
    //设置backBarButtonItem
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"个人中心";
    //设置右侧button
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveUserInfo)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.navigationController setNavigationBarHidden:NO];
}

//保存用户信息
-(void) saveUserInfo {
    if (!(self.user.nickname && ![self.user.nickname isEqualToString:@""] && self.user.gender && ![self.user.gender isEqualToString:@""] && self.user.birthday && ![self.user.birthday isEqualToString:@""])) {
        
        [TBProgressUtil showToast2View:self.view WithMsg:@"昵称、性别、出生日期均不能为空哦~"];
        
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_PRE_URL,SAVE_INFO_API];
    NSDictionary *dict =@{@"userId":self.user.userId,@"nickname":self.user.nickname,@"gender":self.user.gender,@"birthday":self.user.birthday};
    
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
            
            [TBStoreDataUtil storeUser:weakself.user];
            
            weakself.userNickLabel.text = [NSString stringWithFormat:@"用户昵称：%@", weakself.user.nickname];
            [TBProgressUtil showToast2View:weakself.view WithMsg:@"保存成功"];
        }else {
            
            [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
        }
        
        [tb_progress hideLoadingView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [tb_progress hideLoadingView];
        
        [TBProgressUtil showToast2View:weakself.view WithMsg:error.description];
    }];
}

//初始化data
-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"用户昵称",@"性别",@"出生年月",@"实名认证*",nil];
}

//初始化headView
-(void)initHeadView{
    
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
    
}

//初始化tableView
-(void) initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [_tableView setScrollEnabled:NO];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

-(void) initDatePickerView {
    if (!self.birthView) {
        self.birthView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 200)];
        [self.birthView setBackgroundColor:[UIColor colorWithRed:168.0/255 green:168.0/255 blue:172.0/255 alpha:0.5]];
        
        self.birthDP = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 200)];
        self.birthDP.datePickerMode = UIDatePickerModeDate;
        
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        self.birthDP.locale = locale;
        
        self.birthSaveBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 80, 30)];
        [self.birthSaveBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.birthSaveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.birthSaveBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.birthSaveBtn.clipsToBounds = YES;
        self.birthSaveBtn.layer.cornerRadius=15;
        [self.birthSaveBtn addTarget:self action:@selector(birthSaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.birthView addSubview:self.birthSaveBtn];
        [self.birthView addSubview:self.birthDP];
        [self.view addSubview:self.birthView];
        
        if (self.birth && ![self.birth isEqualToString:@""]) {
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            self.birthDP.date = [dateFormat dateFromString:self.birth];
        }else{
            self.birthDP.date = [NSDate date];
        }
    }
}

-(void) birthSaveBtnClick {
    NSDate *date = self.birthDP.date;
    if (date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.birth = [dateFormatter stringFromDate:date];
    }
    
    self.user.birthday = self.birth;
    
    self.birthDP = nil;
    self.birthSaveBtn = nil;
    [self.birthView removeFromSuperview];
    self.birthView = nil;
    
    [self.tableView reloadData];
}

//初始化pickView
-(void) initPickView {
    if (!self.genderView) {
        self.genderView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 200)];
        [self.genderView setBackgroundColor:[UIColor colorWithRed:168.0/255 green:168.0/255 blue:172.0/255 alpha:0.5]];
        
        self.genderPV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 200)];
        self.genderArray = [[NSArray alloc]initWithObjects:@" ",@"男",@"女",nil];
        self.genderPV.dataSource = self;
        self.genderPV.delegate = self;
        
        self.genderSaveBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 80, 30)];
        [self.genderSaveBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.genderSaveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.genderSaveBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.genderSaveBtn.clipsToBounds = YES;
        self.genderSaveBtn.layer.cornerRadius=15;
        [self.genderSaveBtn addTarget:self action:@selector(genderSaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.genderView addSubview:self.genderSaveBtn];
        [self.genderView addSubview:self.genderPV];
        [self.view addSubview:self.genderView];
        
        self.gender = self.gender?self.gender:self.user.gender;
        
        if(self.gender && [self.gender isEqualToString:@"女"]) {
            [self.genderPV selectRow:2 inComponent:0 animated:YES];
        }else if(self.gender && [self.gender isEqualToString:@"男"]){
            [self.genderPV selectRow:1 inComponent:0 animated:YES];
        }
    }
}

//保存性别信息
-(void) genderSaveBtnClick {
    [self.user setGender:self.gender];
    //remove pickView
    self.genderPV = nil;
    self.genderSaveBtn = nil;
    [self.genderView removeFromSuperview];
    self.genderView = nil;
    
    [self.tableView reloadData];
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

//加载数据
-(void)loadData {
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
            [weakself initTableView];
            
        }else {
            [weakself initTableView];
            
            [TBProgressUtil showToast2View:weakself.view WithMsg:responseDict[@"message"]];
        }
        
        //设置头像
        if (weakself.user.headIconBase64 && ![weakself.user.headIconBase64 isEqual:[NSNull null]] && ![@"" isEqualToString:weakself.user.headIconBase64]) {
            [_imgBtn setImage:[UIImage imageWithData:[weakself.user.headIconBase64 dataUsingEncoding:NSUTF8StringEncoding]] forState:UIControlStateNormal];
        }
        //设置nickname
        if (weakself.user.nickname && ![weakself.user.nickname isEqual:[NSNull null]] && ![@"" isEqualToString:weakself.user.nickname]) {
            weakself.userNickLabel.text = [NSString stringWithFormat:@"用户昵称：%@", weakself.user.nickname];
        }else {
            weakself.userNickLabel.text = [NSString stringWithFormat:@"用户昵称：%@", weakself.user.userId];
        }
        
        //设置积分
        weakself.scoreLabel.text = [NSString stringWithFormat:@"积分：%d", weakself.user.grade];
        
        [tb_progress hideLoadingView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //设置nickname
        if (weakself.user.nickname && ![weakself.user.nickname isEqual:[NSNull null]] && ![@"" isEqualToString:weakself.user.nickname]) {
            weakself.userNickLabel.text = [NSString stringWithFormat:@"用户昵称：%@", weakself.user.nickname];
        }else {
            weakself.userNickLabel.text = [NSString stringWithFormat:@"用户昵称：%@", weakself.user.userId];
        }
        
        //设置积分
        weakself.scoreLabel.text = [NSString stringWithFormat:@"积分：%d", weakself.user.grade];
        
        [tb_progress hideLoadingView];
        
        [weakself initTableView];
        
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
    static NSString *TABLE_VIEW_ID = @"setting_cell_id";
    
    TBCenterTableViewCell *cell = [[TBCenterTableViewCell alloc]initCellWithID:TABLE_VIEW_ID tableView:tableView];
    cell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
    
    if ([_menuArray[indexPath.row] isEqualToString:@"用户昵称"]) {
        
        if (self.user.nickname && ![self.user.nickname isEqual:[NSNull null]] && ![@"" isEqualToString:self.user.nickname]) {
            cell.rightLabel.text = self.user.nickname;
        }else {
            cell.rightLabel.text = @"未设置";
        }
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"性别"]) {
        cell.rightLabel.text = self.user.gender?self.user.gender:@"保密";
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"出生年月"]) {
        cell.rightLabel.text = self.user.birthday?self.user.birthday:@"未填写";
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"实名认证*"]) {
        cell.rightLabel.text = self.user.idCardAuthStatus?@"已认证":@"未认证";
        
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击之后去掉灰色背景
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_menuArray[indexPath.row] isEqualToString:@"用户昵称"]) {
        //remove pickView
        self.genderPV = nil;
        self.genderSaveBtn = nil;
        [self.genderView removeFromSuperview];
        self.genderView = nil;
        
        self.birthDP = nil;
        self.birthSaveBtn = nil;
        [self.birthView removeFromSuperview];
        self.birthView = nil;
        
        [self changeNick:self.user.nickname indexPath:indexPath];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"性别"]) {
        self.birthDP = nil;
        self.birthSaveBtn = nil;
        [self.birthView removeFromSuperview];
        self.birthView = nil;
        
        [self initPickView];
        
    }else if ([_menuArray[indexPath.row] isEqualToString:@"出生年月"]) {
        
        //remove pickView
        self.genderPV = nil;
        self.genderSaveBtn = nil;
        [self.genderView removeFromSuperview];
        self.genderView = nil;
        
        [self initDatePickerView];
        
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

//修改用户昵称
- (void)changeNick:(NSString *) nickName indexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakself = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSArray *array = [[NSArray alloc]initWithObjects:indexPath, nil];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNickTF = alertController.textFields.firstObject;
        [weakself.user setNickname:userNickTF.text];
        
        [weakself.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入昵称";
        textField.text = nickName;
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark pickerView数据源&代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.genderArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    self.gender = self.genderArray[row];
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

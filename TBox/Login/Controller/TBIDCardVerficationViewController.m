//
//  TBIDCardVerficationViewController.m
//  TBox
//
//  Created by 王言 on 2017/5/9.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBIDCardVerficationViewController.h"
#import "TBDriverLicenseViewController.h"

@interface TBIDCardVerficationViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong) UIImagePickerController *imagePickerController;
@property(nonatomic,strong) UIActionSheet *actionSheet;

@property (weak, nonatomic) IBOutlet UITextField *trueNameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardVerficationTF;
@property (weak, nonatomic) IBOutlet UIImageView *idCardImgView;
@property (weak, nonatomic) IBOutlet UIButton *updateIDCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation TBIDCardVerficationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopBar];
}

- (IBAction)uploadIDCardBtnOnclick:(id)sender {
    self.imagePickerController.delegate = self;
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照",nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [self.actionSheet showInView:self.view];
    
}

- (IBAction)nextStepBtnOnclick:(id)sender {
    TBDriverLicenseViewController *tbDriverLicenseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tb_driverLicenseVC"];
    [self.navigationController pushViewController:tbDriverLicenseVC animated:YES];
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

/**初始化顶部bar*/
- (void) initTopBar {
    //设置backBarButtonItem
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //设置中间文字
    self.navigationItem.title = @"身份证验证";
    
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
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消选择");
    }];
}

#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        [self.idCardImgView setImage:image];
    }];
}


@end

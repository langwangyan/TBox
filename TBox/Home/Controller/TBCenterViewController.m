//
//  TBCenterViewController.m
//  TBox
//
//  Created by 王言 on 2017/4/27.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBCenterViewController.h"

@interface TBCenterViewController ()

@end

@implementation TBCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT-20)];
    ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    ///自定义定位小蓝点
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = YES;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    
    
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

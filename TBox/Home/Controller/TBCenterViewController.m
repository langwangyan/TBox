//
//  TBCenterViewController.m
//  TBox
//
//  Created by 王言 on 2017/4/27.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBCenterViewController.h"

@interface TBCenterViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property(nonatomic,strong) BMKMapView *mapView;
@property(nonatomic,strong) BMKLocationService *locService;

@end

@implementation TBCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.view = self.mapView;
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
    
}

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
        //开启实时路况
        [_mapView setTrafficEnabled:YES];
        //打开百度城市热力图图层
        [_mapView setBaiduHeatMapEnabled:YES];
        //百度地图logo位置
        [_mapView setLogoPosition:BMKLogoPositionRightBottom];
        //显示用户位置
        [_mapView setShowsUserLocation:YES];
    }
    
    return _mapView;
}

- (BMKLocationService *)locService {
    if (!_locService) {
        _locService = [[BMKLocationService alloc]init];
        //启动LocationService
        [_locService startUserLocationService];
    }
    return _locService;
}

- (void)viewWillAppear:(BOOL)animated {
    self.mapView.delegate = self;
    //初始化BMKLocationService
    self.locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
}


@end

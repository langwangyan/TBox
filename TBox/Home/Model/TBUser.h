//
//  TBUser.h
//  TBox
//
//  Created by 王言 on 2017/5/5.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBUser : NSObject<NSCoding>

@property(nonatomic,strong) NSString *userId;//用户id
@property(nonatomic,strong) NSString *realName;//真实姓名
@property(nonatomic,strong) NSString *idCardNo;//身份证号
@property(nonatomic,strong) NSString *mobile;//手机号
@property(nonatomic,strong) NSString *drivingNo;//驾照号
@property(nonatomic,strong) NSString *drivingRecordNo;//驾照档案号


@property(nonatomic,assign) CGFloat bikeDeposit;//自行车押金
@property(nonatomic,assign) CGFloat carDeposit;//自行车押金
@property(nonatomic,strong) NSString *paidDepositAmount;//已付押金

@property(nonatomic,strong) NSString *nickname;//昵称
@property(nonatomic,assign) int grade;//级别
@property(nonatomic,strong) NSString *gender;//性别
@property(nonatomic,strong) NSString *birthday;//生日
@property(nonatomic,strong) NSString *headIconBase64;//头像

@property(nonatomic,assign) int idCardAuthStatus;//身份证是否通过审核
@property(nonatomic,assign) int drivingAuthStatus;//驾照是否通过审核
@property(nonatomic,assign) int depositStatus;//是否已交保证金

@end

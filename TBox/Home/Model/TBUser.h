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


@property(nonatomic,strong) NSString *nickname;//昵称
@property(nonatomic,strong) NSString *grade;//级别
@property(nonatomic,strong) NSString *gender;//性别
@property(nonatomic,strong) NSString *birthday;//生日
@property(nonatomic,strong) NSString *headIconBase64;//头像

@property(nonatomic,strong) NSString *idCardAuthStatus;//身份证是否通过审核
@property(nonatomic,strong) NSString *drivingAuthStatus;//驾照是否通过审核
@property(nonatomic,strong) NSString *depositStatus;//是否已交保证金

@end

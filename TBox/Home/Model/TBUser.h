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

@end

//
//  TBUser.h
//  TBox
//
//  Created by 王言 on 2017/5/5.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBUser : NSObject<NSCoding>

@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *password;

@end

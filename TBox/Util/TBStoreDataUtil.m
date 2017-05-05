//
//  TBStoreDataUtil.m
//  TechFestival
//
//  Created by 王言 on 2017/5/5.
//

#import "TBStoreDataUtil.h"

@implementation TBStoreDataUtil

+(void) storeUser:(TBUser *)user {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"tb_user_key"];
}

+(TBUser *) restoreUser {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"tb_user_key"];
    TBUser * user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

@end

//
//  TBStoreDataUtil.h
//
//  Created by 王言 on 2017/2/21.
//

#import <Foundation/Foundation.h>

@interface TBStoreDataUtil : NSObject

+(void) storeUser:(TBUser *)user;

+(TBUser *) restoreUser;



@end

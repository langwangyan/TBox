//
//  TBUser.m
//  TBox
//
//  Created by 王言 on 2017/5/5.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBUser.h"

@implementation TBUser

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.idCardNo forKey:@"idCardNo"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.drivingNo forKey:@"drivingNo"];
    [aCoder encodeObject:self.drivingRecordNo forKey:@"drivingRecordNo"];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.idCardNo = [aDecoder decodeObjectForKey:@"idCardNo"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.drivingNo = [aDecoder decodeObjectForKey:@"drivingNo"];
        self.drivingRecordNo = [aDecoder decodeObjectForKey:@"drivingRecordNo"];
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

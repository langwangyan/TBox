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
    [aCoder encodeObject:self.paidDepositAmount forKey:@"paidDepositAmount"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    
    [aCoder encodeObject:self.bikeDeposit forKey:@"bikeDeposit"];
    [aCoder encodeObject:self.carDeposit forKey:@"carDeposit"];
    [aCoder encodeObject:self.grade forKey:@"grade"];
    [aCoder encodeObject:self.idCardAuthStatus forKey:@"idCardAuthStatus"];
    [aCoder encodeObject:self.drivingAuthStatus forKey:@"drivingAuthStatus"];
    [aCoder encodeObject:self.depositStatus forKey:@"depositStatus"];

}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.idCardNo = [aDecoder decodeObjectForKey:@"idCardNo"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.drivingNo = [aDecoder decodeObjectForKey:@"drivingNo"];
        self.drivingRecordNo = [aDecoder decodeObjectForKey:@"drivingRecordNo"];
        self.paidDepositAmount = [aDecoder decodeObjectForKey:@"paidDepositAmount"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        
        self.bikeDeposit = [aDecoder decodeObjectForKey:@"bikeDeposit"];
        self.carDeposit = [aDecoder decodeObjectForKey:@"carDeposit"];
        self.grade = [aDecoder decodeObjectForKey:@"grade"];
        self.idCardAuthStatus = [aDecoder decodeObjectForKey:@"idCardAuthStatus"];
        self.drivingAuthStatus = [aDecoder decodeObjectForKey:@"drivingAuthStatus"];
        self.depositStatus = [aDecoder decodeObjectForKey:@"depositStatus"];
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

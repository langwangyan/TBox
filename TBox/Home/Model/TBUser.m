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
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.username forKey:@"password"];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.username = [aDecoder decodeObjectForKey:@"password"];
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

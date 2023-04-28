//
//  UserInfoModel.m
//  Object_framwork
//
//  Created by apple on 2020/4/23.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int numberOfIvars = 0;
    //成员变量
    Ivar *ivars = class_copyIvarList([UserInfoModel class], &numberOfIvars);
    
    for (const Ivar *p = ivars; p < ivars + numberOfIvars; p++) {
        Ivar const ivar = *p;
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}
 
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        unsigned int numberOfIvars = 0;
        //成员变量
        Ivar *ivars = class_copyIvarList([UserInfoModel class], &numberOfIvars);
        
        for (const Ivar *p = ivars; p < ivars + numberOfIvars; p++) {
            Ivar const ivar = *p;
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[coder decodeObjectForKey:key] forKey:key];
        }
        free(ivars);
    }
    return self;
}
@end

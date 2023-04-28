//
//  UserInfoModel.h
//  Object_framwork
//
//  Created by apple on 2020/4/23.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject<NSCoding>

@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * user_nicename;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * avatar_thumb;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * signature;
@property (nonatomic , copy) NSString              * coin;
@property (nonatomic , copy) NSString              * consumption;
@property (nonatomic , copy) NSString              * votestotal;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * login_type;
@property (nonatomic , copy) NSString              * last_login_time;
@property (nonatomic , copy) NSString              * location;
@property (nonatomic , copy) NSString              * isreg;
@property (nonatomic , copy) NSString              * isagent;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * level_anchor;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * contact;

@property (nonatomic , assign) BOOL               isOpenLiveing ; // 是否登录

@end

NS_ASSUME_NONNULL_END

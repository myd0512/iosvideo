//
//  MyInfoModel.h
//  Object_framwork
//
//  Created by apple on 2020/4/26.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveingModel.h"


NS_ASSUME_NONNULL_BEGIN


@interface MyInfoModel : NSObject

@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * user_nicename;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * avatar_thumb;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * signature;
@property (nonatomic , copy) NSString              * coin;
@property (nonatomic , copy) NSString              * votes;
@property (nonatomic , copy) NSString              * consumption;
@property (nonatomic , copy) NSString              * votestotal;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * contact;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * location;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * level_anchor;
@property (nonatomic , assign) NSInteger              lives;
@property (nonatomic , copy) NSString              * follows;
@property (nonatomic , copy) NSString              * fans;
@property (nonatomic , strong) Vip              * vip;
@property (nonatomic , strong) Liang              * liang;
@property (nonatomic , copy) NSString              * agent_switch;
@property (nonatomic , copy) NSString              * family_switch;

@end

NS_ASSUME_NONNULL_END


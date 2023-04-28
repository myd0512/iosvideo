//
//  UserInfoManaget.h
//  Object_framwork
//
//  Created by apple on 2020/4/23.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "MyInfoModel.h"
#import "LiveingModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface UserInfoManaget : NSObject
FanweSingletonH(Instance);

@property(strong , nonatomic) UserInfoModel * model ;

@property(strong , nonatomic) MyInfoModel * infoModel ;

@property(strong , nonatomic) LiveingModel * gameInfoModel ; //游戏类型模型

-(void)save:(UserInfoModel *)model ;
    
-(void)get;


@end

NS_ASSUME_NONNULL_END

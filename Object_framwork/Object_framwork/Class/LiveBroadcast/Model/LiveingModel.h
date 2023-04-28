//
//  LiveingModel.h
//  Object_framwork
//
//  Created by apple on 2020/4/23.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Liang :NSObject
@property (nonatomic , copy) NSString              * name;

@end


@interface Vip :NSObject
@property (nonatomic , copy) NSString              * type;

@end


@interface LiveingModel : NSObject

@property (nonatomic , strong) Liang              * liang;
@property (nonatomic , strong) Vip              * vip;
@property (nonatomic , copy) NSString              * userlist_time;
@property (nonatomic , copy) NSString              * barrage_fee;
@property (nonatomic , copy) NSString              * chatserver;
@property (nonatomic , copy) NSString              * votestotal;
@property (nonatomic , copy) NSString              * stream;
@property (nonatomic , copy) NSString              * push;
@property (nonatomic , copy) NSString              * pull;
@property (nonatomic , copy) NSString              * guard_nums;
@property (nonatomic , copy) NSString              * tx_appid;
@property (nonatomic , copy) NSString              * jackpot_level;

@property (nonatomic , assign) NSInteger               gameID;
@property (nonatomic , copy) NSString             *  gameName;

@end

NS_ASSUME_NONNULL_END

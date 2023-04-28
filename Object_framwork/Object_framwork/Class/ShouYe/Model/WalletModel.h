//
//  WalletModel.h
//  Object_framwork
//
//  Created by apple on 2020/4/26.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Coin :NSObject
@property (nonatomic , copy) NSString              * coin;

@end

@interface WalletModel : NSObject
@property (nonatomic , strong) Coin              * coin;
@property (nonatomic , copy) NSString              * reg_reward_total;
@property (nonatomic , copy) NSString              * gift_fencheng_total;
@property (nonatomic , copy) NSString              * game_jiangjin_total;
@property (nonatomic , copy) NSString              * last_reg_reward_total;
@property (nonatomic , copy) NSString              * last_gift_fencheng_total;
@property (nonatomic , copy) NSString              * last_game_jiangjin_total;
@property (nonatomic , copy) NSString              * Today_reg_reward_total;
@property (nonatomic , copy) NSString              * Today_gift_fencheng_total;
@property (nonatomic , copy) NSString              * Today_game_jiangjin_total;
@property (nonatomic , copy) NSString              * Yesterday_reg_reward_total;
@property (nonatomic , copy) NSString              * Yesterday_gift_fencheng_total;
@property (nonatomic , copy) NSString              * Yesterday_game_jiangjin_total;

@end

NS_ASSUME_NONNULL_END

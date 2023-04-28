//
//  RankingListModel.h
//  Object_framwork
//
//  Created by apple on 2020/4/26.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankingListModel : NSObject


@property (nonatomic , copy) NSString              * totalcoin;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * avatar_thumb;
@property (nonatomic , copy) NSString              * user_nicename;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * level_anchor;
@property (nonatomic , copy) NSString              * isAttention;


@end

NS_ASSUME_NONNULL_END

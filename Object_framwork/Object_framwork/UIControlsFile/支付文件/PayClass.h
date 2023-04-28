//
//  PayClass.h
//  Object_framwork
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018年 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^ paySuccessEnd )( void ) ;
typedef void(^ dataBlock )(NSDictionary * dict) ;
static NSString * const appSchem = @"AliPayDuoShangChengt"; // 支付宝发布任务


@interface PayClass : NSObject

FanweSingletonH(Instance);

/**
 添加支付结果通知 -
 */
-(void)setAttriSelfInfo ;

/**
 *
 * 支付宝支付
 */
-(void)alipay_methodWith:(NSString *)OrderString withBlock:(dataBlock)block ;


/**
 *
 * 微信支付
 */
//-(void)weiChatPay_methodWith:(NSDictionary *)data withBlock:(dataBlock)block ;


/**
 支付成功 - 收到通知回调 block
 */
@property( copy , nonatomic ) paySuccessEnd paySuccess ;


/**
 支付成功 - 收到通知回调 block
 */
@property( copy , nonatomic ) paySuccessEnd payFaile ;

@end

NS_ASSUME_NONNULL_END

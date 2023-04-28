//
//  PayClass.m
//  Object_framwork
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018年 www.zzwanbei.com. All rights reserved.
//

#import "PayClass.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import <WXApi.h> //
@implementation PayClass
FanweSingletonM(Instance) ;



/**
 微信初始化 / 支付宝初始化 / 添加通知信息
 */
-(void)setAttriSelfInfo {
	
	[[[ NSNotificationCenter defaultCenter ] rac_addObserverForName:KAliPaySuccessNotifycation object:nil ] subscribeNext:^(NSNotification  *notification) {
		
			if ([notification.name isEqualToString:KAliPaySuccessNotifycation ]) {
				
				NSLog(@"支付类 payClass 收到支付成功 回调") ;
				self.paySuccess();
			}
		
		
	}];
	
	
	[[[ NSNotificationCenter defaultCenter ] rac_addObserverForName:KAliPayErrorNotifycation object:nil ] subscribeNext:^(NSNotification  *notification) {
		
		
		if ([notification.name isEqualToString:KAliPayErrorNotifycation ]) {
			
			NSLog(@"支付类 payClass 收到支付成功 回调") ;
			self.paySuccess();
		}
	}];
	
}


-(void)alipay_methodWith:(NSString *)OrderString withBlock:(dataBlock)block  {
    
//    [[AlipaySDK defaultService] payOrder:OrderString fromScheme:appSchem callback:^(NSDictionary *resultDic) {
//
//        NSLog(@"payOrder reslut = %@",resultDic ) ;
//
//        block( resultDic ) ;
//
//    }];

}


///**
// *
// * 微信支付
// */
//-(void)weiChatPay_methodWith:(NSDictionary *)data withBlock:(dataBlock)block {
//
//    PayReq *req = [[PayReq alloc] init];
//    //实际项目中这些参数都是通过网络请求后台得到的，详情见以下注释，测试的时候可以让后台将价格改为1分钱
//    req.openID =  [NSString isNotNULL:data[@"appid"]] ? data[@"appid"] : @""  ;//微信开放平台审核通过的AppID
//    req.partnerId =  [NSString isNotNULL:data[@"partnerid"]] ? data[@"partnerid"] : @"" ;//微信支付分配的商户ID
//	req.prepayId = [NSString isNotNULL:data[@"prepayid"]] ? data[@"prepayid"] : @""  ;// 预支付交易会话ID
//    req.nonceStr = [NSString isNotNULL:data[@"noncestr"]] ? data[@"noncestr"] : @""  ;//随机字符串
//    req.timeStamp = [data[@"timestamp"] intValue]  ;//当前时间
//    req.package = [NSString isNotNULL:data[@"package"]] ? data[@"package"] : @""  ;//固定值
//    req.sign = [NSString isNotNULL:data[@"sign"]] ? data[@"sign"] : @"" ;//签名，除了sign，剩下6个组合的再次签名字符串
//    if ([WXApi isWXAppInstalled] == YES) {
//        //此处会调用微信支付界面
//        BOOL sss = [WXApi sendReq:req];
//        if (!sss ) {
//            // [MBManager showMessage:@"微信sdk错误" inView:weakself.view afterDelayTime:2];
//            [SVProgressHUD showErrorWithStatus:@"微信sdk错误"];
//        }
//
//    }else {
//       //微信未安装
////         [MBManager showMessage:@"您没有安装微信" inView:weakself.view afterDelayTime:2];
//        [SVProgressHUD showErrorWithStatus:@"您没有安装微信"];
//
//    }
//}

@end

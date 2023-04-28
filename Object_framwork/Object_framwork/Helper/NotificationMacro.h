
//
//  NotificationMacro.h
//  ceshi
//
//  Created by 高通 on 2018/11/7.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#ifndef NotificationMacro_h
#define NotificationMacro_h



// 通知中心
#define Noti_Default                        [NSNotificationCenter defaultCenter]
// 发送通知
#define kNotifPost(n, o)                    [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
// 监听通知
#define kNotifAdd(n, f)                     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
// 通知移除
#define kNotifRemove()                      [[NSNotificationCenter defaultCenter] removeObserver:self]

// 自定义 - 数据 网络请求 判断是否含有数据
#define  is_HaveData  ( [ json[@"status"] integerValue ] == 1 )


// 状态展示
#define SVError(a)   [SVProgressHUD showErrorWithStatus:a ]
#define SVSuccess(a) [SVProgressHUD showSuccessWithStatus:a ]
#define SVStatus(a) [SVProgressHUD showWithStatus:a ]

// push 控制器
#define MyPushVC(a)  [self.navigationController pushViewController:a animated:YES ]
// 顶部 控制器 push VC
#define MyTopVCPush(a) [[QuickCreatUI sharedInstance].topViewController.navigationController pushViewController:a animated:YES ] ;



// 微信登陆回调
#define kWXLoginBack                        @"wXLoginBack" // 登录

#define KWUserInfoKey                      	@"KWUserInfoKey" // 用户信息

#define KAliPaySuccessNotifycation                 @"KAliPayNotifycation" // ali 支付结果通知
#define KAliPayErrorNotifycation                 @"KAliPayErrorNotifycation" // ali 支付结果通知

#define KWeiChatShareNotifycation           @"WeiChatShare" // 微信分享结果通知

#define KWeiLoginNotifycation               @"KWeiLoginNotifycation" // 微信登录结果通知



#endif /* NotificationMacro_h */

//
//  网络变化检测方法.h
//  Object_framwork
//
//  Created by 高通 on 2019/10/12.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//


#import "ZYNetworkAccessibity.h"


- appDelegate
/**
 判断 网络 - 设置权限监听
 */
[ZYNetworkAccessibity setAlertEnable:YES];

[ZYNetworkAccessibity setStateDidUpdateNotifier:^(ZYNetworkAccessibleState state) {
	
	NSLog(@"setStateDidUpdateNotifier > %zd", state);
}];

[ZYNetworkAccessibity start];



- 控制器里
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:ZYNetworkAccessibityChangedNotification object:nil];

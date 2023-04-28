//
//  AppDelegate.m
//  Object_framwork
//
//  Created by 高通 on 2018/11/8.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

//#import "ZYNetworkAccessibity.h"
#import "LoginVC.h"

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	_window = [[UIWindow alloc] initWithFrame:kScreenBounds];
	_window.backgroundColor = kWhiteColor ;
	[_window makeKeyAndVisible];
	
	[self initYinDao];
    
    //后台运行定时器
     UIApplication*   app = [UIApplication sharedApplication];
     __block    UIBackgroundTaskIdentifier bgTask;
     bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
         dispatch_async(dispatch_get_main_queue(), ^{
             if (bgTask != UIBackgroundTaskInvalid)
             {
                 bgTask = UIBackgroundTaskInvalid;
             }
         });
     }];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         dispatch_async(dispatch_get_main_queue(), ^{
             if (bgTask != UIBackgroundTaskInvalid)
             {
                 bgTask = UIBackgroundTaskInvalid;
             }
         });
     });
    
	return YES;
}


#pragma mark 初始化 - 网络监听
-(void)initYinDao{
      
    [[UserInfoManaget sharedInstance]  get] ; //存储的用户信息
    
    NSLog(@"isopen = %d",[UserInfoManaget sharedInstance].model.isOpenLiveing) ;
    if ([UserInfoManaget sharedInstance].model && [UserInfoManaget sharedInstance].model.isOpenLiveing ) { // 用户一登录
        
        [ _window setRootViewController:[[FWQMUIBaseTabBarVC alloc] init ] ] ;
        
    }else{ //用户 未登录
        [ _window setRootViewController:[[LoginVC alloc] init ] ] ;
    }
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setMaximumDismissTimeInterval:2.0];
}



- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//杀进程
- (void)applicationWillTerminate:(UIApplication *)application{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shajincheng" object:nil];
}


@end

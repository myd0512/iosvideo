
//
//  SystemMacro.h
//  ceshi
//
//  Created by 高通 on 2018/11/7.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#ifndef SystemMacro_h
#define SystemMacro_h



// 屏幕frame,bounds,size,scale
#define kScreenFrame            [UIScreen mainScreen].bounds
#define kScreenBounds           [UIScreen mainScreen].bounds
#define kScreenW                [[UIScreen mainScreen] bounds].size.width
#define kNavH                   ([[UIApplication sharedApplication]statusBarFrame].size.height + 44)
#define kScreenH                [[UIScreen mainScreen] bounds].size.height
#define kScaleW                 (kScreenW)*(kScreenScale)
#define kScaleH                 (kScreenH)*(kScreenScale)

#define WIDTH            [[UIScreen mainScreen] bounds].size.width
#define Width           [[UIScreen mainScreen] bounds].size.width
#define HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define Height           [[UIScreen mainScreen] bounds].size.height
#define _window_width           [[UIScreen mainScreen] bounds].size.width
#define _window_height           [[UIScreen mainScreen] bounds].size.height

// UI设计时的屏幕大小
#define kDesignHeight            667.0f
#define kDesignWidth             375.0f
#define kRatioWidth              kScreenW/375.0f
#define kRatioHeight             kScreenH/667.0f

// 主窗口的宽、高
#define kMainScreenWidth        MainScreenWidth()
#define kMainScreenHeight       MainScreenHeight()
static __inline__ CGFloat MainScreenWidth()
{
	return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
}

static __inline__ CGFloat MainScreenHeight()
{
	return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
}

// 状态栏、导航栏、标签栏高度
// 判断是否是iPhone X

// 状态栏高度
#define kStatusBarHeight (kiPhoneX||kiPhoneXR||kiPhoneXS||kiPhoneXSMAX ? 44.f : 20.f)
// 导航栏高度
#define kNavigationBarHeight (kiPhoneX||kiPhoneXR||kiPhoneXS||kiPhoneXSMAX ? 88.f : 64.f)
// tabBar高度
#define kTabBarHeight (kiPhoneX||kiPhoneXR||kiPhoneXS||kiPhoneXSMAX ? (49.f+34.f) : 49.f)
//  tabBar 下边多的高度
#define kTabBarStatusBarHeight (kiPhoneX||kiPhoneXR||kiPhoneXS||kiPhoneXSMAX ? 34.f : 0.f)

#define minstr(a)    [NSString stringWithFormat:@"%@",a]


#define scale_hight1            SCREEN_HEIGHT < 600 ? 50 : 55
#define scale_hight             SCREEN_HEIGHT > 667 ? 60 : scale_hight1

// 当前所在window
#define kCurrentWindow          [AppDelegate sharedAppDelegate].sus_window ?  : [AppDelegate sharedAppDelegate].window


// 3.判断iOS版本
#define iOSDevice  ([[UIDevice currentDevice].systemVersion doubleValue])
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define IPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define kiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define kiPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define kiPhoneXSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)


#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#endif /* SystemMacro_h */

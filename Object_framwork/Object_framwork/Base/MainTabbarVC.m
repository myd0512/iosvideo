//
//  MainTabbarVC.m
//  Object_framwork
//
//  Created by mac on 2020/6/10.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "MainTabbarVC.h"
#import "YSHomeVC.h"
#import "MyInfoVC.h"
#import "ZLTabBar.h"
#import "live&VideoSelectView.h"
#import "OpenLiveBroadVC.h"
#import "UpVideoVC.h"


@interface MainTabbarVC ()

@end

@implementation MainTabbarVC


//- (instancetype)init {
//   if (!(self = [super init])) {
//       return nil;
//   }
//   /**
//    * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
//    * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
//    * 更推荐后一种做法。
//    */
////   UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
////   UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
////   CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers  tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:imageInsets
////                                                                            titlePositionAdjustment:titlePositionAdjustment
////                                                                                            context:nil
////                                            ];
//////   [self customizeTabBarAppearance:tabBarController];
////   self.navigationController.navigationBar.hidden = YES;
////   return (self = (MainTabbarVC *)tabBarController);
//}

- (NSArray *)viewControllers {
    
   YSHomeVC *firstViewController = [[YSHomeVC alloc] init];
   UIViewController *firstNavigationController = [[CYLBaseNavigationController alloc]
                                                  initWithRootViewController:firstViewController];
   [firstViewController cyl_setHideNavigationBarSeparator:YES];
    
   MyInfoVC *secondViewController = [[MyInfoVC alloc] init];
   UIViewController *secondNavigationController = [[CYLBaseNavigationController alloc]
                                                   initWithRootViewController:secondViewController];
   [secondViewController cyl_setHideNavigationBarSeparator:YES];
   NSArray *viewControllers = @[
                                firstNavigationController,
                                secondNavigationController,
                                ];
   return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
   NSDictionary *firstTabBarItemsAttributes = @{
//                                                CYLTabBarItemTitle : @"首页",
                                                CYLTabBarItemImage :  @"tab_home",  /* NSString and UIImage are supported*/
                                                CYLTabBarItemSelectedImage : @"tab_home_s",  /* NSString and UIImage are supported*/
                                                };
   NSDictionary *secondTabBarItemsAttributes = @{
//                                                 CYLTabBarItemTitle : @"鱼塘",
                                                 CYLTabBarItemImage : @"tab_mine",
                                                 CYLTabBarItemSelectedImage : @"tab_mine_s",
                                                 };
   

   NSArray *tabBarItemsAttributes = @[
                                      firstTabBarItemsAttributes,
                                      secondTabBarItemsAttributes,
                                      ];
   return tabBarItemsAttributes;
}

@end

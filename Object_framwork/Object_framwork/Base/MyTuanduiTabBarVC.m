//
//  MyTuanduiTabBarVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "MyTuanduiTabBarVC.h"
#import "TeamInfoTJVC.h"
#import "MemberManagerVC.h"
#import "SubordinateVC.h"
#import "YQCodeVC.h"


@interface MyTuanduiTabBarVC ()

@end

@implementation MyTuanduiTabBarVC

- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSubVC];
    }
    return self;
}


-(void)setSubVC{
    
    NSArray * titleArr = @[@"团队统计" ,@"会员管理" ,@"下级报表",@"邀请码"] ;
    NSArray * nor_imgArr = @[@"团队统计" ,@"会员管理" ,@"下级",@"邀请码"] ;
    NSArray * sel_imgArr = @[@"团队统计点击" ,@"会员管理点击" ,@"下级点击",@"邀请码点击"] ;
    NSArray * con_Arr = @[@"TeamInfoTJVC" ,@"MemberManagerVC",@"SubordinateVC",@"YQCodeVC" ] ;
    
    for (int i = 0; i < con_Arr.count ; i++) {
        
        [self addChildViewControllers:con_Arr[i] Title:titleArr[i] nor_img:nor_imgArr[i] Sele_img:sel_imgArr[i] andIndex:i];
    }
}


-(void)addChildViewControllers:(NSString *)controller Title:(NSString *)title nor_img:(NSString *)norImgString Sele_img:(NSString *)seImgString andIndex:(NSInteger)tag{
    
    UIViewController * VC = [NSClassFromString(controller) new] ;
    
    FWQMUIBaseNavigationVC *labNavController = [[FWQMUIBaseNavigationVC alloc] initWithRootViewController:VC];
    VC.hidesBottomBarWhenPushed = NO;
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:norImgString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
    tabBarItem.selectedImage =[[UIImage imageNamed:seImgString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    
    VC.tabBarItem = tabBarItem ;
    
    [self addChildViewController:labNavController] ;
}



@end

//
//  FWQMUIBaseTabBarVC.m
//  Object_framwork
//
//  Created by 高通 on 2019/2/12.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "FWQMUIBaseTabBarVC.h"
#import "YSHomeVC.h"
#import "MyInfoVC.h"
#import "ZLTabBar.h"
#import "live&VideoSelectView.h"
#import "OpenLiveBroadVC.h"
#import "UpVideoVC.h"


@interface FWQMUIBaseTabBarVC ()<UITabBarControllerDelegate,ZLTabBarDelegate,liveVideoDelegate>
{
     live_VideoSelectView *selectView;
}
@end

@implementation FWQMUIBaseTabBarVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSubVC];
    }
    return self;
}


-(void)setSubVC{
	
    self.delegate = self ;

	NSArray * titleArr = @[@"首页" ,@"我的" ] ;
	NSArray * nor_imgArr = @[@"tab_home" ,@"tab_mine" ] ;
	NSArray * sel_imgArr = @[@"tab_home_s" ,@"tab_mine_s" ] ;
	NSArray * con_Arr = @[@"YSHomeVC" ,@"MyInfoVC" ] ;
	
	for (int i = 0; i < con_Arr.count ; i++) {
		
		[self addChildViewControllers:con_Arr[i] Title:titleArr[i] nor_img:nor_imgArr[i] Sele_img:sel_imgArr[i] andIndex:i];
		
	}
    ZLTabBar * tabbar = [[ZLTabBar alloc] init];
    tabbar.delegate = self ;
    [ self setValue:tabbar forKeyPath:@"tabBar"]; // 设置tabbar
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


-(void)addChildViewControllers:(NSString *)controller Title:(NSString *)title nor_img:(NSString *)norImgString Sele_img:(NSString *)seImgString andIndex:(NSInteger)tag{
	
	UIViewController * VC = [NSClassFromString(controller) new] ;
	
	FWQMUIBaseNavigationVC *labNavController = [[FWQMUIBaseNavigationVC alloc] initWithRootViewController:VC];
	VC.hidesBottomBarWhenPushed = NO;
	
	UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:norImgString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
	tabBarItem.selectedImage =[[UIImage imageNamed:seImgString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
	
	VC.tabBarItem = tabBarItem ;
	
	[self addChildViewController:labNavController] ;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    self.tabBar.hidden = NO;

    NSLog(@"点击了 tabbar");
}

-(void)clickImageBtn{
    
//    if (selectView) {
//         [selectView removeFromSuperview] ;
//         selectView = nil ;
//    }
//    selectView = [[live_VideoSelectView alloc]init] ;
//    selectView.delegate = self ;
//    [self.view addSubview:selectView] ;
    
    MyTopVCPush([OpenLiveBroadVC new]) ;
}

#pragma mark ================ 视频直播选择视图代理 ===============
-(void)clickLive:(BOOL)islive{
    if (islive) {
          
        MyTopVCPush([OpenLiveBroadVC new]) ;
        NSLog(@"1");
    }else{
        UpVideoVC *video = [[UpVideoVC alloc]init];
        MyTopVCPush(video) ;
        NSLog(@"2");
    }
    [self hideSelctView];
}
-(void)hideSelctView{
    [selectView removeFromSuperview];
    selectView = nil;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end

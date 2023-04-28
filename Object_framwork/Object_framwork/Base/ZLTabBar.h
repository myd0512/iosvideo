//
//  ZLTabBar.h
//  Tech-Demo
//
//  Created by 王泽龙 on 2018/5/28.
//  Copyright © 2018年 王泽龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLTabBar ;
@protocol ZLTabBarDelegate <NSObject>

@required
- (void)clickImageBtn;

@end

@interface ZLTabBar : UITabBar

@property (nonatomic , weak)id<ZLTabBarDelegate> delegate;

@end

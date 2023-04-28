//
//  ZLTabBar.m
//  Tech-Demo
//
//  Created by 王泽龙 on 2018/5/28.
//  Copyright © 2018年 王泽龙. All rights reserved.
//

#import "ZLTabBar.h"
#import "OpenLiveBroadVC.h"




@interface ZLTabBar ()

// 特殊的按钮
@property (nonatomic, strong) UIImageView *middleImg;



@end

@implementation ZLTabBar



- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		_middleImg = [[UIImageView alloc] init] ;
		_middleImg.image = [UIImage imageNamed:@"bt_start_live"] ;
		_middleImg.contentMode = UIViewContentModeScaleAspectFit ;
        _middleImg.userInteractionEnabled = YES ;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg)];
        [_middleImg addGestureRecognizer:tap ] ;
		// 发布按钮的点击事件
		[self addSubview:_middleImg] ;
		
		self.tintColor = ObjectSystemColor ;
	}
	return self;
}

/*
 * 点击 - 图片
 */
-(void)clickImg{
    
    if ([self.delegate respondsToSelector:@selector(clickImageBtn)]) {
        [self.delegate clickImageBtn];
    }

}

/**
 重新计算按钮位置，摆放特点按钮在中间
 */
- (void)layoutSubviews {
    [super layoutSubviews] ;
	
    /**** 设置所有UITabBarButton的frame ****/
    // 按钮的尺寸
    CGFloat buttonW = WIDTH / 3.0;
    CGFloat buttonH = kTabBarHeight - kTabBarStatusBarHeight;
    CGFloat buttonY = 0;
    // 按钮索引
    int buttonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
		
        // 设置frame
        CGFloat buttonX = buttonIndex * buttonW;
        // 把发布按钮的位置预留出来
        if (buttonIndex >= 1) { // 右边的2个UITabBarButton
            buttonX += buttonW;
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 增加索引
        buttonIndex++ ;
		NSLog(@"subview --- %@, buttonIndex = %d" ,NSStringFromCGRect(subview.frame)  , buttonIndex ) ;
    }
    /**** 设置中间的发布按钮的frame ****/
    self.middleImg.frame = CGRectMake(0, 0, buttonW, 53);
    self.middleImg.center = CGPointMake( WIDTH*0.5, buttonH * 0.25);
    [self bringSubviewToFront:self.middleImg];
}


@end

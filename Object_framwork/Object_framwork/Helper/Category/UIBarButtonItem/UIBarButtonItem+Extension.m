//
//  UIBarButtonItem+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	// 设置图片
	[btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
	
	if (highImage.length != 0) {
		
		[btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
	}
	
	// 设置尺寸
	//    btn.size = btn.currentBackgroundImage.size;
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action string:(NSString *)title font:(CGFloat)font stringColor:(UIColor *)color{
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[ btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setTitleColor:color forState:UIControlStateNormal];
	btn.titleLabel.font = [UIFont systemFontOfSize:font];
	// 设置尺寸
	//    btn.size = btn.currentBackgroundImage.size;
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
	
}
@end

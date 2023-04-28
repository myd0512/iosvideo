//
//  UIBarButtonItem+Extension.h
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;


/**
 创建 导航 左右按钮
 *
 * target : action : 添加点击事件
 * title / font / color  设置属性
 *
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action string:(NSString *)title font:(CGFloat)font stringColor:(UIColor *)color ;



@end

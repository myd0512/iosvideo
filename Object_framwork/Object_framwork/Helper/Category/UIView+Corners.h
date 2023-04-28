//
//  UIView+Corners.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/22.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corners)

/*
 
 typedef NS_OPTIONS(NSUInteger, UIRectCorner) {
 UIRectCornerTopLeft     = 1 << 0,
 UIRectCornerTopRight    = 1 << 1,
 UIRectCornerBottomLeft  = 1 << 2,
 UIRectCornerBottomRight = 1 << 3,
 UIRectCornerAllCorners  = ~0UL
 };
 
 */
-(void)ViewSetCornerWithCorners:(UIRectCorner)type andCornerSize:(CGSize)size ;


/*
 
 corner 角度
 
 */
-(void)viewCornersWith:(CGFloat)corner ;




@end

NS_ASSUME_NONNULL_END

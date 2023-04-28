//
//  UIView+Corners.m
//  Object_framwork
//
//  Created by 高通 on 2018/12/22.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#import "UIView+Corners.h"

@implementation UIView (Corners)


/**
 设置 - 圆角
 */
-(void)ViewSetCornerWithCorners:(UIRectCorner)type andCornerSize:(CGSize)size {
	
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:type cornerRadii:size ];//圆角大小
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
	maskLayer.frame = self.bounds;
	maskLayer.path = maskPath.CGPath;
	self.layer.mask = maskLayer;
}


-(void)viewCornersWith:(CGFloat)corner {
	
	self.layer.cornerRadius = corner ;
	self.layer.masksToBounds = YES ;
}



@end

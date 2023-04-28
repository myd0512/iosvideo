//
//  QuickCreatUI.m
//  Object_framwork
//
//  Created by 高通 on 2018/12/4.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#import "QuickCreatUI.h"

@implementation QuickCreatUI

FanweSingletonM(Instance) ;


@end



//==================== MutableAttributedString ======================
/**
 MutableAttributedString - 可变字符串分类
 */
@implementation QuickCreatUI ( MutableAttributedString )


/**
 *
 * 分段_颜色 字体_大小 设置
 */
+(NSMutableAttributedString *)addAttributeString:(NSString *)string oneString:(NSString *)oneString onestringfont:(NSInteger)onefont oneColor:(UIColor *)onecolor twoString:(NSString *)twoString twostringfont:(NSInteger)twofont twoColor:(UIColor *)twocolor {
	
	NSMutableAttributedString *hintString=[ [ NSMutableAttributedString alloc ] initWithString:string] ;
	
	NSRange firthRange = [ string  rangeOfString:oneString ] ;
	NSRange secondRange = [ string  rangeOfString:twoString ] ;
	
	[hintString addAttributes:@{
								NSFontAttributeName:[UIFont systemFontOfSize:onefont] ,
								NSForegroundColorAttributeName:onecolor
								} range:firthRange];
	[hintString addAttributes:@{
								NSFontAttributeName:[UIFont systemFontOfSize:twofont] ,
								NSForegroundColorAttributeName:twocolor
								} range:secondRange];
	
	
	return hintString;
}


/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace {
	
	NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
	
	NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:lineSpace];
	
	[attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
	
	long number = textSpace;
	CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
	//    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
	CFRelease(num);
	
	return attributedStr;
}


@end



//==================== self_Alert ======================
/**
 self_Alert - 快速弹框
 */
@implementation QuickCreatUI ( self_Alert )


/**
 * 创建一个  确定alert
 *
 * title        alert 标题
 * message      信息消息
 * sureBlock    成功的操作
 */
-(void)creatAlertViewWithTitle:(NSString *)title message:(NSString *)message sureBlock:(AlertBlock)sureBlock{
	
	UIAlertController * alert = [ UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction * cancleBtn = [ UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:sureBlock];
	
	[alert  addAction:cancleBtn];
	
	[self.topViewController presentViewController:alert animated:YES completion:nil];
	
}
/**
 * 创建一个  取消 / 确定alert
 *
 * title        alert 标题
 * message      信息消息
 * cancleBlock  取消的操作
 * sureBlock    成功的操作
 */
-(void)creatAlertViewWithTitle:(NSString *)title message:(NSString *)message CancleBlock:(AlertBlock)cancleBlock sureBlock:(AlertBlock)sureBlock{
	
	UIAlertController * alert = [ UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction * cancleBtn = [ UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:cancleBlock];
	
	UIAlertAction * sureBtn = [ UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:sureBlock];
	
	[alert  addAction:cancleBtn];
	[alert  addAction:sureBtn];
	
	[self.topViewController presentViewController:alert animated:YES completion:nil];
}



///**
// * 创建一个  alert
// *
// * title        alert 标题
// * message      信息消息
// * cancleBlock  取消的操作
// * sureBlock    成功的操作
// */
//-(UIView *)creatAlertView_SelfAlert_WithMessage:(NSString *_Nullable)message CancleBlock:(AlertBlock _Nullable )cancleBlock sureBlock:(AlertBlock _Nullable )sureBlock {
//	
//	UIView * alertView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, 265, 145) ] ;
//	
//	alertView.backgroundColor = kWhiteColor ;
//	
//	UIView *topBackView = [ QuickCreatUI creatUIViewWithSuperView:alertView andFrame:CGRectMake(0, 0, alertView.width, alertView.height - 44- PixelOne ) color:kWhiteColor];
//	
//	
//	UILabel * label = [QuickCreatUI creatUILabelWithSuperView:topBackView andFrame:CGRectMake(45, 0, alertView.width - 90, alertView.height - 44- PixelOne ) andText:message andStringColor:UIColorGray1 andFont:15] ;
//	label .numberOfLines = 2 ;
//	label.textAlignment = NSTextAlignmentCenter ;
//	
//	
//	UIView * lineView_1 = [ QuickCreatUI creatUIViewWithSuperView:alertView andFrame:CGRectMake(0, topBackView.bottom, alertView.width, PixelOne ) color:RGB(245, 245, 245)] ;
//	
//	
//	
//	UIView *BottomBackView = [ QuickCreatUI creatUIViewWithSuperView:alertView andFrame:CGRectMake(0, lineView_1.bottom, alertView.width, alertView.height - lineView_1.bottom ) color:kWhiteColor] ;
//	
//	UIButton * leftBtn = [QuickCreatUI creatUIButtonWithSuperView:BottomBackView andFrame:CGRectMake(0, 0, alertView.width/2, 44) andText:@"取消" andStringColor:UIColorGray1 andFont:15 andTarget:self SEL:<#(nonnull SEL)#> ] ;
//	
//	
//	
//	return alertView ;
//}

@end



//==================== Navi_Controller ======================
/**
 Navigation -
 */
@implementation QuickCreatUI ( Navi_Controller )

// 获取当前活动的navigationcontroller
- (UINavigationController *)navigationViewController
{
	UIWindow *window = [UIApplication sharedApplication].keyWindow ;
	
	if ([window.rootViewController isKindOfClass:[UINavigationController class]])
	{
		return (UINavigationController *)window.rootViewController;
	}
	else if ([window.rootViewController isKindOfClass:[UITabBarController class]])
	{
		UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
		if ([selectVc isKindOfClass:[UINavigationController class]])
		{
			return (UINavigationController *)selectVc;
		}
	}
	return nil;
}

- (UIViewController *)topViewController
{
	UINavigationController *nav = [self navigationViewController];
	return nav.topViewController;
}

//- (void)pushViewController:(UIViewController *)viewController
//{
//	@autoreleasepool
//	{
//		viewController.hidesBottomBarWhenPushed = YES;
//		[[self navigationViewController] pushViewController:viewController animated:YES];
//	}
//}
//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//	@autoreleasepool
//	{
//		viewController.hidesBottomBarWhenPushed = YES;
//		[[self navigationViewController] pushViewController:viewController animated:animated];
//	}
//}
//
//- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)title
//{
//	@autoreleasepool
//	{
//		viewController.hidesBottomBarWhenPushed = YES;
//		[[self navigationViewController] pushViewController:viewController withBackTitle:title animated:NO];
//	}
//}
//
////- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)title backAction:(FWVoidBlock)action
////{
////    @autoreleasepool
////    {
////        viewController.hidesBottomBarWhenPushed = YES;
////        [[self navigationViewController] pushViewController:viewController withBackTitle:title action:action animated:NO];
////    }
////}
//
//- (UIViewController *)popViewController
//{
//	return [[self navigationViewController] popViewControllerAnimated:NO];
//}
//- (NSArray *)popToRootViewController
//{
//	return [[self navigationViewController] popToRootViewControllerAnimated:NO];
//}
//
//- (NSArray *)popToViewController:(UIViewController *)viewController
//{
//	return [[self navigationViewController] popToViewController:viewController animated:NO];
//}
//
//- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion
//{
//	UIViewController *top = [self topViewController];
//
//	if (vc.navigationController == nil)
//	{
//		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//		[top presentViewController:nav animated:animated completion:completion];
//	}
//	else
//	{
//		[top presentViewController:vc animated:animated completion:completion];
//	}
//}
//
//- (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion
//{
//	if (vc.navigationController !=  QuickCreatUI.sharedInstance.navigationViewController)
//	{
//		[vc dismissViewControllerAnimated:YES completion:nil];
//	}
//	else
//	{
//		[self popViewController];
//	}
//}



@end


//==================== UIKit 控件 ======================
/**
 QMUI - 控件快速创建
 */
@implementation QuickCreatUI ( UIKit_View )


/**
 快速创建UI 控件  UIView
 *
 * superView : 父控件
 * rect : Frame 大小
 * backColor : 背景颜色
 *
 */
+ (UIView *)creatUIViewWithSuperView:(UIView *)superView andFrame:(CGRect)rect color:(UIColor *)backColor {
	
	UIView * view = [ [ UIView alloc ] initWithFrame:rect ] ;
	
	if ( backColor ) {
		
		view.backgroundColor = backColor ;
	}
	
	[ superView   addSubview:view ];
	
	return view;
}



/**
 快速创建UI 控件  UILabel
 *
 * superView : 父控件
 * string : 文字
 * stringColor : 文字颜色
 * rect : Frame 大小
 * font :字体大小
 */
+ (UILabel *)creatUILabelWithSuperView:(UIView *)superView andFrame:(CGRect)rect andText:( NSString *)string  andStringColor:(UIColor *)stringColor andFont:(CGFloat)font {
	
	UILabel * view = [ [ UILabel alloc ] initWithFrame:rect ] ;
	
	view.textAlignment = NSTextAlignmentLeft ;
	view.text = string ;
	view.textColor = stringColor ;
	view.font = [ UIFont systemFontOfSize:font ] ;
	
	[ superView   addSubview:view ];
	
	return view;
}



/**
 快速创建UI 控件  UIButton
 *
 * superView : 父控件
 * string : 文字
 * stringColor : 文字颜色
 * rect : Frame 大小
 * target : 添加点击事件
 * sel : 事件方法
 *
 */
+ (UIButton *)creatUIButtonWithSuperView:(UIView *)superView andFrame:(CGRect)rect andText:( NSString *)string  andStringColor:(UIColor *)stringColor andFont:(CGFloat)font andTarget:(id)target SEL:(SEL)sel {
	
	UIButton * view = [ [ UIButton alloc ] initWithFrame:rect ] ;
	
	[view setTitle:string forState:UIControlStateNormal ] ;
	[view setTitleColor:stringColor forState:UIControlStateNormal ] ;
	view.titleLabel.font = [UIFont systemFontOfSize:font] ;
	[view addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside ] ;
	
	[ superView   addSubview:view ];
	
	return view;
}


/**
 快速创建UI 控件  UIButton
 *
 * superView : 父控件
 * rect : Frame 大小
 * imgString : 图片img
 * target : 添加点击事件
 * sel : 事件方法
 *
 */
+ (UIButton *)creatUIButton_Image_WithSuperView:(UIView *)superView andFrame:(CGRect)rect image:(NSString *)imgString andTarget:(id)target SEL:(SEL)sel{
	
	UIButton * view = [ [ UIButton alloc ] initWithFrame:rect ] ;
	
	[view setImage:[UIImage imageNamed:imgString] forState:UIControlStateNormal];
	
	[view addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside ] ;
	
	[ superView   addSubview:view ];
	
	return view;
	
}

/**
 快速创建UI 控件  UIImageView
 *
 * superView : 父控件
 * strimgStringing : 图片名称
 * rect : Frame 大小
 *
 */
+ (UIImageView *)creatUIImageViewWithSuperView:(UIView *)superView andFrame:(CGRect)rect andImg:(NSString *)imgString {
	
	UIImageView * view = [ [ UIImageView alloc ] initWithFrame:rect ] ;
	
	if ( imgString.length != 0 ) {
		
		view.image = [ UIImage   imageNamed:imgString ] ;
	}
	
	[ superView   addSubview:view ];
	
	return view;
}



/**
 快速创建UI 控件  UITextField
 *
 * superView : 父控件
 * holderString : 默认文字
 * rect : Frame 大小
 *
 */
+ (UITextField *)creatUITextFieldWithSuperView:(UIView *)superView andFrame:(CGRect)rect andPlaceHolder:(NSString *) holderString {
	
	UITextField * view = [ [ UITextField alloc ] initWithFrame:rect ] ;
	
	view.placeholder = holderString ;
	
	[ superView   addSubview:view ] ;
	
	return view ;
}

/**
 快速创建UI 控件  UIControl
 *
 * 给 superView 添加一个点击事件
 * UIControl 覆盖添加  /  在 view 的最后调用
 */
+ (void)creatUIControlWithSuperView:(UIView *)superView tag:(NSInteger)tag andTarget:(id)target SEL:(SEL)sel {
	
	UIControl * control = [[ UIControl alloc] initWithFrame:CGRectMake(0, 0, superView.width , superView.height) ];
	[control addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside ];
	if (tag) {
		control.tag = tag ;
	}
	[superView addSubview:control];
}


@end



//==================== QMUI 控件 ======================
/**
 QMUI - 控件快速创建
 */
@implementation QuickCreatUI (QMUI_View)

@end



//==================== 无数据 默认提示 ======================
/**
 无数据 默认提示 分类
 */
@implementation QuickCreatUI (NoDataView)

/**
 *  取消 空列表默认 页
 *
 * superView   列表对象
 * taget       添加点击事件 对象
 * tag         tag值用于单页面多列表区分
 * sel         点击事件的方法
 * string      默认空白的提示语
 */
#pragma mark - 创建加载失败和服务器异常提示
+ (void)createNoContentImageView:(UIView *)superView target:(id)taget andSel:(nonnull SEL)sel tag:(NSInteger)tag  Tishinsstring:(NSString *)string ClickBtnString:(NSString *)Btnstring {
	
	UIView * nodataView = [superView viewWithTag:tag];
	
	if (nodataView) {
		
		return ;
	}
	
	if ([superView isKindOfClass:[UIScrollView class]]) {
		
		UIScrollView * scroll =  (UIScrollView *)superView ;
		
		scroll.scrollEnabled = NO;
		
	}
	/**
	 * 背景View
	 */
	UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, superView.width, superView.height)] ;
	backView.tag = tag;
	
	/**
	 *
	 *  imgView  图片
	 *
	 *  label  ---oneBlaceFont  主标题 _ 提示信息
	 *
	 *  label_2  ---threeBlaceFont  副标题 _ 提示信息
	 *
	 *  btn  --- 下部的按钮 显示
	 *
	 */
//	CGFloat imgScal = 8/9 ;
	UIImageView * imgView  = [ [ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"subordinate_icon"] ] ;
	imgView.contentMode = UIViewContentModeScaleAspectFit ;
	//    imgView.center = CGPointMake( backView.width /2 , backView.height /2 - 100 ) ;
	//    imgView.size = CGSizeMake(180 , imgScal*180);
	//    imgView.userInteractionEnabled = YES;
	imgView.frame = CGRectMake( 0 , 0 , 118, 91) ;
    imgView.centerX = superView.width /2 ;
    imgView.centerY = superView.height /2  - 50;
	[backView addSubview:imgView];
	
	/**
	 * 提示信息 添加
	 */
	UILabel * label = [[UILabel alloc] init] ;
	label.frame = CGRectMake(0,  imgView.bottom + 30, backView.width, 20) ;
	label.font = [UIFont systemFontOfSize:15] ;
	label.textAlignment = NSTextAlignmentCenter ;
	label.textColor = oneBlaceFont ;
	label.text = string ;
	[backView addSubview:label];
	
	[superView addSubview:backView];
}

/**
 *  取消 空列表默认 页
 *
 * superView   列表对象
 * tag         tag值用于单页面多列表区分
 */
+(void)dissmissNoContentView:(UIView * )superView tag:(NSInteger )tag {
	
	UIView * nodataView = [superView viewWithTag:tag];
	
	if (nodataView) {
		
		if ([superView isKindOfClass:[UIScrollView class]]) {
			
			UIScrollView * scroll =  (UIScrollView *)superView ;
			
			scroll.scrollEnabled = YES;
		}
		
		[nodataView removeFromSuperview];
	}
}

@end





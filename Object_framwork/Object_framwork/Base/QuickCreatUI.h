//
//  QuickCreatUI.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/4.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//


/**
 工具类 :
 
 ( MutableAttributedString  ) 可变字符串分类
 
 ( self_Alert  ) 弹框提示控制器
 
 ( Navi_Controller  ) 导航分类 获取当前活动控制器
 
 ( UIKit_View  ) UIKit 框架控件快速创建方法
 
 ( QMUI_View  ) QMUI 框架控件快速创建方法
 
 ( NoDataView  ) 无数据 - 分类信息

 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AlertBlock)(UIAlertAction * _Nullable  action);

@interface QuickCreatUI : NSObject

FanweSingletonH(Instance);




@end


//==================== MutableAttributedString ======================
/**
 MutableAttributedString - 可变字符串分类
 */
@interface QuickCreatUI ( MutableAttributedString  )

/**
 *
 * 返回 可变字符串   分段设置 - 字符串
 *
 * string - 总字符串
 * oneString - 第一段 文字
 * onefont -  第一段 文字字体 大小
 * onecolor - 第一段 文字字体 颜色
 *
 * string - 总字符串
 * oneString - 第二段 文字
 * onefont -  第二段 文字字体 大小
 * onecolor - 第二段 文字字体 颜色
 */
+(NSMutableAttributedString *)addAttributeString:(NSString *)string oneString:(NSString *)oneString onestringfont:(NSInteger)onefont oneColor:(UIColor *)onecolor twoString:(NSString *)twoString twostringfont:(NSInteger)twofont twoColor:(UIColor *)twocolor ;


/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace ;


@end


/**
 self_Alert - 快速弹框
 */
@interface QuickCreatUI ( self_Alert  )


/**
 * 创建一个  alert
 *
 * title        alert 标题
 * message      信息消息
 * sureBlock    成功的操作
 */
-(void)creatAlertViewWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message sureBlock:(AlertBlock _Nullable )sureBlock;

/**
 * 创建一个  alert
 *
 * title        alert 标题
 * message      信息消息
 * cancleBlock  取消的操作
 * sureBlock    成功的操作
 */
-(void)creatAlertViewWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message CancleBlock:(AlertBlock _Nullable )cancleBlock sureBlock:(AlertBlock _Nullable )sureBlock ;


///**
// * 创建一个  alert
// *
// * title        alert 标题
// * message      信息消息
// * cancleBlock  取消的操作
// * sureBlock    成功的操作
// */
//-(UIView *)creatAlertView_SelfAlert_WithMessage:(NSString *_Nullable)message CancleBlock:(AlertBlock _Nullable )cancleBlock sureBlock:(AlertBlock _Nullable )sureBlock ;
//

@end




/**
 Navigation -
 */
@interface QuickCreatUI ( Navi_Controller  )

// 代码中尽量改用以下方式去push/pop/present界面
- (UINavigationController *)navigationViewController;

- (UIViewController *)topViewController;

//- (void)pushViewController:(UIViewController *)viewController;
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//
//
//- (NSArray *)popToViewController:(UIViewController *)viewController;
//
//- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)title;
////- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)title backAction:(FWVoidBlock)action;
//
//- (UIViewController *)popViewController;
//
//- (NSArray *)popToRootViewController;
//
//- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated cvoidompletion:(void (^)())completion;
//
//- (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated cvoidompletion:(void (^)())completion;

@end

/**
 UIKit - 控件快速创建
 */
@interface QuickCreatUI ( UIKit_View )

/**
 快速创建UI 控件  UIView
 *
 * superView : 父控件
 * rect : Frame 大小
 * backColor : 背景颜色
 *
 */
+ (UIView *)creatUIViewWithSuperView:(UIView *)superView andFrame:(CGRect)rect color:(UIColor *)backColor  ;


/**
 快速创建UI 控件  UILabel
 *
 * superView : 父控件
 * string : 文字
 * stringColor : 文字颜色
 * rect : Frame 大小
 * font :字体大小
 */
+ (UILabel *)creatUILabelWithSuperView:(UIView *)superView andFrame:(CGRect)rect andText:( NSString *)string  andStringColor:(UIColor *)stringColor andFont:(CGFloat)font ;


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
+ (UIButton *)creatUIButtonWithSuperView:(UIView *)superView andFrame:(CGRect)rect andText:( NSString *)string  andStringColor:(UIColor *)stringColor andFont:(CGFloat)font andTarget:(id)target SEL:(SEL)sel ;

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
+ (UIButton *)creatUIButton_Image_WithSuperView:(UIView *)superView andFrame:(CGRect)rect image:(NSString *)imgString andTarget:(id)target SEL:(SEL)sel ;

/**
 快速创建UI 控件  UIImageView
 *
 * superView : 父控件
 * strimgStringing : 图片名称
 * rect : Frame 大小
 *
 */
+ (UIImageView *)creatUIImageViewWithSuperView:(UIView *)superView andFrame:(CGRect)rect andImg:(NSString *)imgString  ;



/**
 快速创建UI 控件  UITextField
 *
 * superView : 父控件
 * holderString : 默认文字
 * rect : Frame 大小
 *
 */
+ (UITextField *)creatUITextFieldWithSuperView:(UIView *)superView andFrame:(CGRect)rect andPlaceHolder:(NSString *) holderString ;


/**
 快速创建UI 控件  UIControl
 *
 * 给 superView 添加一个点击事件
 * UIControl 覆盖添加  /  在 view 的最后调用
 */
+ (void)creatUIControlWithSuperView:(UIView *)superView tag:(NSInteger)tag andTarget:(id)target SEL:(SEL)sel  ;




@end

/**
 QMUI - 控件快速创建
 */
@interface QuickCreatUI ( QMUI_View )

//==================== QMUI 控件 ======================


@end




/**
 无数据 - 分类方法
 */
@interface QuickCreatUI (NoDataView)

/**
 
 添加页面 无数据默认页
 
 superView : 添加默认页的视图
 taget / sel:  刷新按钮点点击方法
 tag : 避免重复添加 tag区分
 string : 提示的语句
 Btnstring : 按钮显示的文字
 
 */
+ (void)createNoContentImageView:(UIView *)superView target:(id)taget andSel:(nonnull SEL)sel tag:(NSInteger)tag  Tishinsstring:(NSString *)string ClickBtnString:(NSString *)Btnstring  ;


/**
 
 移除 无数据默认图
 
 superView : 父视图 传递
 tag : view的 tag 值
 
 */
+ (void)dissmissNoContentView:(UIView * )superView tag:(NSInteger )tag  ;

@end


NS_ASSUME_NONNULL_END

//
//  FWQMUICommonVC.h
//  Object_framwork
//
//  Created by 高通 on 2019/2/12.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackBlock)(void) ;
@interface FWQMUICommonVC : UIViewController


/**
 *
 * 页面布局结构
 *
 *  backScrollView .... 背景滑动视图
 *  backView  视图上的view
 */
@property(nonatomic,strong)UIScrollView  *  baseBackScrollView ; //
@property(nonatomic,strong)UIView  *  baseBackView ; // 背景滑动视图

@property( assign , nonatomic ) NSInteger topY ; //上部的距离

/**
 刷新属性 - 上拉刷新 / 下拉加载  参数
 */
@property( assign , nonatomic ) NSInteger current_index ;
@property( assign , nonatomic ) NSInteger send_index ;

@property( assign , nonatomic ) NSInteger pageCount ; // 页码
@property( assign , nonatomic ) NSInteger cell_height ; // 行高

/**
 网络 - 请求参数
 */
@property( strong , nonatomic ) NSDictionary * params ;
@property( copy , nonatomic ) NSString * url ;
@property( assign , nonatomic ) BOOL isShowNoDataImg ;

#pragma mark 网络请求-无刷新
-(void)getNORefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile ;

@end


/**
 加载动画管理 - 分类
 */
@interface FWQMUICommonVC (LoadingStatus)



@end


NS_ASSUME_NONNULL_END

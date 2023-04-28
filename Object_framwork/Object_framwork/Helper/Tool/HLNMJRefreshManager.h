//
//  FWMJRefreshManager.h
//  Object_framwork
//
//  Created by hln on 2019/2/23.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

/**
    调用解释：
 
    | 调用方法 |  头部刷新  |   尾部加载   | 加载界面后自动刷新 | 尾部加载方式 |
 1     BLOCK    ✅normal     ✅normal         ❌              ❌
 2      SEL     ✅normal     ✅normal         ❌              ❌
 3     BLOCK    ✅normal     ✅normal         ✅              ❌
 4      SEL     ✅normal     ✅normal         ✅              ❌
 5     BLOCK    ✅normal     ✅normal         ✅              ✅
 6      SEL     ✅normal     ✅normal         ✅              ✅
 --------------------------------------------------------------------
 7   BLOCK&SEL  ✅normal     ✅normal         ✅              ✅
 */


/**
 进入刷新状态的回调
 */
typedef void (^HLNRefreshComponentRefreshingBlock)(void);


@interface HLNMJRefreshManager : NSObject


/**
 刷新方法1：基础 调用方法SEL
 
 @param refreshedView 需要被刷新的View
 @param target target
 @param headerRereshAction 头部刷新，调用时默认头部刷新，如果为nil即表示隐藏头部刷新
 @param footerRereshAction 尾部刷新，如果为nil即表示隐藏尾部刷新
 */
+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction footerRereshAction:(SEL)footerRereshAction;// www

/**
 刷新方法2：基础 block

 @param refreshedView 需要被刷新的View
 @param headerRereshBlock 头部刷新的回调
 @param footerRereshBlock 尾部加载的回调
 */
+ (void)refresh:(UIScrollView *)refreshedView headerRereshBlock:(HLNRefreshComponentRefreshingBlock)headerRereshBlock footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock;


/**
 刷新方法3：头部是否在调用时自动刷新 调用方法SEL
 
 @param refreshedView 需要被刷新的View
 @param target target
 @param headerRereshAction 头部刷新，如果为nil即表示隐藏头部刷新
 @param shouldHeaderBeginRefresh 是否需要开始刷新，如果设置为NO时记得首次需要主动调用自己的相关业务
 @param footerRereshAction 尾部刷新，如果为nil即表示隐藏尾部刷新
 */
+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshAction:(SEL)footerRereshAction;

/**
 刷新方法4：头部是否在调用时自动刷新 block
 
 @param refreshedView 需要被刷新的View
 @param headerRereshBlock 头部刷新的回调
 @param shouldHeaderBeginRefresh 是否需要开始刷新，如果设置为NO时记得首次需要主动调用自己的相关业务
 @param footerRereshBlock 尾部加载的回调

 */
+ (void)refresh:(UIScrollView *)refreshedView headerRereshBlock:(HLNRefreshComponentRefreshingBlock)headerRereshBlock shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock;

/**
 刷新方法5：1、头部是否在调用时自动刷新； 2、MJRefreshFooter的类型 调用方法SEL
 
 @param refreshedView 需要被刷新的View
 @param target target
 @param headerRereshAction 头部刷新，如果为nil即表示隐藏头部刷新
 @param shouldHeaderBeginRefresh 是否需要开始刷新，如果设置为NO时记得首次需要主动调用自己的相关业务
 @param footerRereshAction 尾部刷新，如果为nil即表示隐藏尾部刷新
 @param refreshFooterType MJRefreshFooter的类型，如：MJRefreshBackNormalFooter，MJRefreshBackGifFooter 等等 默认：MJRefreshBackNormalFooter
 */
+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshAction:(SEL)footerRereshAction refreshFooterType:(NSString *)refreshFooterType;

/**
 刷新方法6：1、头部是否在调用时自动刷新； 2、MJRefreshFooter的类型 Block
 
 @param refreshedView 需要被刷新的View
 @param headerRereshBlock 头部刷新的回调
 @param shouldHeaderBeginRefresh 是否需要开始刷新，如果设置为NO时记得首次需要主动调用自己的相关业务
 @param footerRereshBlock 尾部加载的回调
 @param refreshFooterType MJRefreshFooter的类型，如：MJRefreshBackNormalFooter，MJRefreshBackGifFooter 等等 默认：MJRefreshBackNormalFooter
 */
+ (void)refresh:(UIScrollView *)refreshedView headerRereshBlock:(HLNRefreshComponentRefreshingBlock)headerRereshBlock shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock refreshFooterType:(NSString *)refreshFooterType;

/**
 刷新方法7：1、头部是否在调用时自动刷新；2、MJRefreshComponentRefreshingBlock回调 3、MJRefreshFooter的类型

 @param refreshedView 需要被刷新的View
 @param target target
 @param headerRereshAction 头部刷新，headerRereshAction || headerWithRefreshingBlock ==》不隐藏头部，反之隐藏头部
 @param shouldHeaderBeginRefresh 是否需要开始刷新，如果设置为NO时记得首次需要主动调用自己的相关业务
 @param headerWithRefreshingBlock 头部刷新的block回调
 @param footerRereshAction 尾部刷新，如果为nil即表示隐藏尾部刷新
 @param refreshFooterType MJRefreshFooter的类型，如：MJRefreshBackNormalFooter，MJRefreshBackGifFooter 等等 默认：MJRefreshBackNormalFooter
 @param footerRereshBlock 尾部加载的block回调
 */
+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh headerWithRefreshingBlock:(HLNRefreshComponentRefreshingBlock)headerWithRefreshingBlock footerRereshAction:(SEL)footerRereshAction refreshFooterType:(NSString *)refreshFooterType footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock;


/**
 停止刷新
 
 @param refreshedView 被刷新的View
 */
+ (void)endRefresh:(UIScrollView *)refreshedView;


/**
 加载数据成功调用
 
 @param refreshedScrollView 刷新的scrollView
 @param dataSource 原数据数组
 @param listDataSource 刚请求到的数据数组
 @return 数据数组
 */
+ (NSMutableArray *)endRefreshWithScrollView:(UIScrollView *)refreshedScrollView andOldCount:(NSMutableArray *)dataSource andCount:(NSMutableArray *)listDataSource andPageNum:(NSInteger)pageNum;

/**
 刷新错误
 
 @param refreshedScrollView 刷新的ScrollView
 @param dataSource 数据
 */
+ (void)errorEndRefreshWithScrollView:(UIScrollView *)refreshedScrollView andOldCount:(NSArray *)dataSource;
@end

//
//  HLNMJRefreshManager.m
//  Object_framwork
//
//  Created by hln on 2019/2/23.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "HLNMJRefreshManager.h"

// 刷新时由图片组成的类似GIF效果的图片数量
static float const kRefreshImgCount = 6;




@implementation HLNMJRefreshManager



/**
 默认刷新方法

 ***** 调用方法的
 ***** block的
 */
+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction footerRereshAction:(SEL)footerRereshAction
{
    [HLNMJRefreshManager refresh:refreshedView target:target headerRereshAction:headerRereshAction shouldHeaderBeginRefresh:YES footerRereshAction:footerRereshAction];
}
+ (void)refresh:(UIScrollView *)refreshedView headerRereshBlock:(HLNRefreshComponentRefreshingBlock)headerRereshBlock footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock
{
    [HLNMJRefreshManager refresh:refreshedView headerRereshBlock:headerRereshBlock shouldHeaderBeginRefresh:NO footerRereshBlock:footerRereshBlock];
}




+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshAction:(SEL)footerRereshAction
{
    [HLNMJRefreshManager refresh:refreshedView target:target headerRereshAction:headerRereshAction shouldHeaderBeginRefresh:shouldHeaderBeginRefresh footerRereshAction:footerRereshAction refreshFooterType:@"MJRefreshBackNormalFooter"];
}
+ (void)refresh:(UIScrollView *)refreshedView headerRereshBlock:(HLNRefreshComponentRefreshingBlock)headerRereshBlock shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock
{
    [self refresh:refreshedView headerRereshBlock:headerRereshBlock shouldHeaderBeginRefresh:NO footerRereshBlock:footerRereshBlock refreshFooterType:nil];
}




+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshAction:(SEL)footerRereshAction refreshFooterType:(NSString *)refreshFooterType
{
    [self refresh:refreshedView target:target headerRereshAction:headerRereshAction shouldHeaderBeginRefresh:shouldHeaderBeginRefresh headerWithRefreshingBlock:nil footerRereshAction:footerRereshAction refreshFooterType:refreshFooterType footerRereshBlock:nil];
}
+ (void)refresh:(UIScrollView *)refreshedView headerRereshBlock:(HLNRefreshComponentRefreshingBlock)headerRereshBlock shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock refreshFooterType:(NSString *)refreshFooterType
{
    [self refresh:refreshedView target:nil headerRereshAction:nil shouldHeaderBeginRefresh:shouldHeaderBeginRefresh headerWithRefreshingBlock:headerRereshBlock footerRereshAction:nil refreshFooterType:refreshFooterType footerRereshBlock:footerRereshBlock];
}






+ (void)refresh:(UIScrollView *)refreshedView target:(id)target headerRereshAction:(SEL)headerRereshAction shouldHeaderBeginRefresh:(BOOL)shouldHeaderBeginRefresh headerWithRefreshingBlock:(HLNRefreshComponentRefreshingBlock)headerWithRefreshingBlock footerRereshAction:(SEL)footerRereshAction refreshFooterType:(NSString *)refreshFooterType footerRereshBlock:(HLNRefreshComponentRefreshingBlock)footerRereshBlock
{
    if (headerRereshAction || headerWithRefreshingBlock)
    {
        // 上下拉刷新
        MJRefreshGifHeader *header;
        if (headerWithRefreshingBlock)
        {
            header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                headerWithRefreshingBlock();
            }];
        }
        else
        {
            header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:headerRereshAction];
        }
        
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        header.stateLabel.hidden = YES;
        
        NSMutableArray *pullingImages = [NSMutableArray array];
        
        
        UIImage *image = [UIImage imageNamed:@"ic_pull_refresh_normal"];
        [pullingImages addObject:image];
        
        UIImage *image2 = [UIImage imageNamed:@"ic_pull_refresh_ready"];
        [pullingImages addObject:image2];
        
        // 下拉展示状态图片设置
        NSArray *arrimg = [NSArray arrayWithObject:[pullingImages firstObject]];
        [header setImages:arrimg  forState:MJRefreshStateIdle];
        
        // 准备刷新状态图片设置
        NSArray *arrimg2 = [NSArray arrayWithObject:[pullingImages lastObject]];
        [header setImages:arrimg2  forState:MJRefreshStatePulling];
        
        // 刷新中图片设置
        NSMutableArray *progressImage = [NSMutableArray array];
        for (NSUInteger i = 0; i < kRefreshImgCount; i++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_pull_refresh_progress2%ld", i]];
            [progressImage addObject:image];
        }
        [header setImages:progressImage forState:MJRefreshStateRefreshing];
        refreshedView.mj_header = header;
        
        if (shouldHeaderBeginRefresh)
        {
            [header beginRefreshing];
        }
    }
    else
    {
        refreshedView.mj_header = nil;
    }
    
    
    // 下拉刷新
    if (footerRereshAction || footerRereshBlock){
        
        Class tabBarClass;// 判断是否有制定加载类型
        if (![HLNMJRefreshManager isBlankString:refreshFooterType]){
            tabBarClass = NSClassFromString(refreshFooterType);
        }else {
            tabBarClass = [MJRefreshBackNormalFooter class];
        }
        
        // 判断是block还是 方法调用
        if (footerRereshAction) {
            refreshedView.mj_footer =[tabBarClass footerWithRefreshingTarget:target refreshingAction:footerRereshAction];
        }else {
            refreshedView.mj_footer =[tabBarClass footerWithRefreshingBlock:^{
                footerRereshBlock();
            }];
        }
    }else{
        refreshedView.mj_footer = nil;
    }
}

+ (void)endRefresh:(UIScrollView *)refreshedView
{
    if (refreshedView.mj_header){
        [refreshedView.mj_header endRefreshing];
    }
    if (refreshedView.mj_footer){
        [refreshedView.mj_footer endRefreshing];
    }
}

#pragma mark 是否空字符串
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL){
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        return YES;
    }
    if ([string isEqualToString:@"(null)"]){
        return YES;
    }
    return NO;
}


/**
 加载数据成功调用

 @param refreshedScrollView 刷新的scrollView
 @param dataSource 原数据数组
 @param listDataSource 刚请求到的数据数组
 @return 数据数组
 */
+ (NSMutableArray *)endRefreshWithScrollView:(UIScrollView *)refreshedScrollView andOldCount:(NSMutableArray *)dataSource andCount:(NSMutableArray *)listDataSource andPageNum:(NSInteger)pageNum {
    if (listDataSource.count == 0) {
        return listDataSource;
    }
    NSInteger oldCount = dataSource.count;
    NSInteger listCount = listDataSource.count;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (refreshedScrollView.mj_header) {
            // 刷新
            [refreshedScrollView.mj_header endRefreshing];
        }
        
        if (oldCount + listCount > 0 && refreshedScrollView.mj_footer) {
            if (listCount < pageNum) {
                // 不够一页
                [refreshedScrollView.mj_footer endRefreshingWithNoMoreData];
                [refreshedScrollView.mj_footer setHidden:YES];
            }else {
                // 足够一页
                [refreshedScrollView.mj_footer resetNoMoreData];
                [refreshedScrollView.mj_footer setHidden:NO];
            }
        }
    });
    
    return listDataSource;
}

/**
 刷新错误

 @param refreshedScrollView 刷新的ScrollView
 @param dataSource 数据
 */
+ (void)errorEndRefreshWithScrollView:(UIScrollView *)refreshedScrollView andOldCount:(NSArray *)dataSource {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (dataSource.count == 0) {
            // 刷新信息网络错误  结束刷新  并显示空界面
            [refreshedScrollView.mj_header endRefreshing];
        }else {
            // 加载信息网络错误  结束刷新
            [refreshedScrollView.mj_footer resetNoMoreData];
        }
    });
}


@end

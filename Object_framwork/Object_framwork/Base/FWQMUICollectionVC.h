//
//  FWQMUICollectionVC.h
//  Object_framwork
//
//  Created by 高通 on 2019/4/8.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "FWQMUICommonVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWQMUICollectionVC : FWQMUICommonVC


#pragma mark 网络请求-下拉刷新
-(void)getRefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile ;
#pragma mark 网络请求-无刷新
-(void)getNORefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile ;


/**
 滑动cell
 */
@property (nonatomic, strong)void (^scrollV)(CGFloat h);

/**
 tableView - 在  方法中 自动布局
 
 make.edges.mas_equalTo( UIEdgeInsetsMake(0, 0, 0, 0)) ;
 
 如果不是全屏的 , 重写  更改布局
 */
@property( strong , nonatomic ) UICollectionViewFlowLayout * collectionViewLayout ;
@property( strong , nonatomic ) UICollectionView * collectionView ;  // 列表视图
@property( strong , nonatomic ) NSMutableArray * dataArr ; //数据源
@property( strong , nonatomic ) NSMutableArray * sectionTitleArray ; //组数



@end


/**
 网络数据请求 - 分类
 */
@interface FWQMUICollectionVC ( collection_NetDataGet)

/**
 网络请求
 */
-(void)getListData ;

@end


/**
 刷新 - 分类
 */
@interface FWQMUICollectionVC ( collection_Upload)

/**
 添加下拉刷新
 */
-(void)addHeadRefreshMethod ;

/**
 添加上拉加载
 */
-(void)addFootRefreshMethod ;

/**
 预加载 - 实现  -  上拉预加载
 */
-(void)addFootReFresh_YuLoadingMethod ;

@end


/**
 布局 - 分类
 */
@interface FWQMUICollectionVC ( collection_Layout )

/**
 布局
 */
-(void)layoutCollectionView ;


@end

NS_ASSUME_NONNULL_END

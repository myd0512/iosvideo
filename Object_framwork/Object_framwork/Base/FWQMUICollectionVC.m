//
//  FWQMUICollectionVC.m
//  Object_framwork
//
//  Created by 高通 on 2019/4/8.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "FWQMUICollectionVC.h"

@interface FWQMUICollectionVC () < UICollectionViewDelegate , UICollectionViewDataSource >

{
	NSUInteger lastContentOffset ;
	BOOL _isUp ; // 滑动方向
	BOOL _isFootRefresh ; //开启预加载
}

@end

@implementation FWQMUICollectionVC

-(void)viewWillAppear:(BOOL)animated{
	[ super viewWillAppear:animated];
	
}

#pragma mark 布局方法
-(void)initSubviews{}
/*
 * 重写 - 父类 方法
 */
-(void)initView{
    
    if (@available(iOS 11.0, *)) {
        
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.collectionView] ;
    _isUp = YES ;
    _isFootRefresh = NO ;
}


-(void)viewDidLayoutSubviews{
	[ super  viewDidLayoutSubviews ] ;
	
	[ self  layoutCollectionView ] ;
}


#pragma mark 代理事件
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	
	return self.sectionTitleArray.count ;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	
	return self.dataArr.count  ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	UICollectionViewCell * cell =  [[ UICollectionViewCell alloc] init];
	
	return cell ;
}


//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	
	return UIEdgeInsetsZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES] ;
	
	
}

//实现scrollView代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	//全局变量记录滑动前的contentOffset
	lastContentOffset = scrollView.contentOffset.y;//判断上下滑动时
	
	//	NSLog(@"lastContentOffset = %ld" , lastContentOffset ) ;
	//    lastContentOffset = scrollView.contentOffset.x;//判断左右滑动时
}

/**
 预加载 - 实现  -  上拉预加载
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if ( _isFootRefresh&&scrollView == self.collectionView ) {
		
		NSInteger tabHeight = 10 * 135 * self.current_index ;
		NSInteger scrol_he =  scrollView.contentOffset.y + self.collectionView.height ;
		NSInteger allHegiht =  tabHeight*0.7 + (self.current_index - 1)* 10*(135) ;
		
		NSLog(@"scrollView.contentSize = %ld", allHegiht ) ;
		NSLog(@"scrollView.contentSize = %ld , %ld", tabHeight ,scrol_he ) ;
		
		if (scrollView.contentOffset.y < lastContentOffset ){
			
			NSLog(@"上滑");
		} else if (scrollView.contentOffset.y > lastContentOffset ){
			
			NSLog(@"下滑");
			if ( scrol_he >= allHegiht  ) { // 当滑动高度大于 tabHeight , and 下滑到 0.7 高的时候 , 开始加载 数据 , 加载有数据重置 _isUp = YES 准备下一次加载 ,  加载完成没数据 _isUp = NO , 关闭 预加载
				
				if (_isUp) {
					
					_isUp = NO ;
					NSLog(@"刷新") ;
					
					self.send_index = self.current_index + 1 ;
					[self getListData] ;
					
				}
			}
		}
	}
	
}


#pragma mark  数据 - 懒加载
-(UICollectionViewFlowLayout *)collectionViewLayout{
	
	if ( _collectionViewLayout == nil ) {
		
		_collectionViewLayout = [[ UICollectionViewFlowLayout alloc ] init] ;
		//设置collectionView滚动方向
		[ _collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical ];
				
	}
	return _collectionViewLayout ;
}

-(UICollectionView *)collectionView{
	
	if ( _collectionView == nil ) {
		
		
		_collectionView = [ [ UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout ]  ;
		
		_collectionView.backgroundColor = kWhiteColor ;
		
		_collectionView.delegate = self ;
		_collectionView.dataSource = self ;
		/**
		 去掉 分割线   去掉滑动块
		 */
		_collectionView.showsVerticalScrollIndicator = NO ;
		
	}
	return _collectionView ;
}


-(NSMutableArray *)dataArr{
	
	if (!_dataArr) {
		
		_dataArr = @[].mutableCopy ;
	}
	return _dataArr;
}


-(NSMutableArray *)sectionTitleArray{
	
	if (!_sectionTitleArray) {
		
		_sectionTitleArray = @[@""].mutableCopy ;
	}
	return _sectionTitleArray ;
}


#pragma mark 网络请求-下拉刷新
-(void)getRefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile{
	
	/**
	 如果需要实现 - 预加载功能 , 在请求成功后 _isUp置YES
	 */
	/**
	 获取订单信息
	 */
	[[ZKHttpTool shareInstance] post: [ZKSeriverBaseURL getUrlType:self.url]  params: self.params  success:^(id json) {
		
		NSLog(@" json = %@" , json ) ;
		
		if ( self.send_index == 1 ) { // 下拉刷新
			
			[self->_dataArr removeAllObjects];
			
			[self.collectionView.mj_header endRefreshing];
			[self.collectionView.mj_footer resetNoMoreData];
		}else{ // 上拉加载
			
			self.current_index++ ;
			[self.collectionView.mj_footer endRefreshing] ;
		}
		
		success( json ) ;
		
		if (self.isShowNoDataImg) {
			
			if( self->_dataArr.count) {
				
				[QuickCreatUI dissmissNoContentView:self.collectionView tag:1]; //
				
			}else {
				
				[QuickCreatUI createNoContentImageView:self.collectionView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
			}
			
		}
		
		[self.collectionView reloadData] ;
		
	} failure:^(NSError *error) {
		
		if (self.isShowNoDataImg) {
			
			if( self->_dataArr.count == 0) {
				
				[QuickCreatUI createNoContentImageView:self.collectionView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""] ;
			}
		}
		
		[self.collectionView.mj_header endRefreshing] ;
		[self.collectionView.mj_footer endRefreshing] ;
		
//		[SVProgressHUD showErrorWithStatus:@"请求错误"] ;
		
		faile(error) ;
		
	}];
	
	
	NSLog(@"供子类重写") ;
}

#pragma mark 网络请求-无刷新
-(void)getNORefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile{
	/**
	 获取订单信息
	 */
	[[ZKHttpTool shareInstance] post: [ZKSeriverBaseURL getUrlType:self.url]  params: self.params  success:^(id json) {
		
		NSLog(@" json = %@" , json ) ;
		
		success( json ) ;
		
		[self.collectionView reloadData] ;
		
	} failure:^(NSError *error) {
		
		faile(error) ;
		
	}];
	
	
	NSLog(@"供子类重写") ;
}



@end


/**
 网络数据分类
 */
@implementation FWQMUICollectionVC (collection_NetDataGet)

/**
 网络 - 请求方法 /
 
 params  参数
 urlString  网络请求 url 链接字符串
 success  请求成功的 回调
 */
-(void)getListDataWithParmas:(NSDictionary *)params andString:(NSString *)urlString and:(BOOL)Hud andSuccess:(void (^)(id json))success {
	
	/**
	 如果需要实现 - 预加载功能 , 在请求成功后 _isUp置YES
	 */
	/**
	 获取订单信息
	 */
	[[ZKHttpTool shareInstance] post:urlString  params: params  success:^(id json) {
		
		NSLog(@" json = %@" , json ) ;
		if (is_HaveData) {
			
			if ( self.send_index == 1 ) { // 下拉刷新
				
				[self->_dataArr removeAllObjects];
				
				[self.collectionView.mj_header endRefreshing];
				[self.collectionView.mj_footer resetNoMoreData];
			}else{ // 上拉加载
				
				self.current_index++ ;
				[self.collectionView.mj_footer endRefreshing] ;
			}
			
			NSArray * array = json[@"data"];
			
			if ( array && array.count  ) {
				
				
				success( array );
				
				self->_isUp = YES ;
			}else{
				
				self->_isUp = NO ;
			}
			
			if( self->_dataArr.count) {
				
				[QuickCreatUI dissmissNoContentView:self.collectionView tag:1]; //
				
			}else {
				
				[QuickCreatUI createNoContentImageView:self.collectionView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
			}
			
		}else{
			
			self->_isUp = NO ;
			
			if ( self.send_index == 1 ) { // 下拉刷新
				
				[self->_dataArr removeAllObjects];
				[self.collectionView.mj_header endRefreshing];
				
				[QuickCreatUI createNoContentImageView:self.collectionView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
				
			}else{ // 上拉加载
				
				[self.collectionView.mj_footer endRefreshingWithNoMoreData];
			}
			
		}
		
		
		
		[self.collectionView reloadData] ;
		
	} failure:^(NSError *error) {
		
		self->_isUp = NO ;
		
		if( self->_dataArr.count == 0) {
			
			[QuickCreatUI createNoContentImageView:self.collectionView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""] ;
		}
		
		[self.collectionView.mj_header endRefreshing] ;
		[self.collectionView.mj_footer endRefreshing] ;
		
		[SVProgressHUD showErrorWithStatus:@"请求错误"] ;
	}];
	
	
	NSLog(@"供子类重写") ;
}


-(void)ClickRefrishBtn:(UIButton *)btn {
	
	NSLog(@"无数据点击刷新") ;
}


/**
 网络请求
 */
-(void)getListData{
	
	
	NSLog(@"子类重写");
}

@end

#pragma mark 分类-添加刷新
@implementation FWQMUICollectionVC (collection_Upload)

/**
 添加下拉刷新
 */
-(void)addHeadRefreshMethod {
	
	WeakSelf;
	self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		weakSelf.send_index = weakSelf.current_index = 1 ;
		[weakSelf getListData];
	}];
	
}

-(void)addFootRefreshMethod {
	
	WeakSelf;
	self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		
		weakSelf.send_index = weakSelf.current_index + 1 ;
		[weakSelf getListData];
	}];
}

-(void)addHead{
	
	self.send_index = self.current_index = 1 ;
	[self getListData];
}

-(void)addFoot{
	
	self.send_index = self.current_index + 1 ;
	[self getListData];
}


/**
 上拉预加载
 */
-(void)addFootReFresh_YuLoadingMethod {
	
	_isFootRefresh = YES ;
}

@end


#pragma mark 重新布局-子类重写
@implementation FWQMUICollectionVC (collection_Layout)

-(void)layoutCollectionView{
	
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.edges.mas_equalTo( UIEdgeInsetsMake(0, 0, 0, 0));
	}];
}

@end

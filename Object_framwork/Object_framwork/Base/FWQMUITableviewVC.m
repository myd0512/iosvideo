//
//  FWQMUITableviewVC.m
//  Object_framwork
//
//  Created by 高通 on 2019/2/13.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "FWQMUITableviewVC.h"

@interface FWQMUITableviewVC ()<UITableViewDelegate , UITableViewDataSource >
{
	NSUInteger lastContentOffset ;
	BOOL _isUp ; // 滑动方向
	BOOL _isFootRefresh ; //开启预加载
}



@end

@implementation FWQMUITableviewVC

-(void)viewDidLoad{
    [super viewDidLoad];
    

}

-(void)viewWillAppear:(BOOL)animated{
	[ super viewWillAppear:animated];
	
}

/*
 * 重写 - 父类 方法
 */
-(void)initView{
    
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    _isUp = YES ;
    _isFootRefresh = NO ;
    
}

-(void)viewDidLayoutSubviews{
	[ super  viewDidLayoutSubviews ] ;
	
	[ self  layoutTableView ] ;
}


#pragma mark 代理事件
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	
	return self.sectionTitleArray.count ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return self.dataArr.count  ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return self.cell_height ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell * cell =  [[ UITableViewCell alloc] init];
	
	return cell ;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	UIView * view = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.01) ] ;
	
	return view ;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	
	return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	UIView * view = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.01) ] ;
	
	return view ;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	
	return 0.01 ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
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
	
	if ( _isFootRefresh&&scrollView == self.tableView ) {
		
		NSInteger tabHeight = 10 * 135 * self.current_index ;
		NSInteger scrol_he =  scrollView.contentOffset.y + self.tableView.height ;
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
-(UITableView *)tableView{
	
	if (_tableView == nil) {
		
		_tableView = [ [ UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped ] ;
		
		_tableView.delegate = self ;
		_tableView.dataSource = self ;
		
		/**
		 去掉 分割线   去掉滑动块
		 */
		_tableView.showsVerticalScrollIndicator = NO ;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone  ;
		
		/**
		 去掉 - 预估高度
		 */
		_tableView.estimatedRowHeight = 0;
		_tableView.estimatedSectionHeaderHeight = 0;
		_tableView.estimatedSectionFooterHeight = 0;
		
		_tableView.backgroundColor = MainGray ;
		
	}
	return _tableView ;
}

-(NSMutableArray *)dataArr{
	
	if (!_dataArr) {
		
		_dataArr = @[].mutableCopy ;
	}
	return _dataArr;
}

-(NSArray *)sectionTitleArray{
	
	if (!_sectionTitleArray) {
		
		_sectionTitleArray = @[@""] ;
	}
	return _sectionTitleArray ;
}


#pragma mark 网络请求-下拉刷新
-(void)getRefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile{
	
	/**
	 获取订单信息
	 */
	[[ZKHttpTool shareInstance] get: [ZKSeriverBaseURL getUrlType:self.url] params:self.params withHUD:NO success:^(id json) {
		
		NSLog(@" json = %@" , json ) ;
		
		if ( self.send_index == 1 ) { // 下拉刷新
			
			[self.dataArr removeAllObjects];
			
			[self.tableView.mj_header endRefreshing];
			[self.tableView.mj_footer resetNoMoreData];
		}else{ // 上拉加载
			
			self.current_index++ ;
			[self.tableView.mj_footer endRefreshing] ;
		}
		
		success( json ) ;
		
		if (self.isShowNoDataImg) {
			
			if( self.dataArr.count) {
				
				[QuickCreatUI dissmissNoContentView:self.tableView tag:1]; //
				
			}else {
				
				[QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
			}
			
		}
		
		[self.tableView reloadData] ;
		
	} failure:^(NSError *error) {
		
		if (self.isShowNoDataImg) {
			
			if( self.dataArr.count == 0) {
				
				[QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""] ;
			}
		}
		
		[self.tableView.mj_header endRefreshing] ;
		[self.tableView.mj_footer endRefreshing] ;
		
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
		
	} failure:^(NSError *error) {
		
		faile(error) ;
		
	}];
	
	
	NSLog(@"供子类重写") ;
}

-(void)ClickRefrishBtn:(UIButton *)sender{}

@end


/**
 网络数据分类
 */
@implementation FWQMUITableviewVC (TableView_NetDataGet)

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
				
				[self.tableView.mj_header endRefreshing];
				[self.tableView.mj_footer resetNoMoreData];
			}else{ // 上拉加载
				
				self.current_index++ ;
				[self.tableView.mj_footer endRefreshing] ;
			}
			
			NSArray * array = json[@"data"];
			
			if ( array && array.count  ) {
				
				
				success( array );
				
				self->_isUp = YES ;
			}else{
				
				self->_isUp = NO ;
			}
			
			if( self->_dataArr.count) {
				
				[QuickCreatUI dissmissNoContentView:self.tableView tag:1]; //
				
			}else {
				
				[QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
			}
			
		}else{
			
			self->_isUp = NO ;
			
			if ( self.send_index == 1 ) { // 下拉刷新
				
				[self->_dataArr removeAllObjects];
				[self.tableView.mj_header endRefreshing];
				
				[QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
				
			}else{ // 上拉加载
				
				[self.tableView.mj_footer endRefreshingWithNoMoreData];
			}
			
		}
	
		
		[self.tableView reloadData] ;
		
	} failure:^(NSError *error) {
		
		
		self->_isUp = NO ;
		
		if( self->_dataArr.count == 0) {
			
			[QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""] ;
		}
		
		[self.tableView.mj_header endRefreshing] ;
		[self.tableView.mj_footer endRefreshing] ;
		
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

/**
 刷新分类
 */
@implementation FWQMUITableviewVC (TableView_Upload)

/**
 添加下拉刷新
 */
-(void)addHeadRefreshMethod {
	
	WeakSelf;
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

		weakSelf.send_index = weakSelf.current_index = 1 ;
		[weakSelf getListData];
	}];
	
}

-(void)addFootRefreshMethod {
	
	WeakSelf;
	self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

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


@implementation FWQMUITableviewVC (TableView_Layout)

-(void)layoutTableView{
	
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.edges.mas_equalTo( UIEdgeInsetsMake(0, 0, 0, 0));
	}];
}

@end

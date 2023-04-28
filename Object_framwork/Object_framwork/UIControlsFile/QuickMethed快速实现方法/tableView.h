//
//  tableView.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/12.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.



快速创建 UITableView    ,   上下拉刷新  tableView

{
	int	_send_index ;
	int	_current_index ;
	NSMutableArray * _listArray ;
}

<UITableViewDelegate , UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;


-(UITableView *)tableView
{
	if(!_tableView) {
		_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT  ) style:UITableViewStyleGrouped];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.userInteractionEnabled = YES;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		_tableView.backgroundColor = [UIColor whiteColor];
	}
	return _tableView;
}




WeakSelf;
self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
	
	_send_index = _current_index = 1 ;
	[weakSelf getNetworkClassData];
}];

self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
	_send_index = _current_index + 1 ;
	[weakSelf getNetworkClassData];
}];




-(void)getNetworkClassData{
	
	NSDictionary * dict = @{ @"page":@( _send_index ) };
	
	//  NSLog(@"page _ _send_index = %@",dict) ;
	[[ ZKHttpTool shareInstance ] post:[ ZKSeriverBaseURL getNewUrlType:Type_Discount_list ] params:dict withHUD:NO success:^(id json) {
		//  NSLog( @"新车排行 NetworkClass json = %@" , json ) ;
		
		NSArray * array = json[@"body"];
		
		if ( array&&( array.count > 0 ) ) {// 200 请求成功有数据
			
			if ( _send_index == 1 ) { // 下拉刷新
				
				[_listArray removeAllObjects];
				
				[self.tableView.mj_header endRefreshing];
				[self.tableView.mj_footer resetNoMoreData];
			}else{ // 上拉加载
				
				_current_index++ ;
				[self.tableView.mj_footer endRefreshing] ;
			}
			
			for (NSDictionary * dic in array) {
				
				NewCarFirstModel * model = [NewCarFirstModel yy_modelWithJSON:dic ] ;
				
				[_listArray addObject:model];
			}
			
		}else{// 200 请求成功无数据
			
			if ( _send_index == 1 ) { // 下拉刷新
				
				[_listArray removeAllObjects];
				[self.tableView.mj_header endRefreshing];
				
			}else{ // 上拉加载
				[self.tableView.mj_footer endRefreshingWithNoMoreData];
			}
		}
		
		if( _listArray.count) {
			
			[NoDataViewManager dissmissNoContentView:self.tableView tag:1]; //
			
		}else {
			
			[NoDataViewManager createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
		}
		
		[self.tableView reloadData] ;
		
	} failure:^(NSError *error) {
		
		if( _listArray.count == 0) {
			
			[NoDataViewManager createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"网络开小差了" ClickBtnString:@"点击刷新"] ;
		}
		
		[self.tableView.mj_header endRefreshing];
		[self.tableView.mj_footer endRefreshing];
		
	}];
}



-(void)ClickRefrishBtn:(UIButton *)sender{
	
	_send_index = _current_index = 1 ;
	[ self getNetworkClassData ];

}

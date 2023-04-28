//
//  LYFViewController.m
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import "LYFViewController.h"

@interface LYFViewController () <UITableViewDataSource, UITableViewDelegate>

@end

static NSString *tableViewCell = @"UITableViewCell";

@implementation LYFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource / UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 40.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
//        cell.contentView.backgroundColor = randomColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"这里是%ld行", indexPath.row];
    
    return cell;
}


#pragma mark - 滑动方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    /// 当偏移量小于0时，不能滑动，并且使主要视图的UITableView滑动
    if (scrollView.contentOffset.y < 0 ) {
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        if (self.noScrollAction) {
            self.noScrollAction();
        }
    }
}

#pragma mark - Get方法
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - kNavigationBarHeight - 50.f) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
		
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
		
		_tableView.backgroundColor = RGB( 245 , 245 , 245 ) ;
		
    }
    
    return _tableView;
}

@end

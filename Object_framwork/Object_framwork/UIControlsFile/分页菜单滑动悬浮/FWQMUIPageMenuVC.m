//
//  FWQMUIPageMenuVC.m
//  Object_framwork
//
//  Created by 高通 on 2019/2/25.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "FWQMUIPageMenuVC.h"
#import "LYFTableView.h"
#import "LYFViewController.h"

@interface FWQMUIPageMenuVC ()


/// 列表(主列表，只有一个cell，用于装UICollectionView)
@property (nonatomic, strong) LYFTableView *tableView;
/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 第一个控制器
@property (nonatomic, strong) LYFViewController *lyfVCOne;
/// 第二个控制器
@property (nonatomic, strong) LYFViewController *lyfVCTwo;


@end

@implementation FWQMUIPageMenuVC

-(void)viewDidLoad{
	[super viewDidLoad];
	
	 self.title = @"列表";
}

-(void)initSubviews{
	
	self.isCanScroll = YES;
	
	[self addChildViewController:self.lyfVCOne];
	[self addChildViewController:self.lyfVCTwo];
	
	__weak typeof(self) weakSelf = self;
	self.lyfVCOne.noScrollAction = ^{
		weakSelf.isCanScroll = YES;
		weakSelf.lyfVCTwo.isCanScroll = NO;
		weakSelf.lyfVCTwo.tableView.contentOffset = CGPointZero;
	};
	
	self.lyfVCTwo.noScrollAction = ^{
		weakSelf.isCanScroll = YES;
		weakSelf.lyfVCOne.isCanScroll = NO;
		weakSelf.lyfVCOne.tableView.contentOffset = CGPointZero;
	};
	
	self.tableView.scrollAction = ^{
		
		CGFloat scrollY = [weakSelf.tableView rectForSection:0].origin.y;
		if (weakSelf.tableView.contentOffset.y >= scrollY) {
			if (weakSelf.isCanScroll == YES) {
				weakSelf.isCanScroll = NO;
				
				weakSelf.lyfVCOne.isCanScroll = YES;
				weakSelf.lyfVCOne.tableView.contentOffset = CGPointZero;
				weakSelf.lyfVCTwo.isCanScroll = YES;
				weakSelf.lyfVCTwo.tableView.contentOffset = CGPointZero;
			}
			
			weakSelf.tableView.contentOffset = CGPointMake(0, scrollY);
		}else{
			if (weakSelf.isCanScroll == NO) {
				weakSelf.tableView.contentOffset = CGPointMake(0, scrollY);
			}
		}
	};
	
	[self.view addSubview:self.tableView];
}


#pragma mark - Get方法
-(LYFTableView *)tableView {
	if (!_tableView) {
		_tableView = [[LYFTableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, WIDTH, HEIGHT - kNavigationBarHeight ) style:UITableViewStylePlain];
		/// 把控制器传给tableView，这样逻辑就在view中，viewController显得整齐（个人习惯）
		_tableView.viewController = self;
	}
	
	return _tableView;
}

-(LYFViewController *)lyfVCOne {
	if (!_lyfVCOne) {
		_lyfVCOne = [[LYFViewController alloc] init];
	}
	
	return _lyfVCOne;
}

-(LYFViewController *)lyfVCTwo {
	if (!_lyfVCTwo) {
		_lyfVCTwo = [[LYFViewController alloc] init];
	}
	
	return _lyfVCTwo;
}

@end

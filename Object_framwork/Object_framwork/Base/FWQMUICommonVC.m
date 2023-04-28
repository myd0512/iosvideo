//
//  FWQMUICommonVC.m
//  Object_framwork
//
//  Created by 高通 on 2019/2/12.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "FWQMUICommonVC.h"

@interface FWQMUICommonVC ()<UIScrollViewDelegate>

@end

@implementation FWQMUICommonVC

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view .
	
    self.topY = 0 ;
//    [self setHidesBottomBarWhenPushed:YES] ;
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"black_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self initView];
    [self initSubviews];
}
//
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count==1) {
           self.tabBarController.tabBar.hidden = NO;
    }else{
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated] ;
    if (self.navigationController.viewControllers.count<=2) {
              self.tabBarController.tabBar.hidden = NO;
    }else{
        self.tabBarController.tabBar.hidden = YES;
    }
}


/*
 * 子类 - 重写布局子控件
 */
-(void)initSubviews{}
/*
 * 子类 - 重写布局子控件
 */
-(void)initView{}

/*
 * 返回按钮 - 触发方法
 */
-(void)clickBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 懒加载
/**
 *
 * 背景 - 滑动视图
 */
-(UIScrollView *)baseBackScrollView{
	
	if ( _baseBackScrollView == nil) {
		
		
		[self.view addSubview: _baseBackScrollView = [[ UIScrollView alloc] initWithFrame:self.view.bounds]] ;
		
		_baseBackScrollView.delegate = self ;
		
		_baseBackScrollView.showsHorizontalScrollIndicator = NO ;
		_baseBackScrollView.showsVerticalScrollIndicator = NO ;
		
		_baseBackScrollView.backgroundColor = [UIColor whiteColor] ;
		
	}
	return _baseBackScrollView ;
}


/**
 *
 * 背景 - 滑动视图
 */
-(UIView *)baseBackView{
	
	if (_baseBackView == nil) {
		
		[ self.baseBackScrollView  addSubview: _baseBackView = [[ UIView alloc] initWithFrame:self.view.bounds ] ];
		
		_baseBackView.backgroundColor = [ UIColor   whiteColor ] ;
		
	}
	return _baseBackView ;
}


-(NSInteger)send_index{
	
	if (_send_index == 0 ) {
		_send_index = 1 ;
	}
	return _send_index ;
}


-(NSInteger)current_index{
	
	if (_current_index == 0 ) {
		_current_index = 1 ;
	}
	return _current_index ;
}

-(NSInteger)pageCount{
	
	return 10 ;
}

-(NSInteger)cell_height{
	
	if (  _cell_height == 0  ) {
		
		return 100.0 ;
	}
	return _cell_height ;
}


#pragma mark 网络请求-无刷新
-(void)getNORefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile{
	/**
	 获取订单信息
	 */
	[[ZKHttpTool shareInstance] get: [ZKSeriverBaseURL getUrlType:self.url]  params: self.params withHUD:NO success:^(id json) {
		
		NSLog(@" json = %@" , json ) ;
		
		success( json ) ;
		
	} failure:^(NSError *error) {
		
		faile(error) ;
		
	}];
	
	NSLog(@"供子类重写") ;
}



- (void)dealloc
{
	NSLog(@"dealloc %@", [self description]);
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}


@end



@implementation FWQMUICommonVC (LoadingStatus)



@end

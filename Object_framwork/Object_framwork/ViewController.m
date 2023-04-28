//
//  ViewController.m
//  Object_framwork
//
//  Created by 高通 on 2018/11/8.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.

#import "ViewController.h"
@interface ViewController ()
{
	
}
@property( strong , nonatomic ) UIScrollView *  scrollView ;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = kGrayColor ;
	
	[self setUpUI];
}

// 设置引导页
-(void)setUpUI{
	
	NSArray * colorArr = @[ kBlueColor , kYellowColor ,kRedColor , kPurpleColor ] ;
	
	_scrollView = [[UIScrollView alloc ] initWithFrame:kScreenBounds] ;
	[self.view addSubview:_scrollView];
	_scrollView.pagingEnabled = YES ;
	_scrollView.bounces = NO ;
	_scrollView.contentSize = CGSizeMake(WIDTH*colorArr.count, 0) ;
	
	for (int i = 0; i < colorArr.count ; i++) {
		
		UIImageView * imgView =[[UIImageView alloc] initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, HEIGHT)];
		imgView.image = [ UIImage  imageNamed:@"" ];
		[_scrollView addSubview:imgView];
		
		imgView.userInteractionEnabled = YES;
		if (i == colorArr.count - 1) {
			
			//点击手势
			UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
			tapClick.numberOfTapsRequired = 1;
			[imgView addGestureRecognizer:tapClick];

		}
	}
}

-(void)tapClick:(UITapGestureRecognizer *)sender{
	
	CATransition *anim = [[CATransition alloc] init];
	anim.type = @"rippleEffect";
	anim.duration = 1.0;
	[[UIApplication sharedApplication].delegate.window.layer addAnimation:anim forKey:nil];

	[ [ UIApplication  sharedApplication ].delegate.window setRootViewController:[[FWQMUIBaseTabBarVC alloc] init ] ] ;
	
}

@end

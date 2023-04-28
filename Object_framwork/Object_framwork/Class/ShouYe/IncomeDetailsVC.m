//
//  IncomeDetailsVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "IncomeDetailsVC.h"
#import "MLMSegmentManager.h"
#import "IncomeInfoTypeVC.h"



@interface IncomeDetailsVC ()
{
    NSArray * titleList;
    NSArray * VCList;
    NSArray * VCNameList ;
}
@property (nonatomic, strong) MLMSegmentHead *segHead ;
@property (nonatomic, strong) MLMSegmentScroll *segScroll ;

@end

@implementation IncomeDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 11.0, *)) {
        _segScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever ;
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO ;
        
    }
    self.view.backgroundColor = kWhiteColor ;
    [self setSubViewAttrs];
}

/**
 设置  控件属性
 */
-(void)setSubViewAttrs{
    
    self.title = @"收入详情" ;
    
    titleList = @[  @"全部" , @"订阅" , @"礼物" , @"佣金", @"提现" ,@"其他"  ];
    
    VCList = @[ [[IncomeInfoTypeVC alloc]initWithType:1] , [[IncomeInfoTypeVC alloc]initWithType:2] , [[IncomeInfoTypeVC alloc]initWithType:3] ,  [[IncomeInfoTypeVC alloc]initWithType:4] ,[[IncomeInfoTypeVC alloc]initWithType:5] , [[IncomeInfoTypeVC alloc]initWithType:6] ] ;
    
    VCNameList = @[  @"IncomeInfoTypeVC1" , @"IncomeInfoTypeVC2" , @"IncomeInfoTypeVC3" , @"IncomeInfoTypeVC4" ,@"IncomeInfoTypeVC5" ,@"IncomeInfoTypeVC6" ] ;
    
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake( 0 , kNavigationBarHeight   , WIDTH, 50) titles:titleList headStyle:SegmentHeadStyleLine layoutStyle:MLMSegmentLayoutDefault] ;
    _segHead.fontScale = 1.0 ;
    _segHead.fontSize = 14 ;
    _segHead.lineColor = kRedColor ;
    _segHead.bottomLineColor = lineGray ;
    _segHead.bottomLineHeight = 0.01 ;
    _segHead.selectColor = oneBlaceFont ;
    _segHead.lineScale = 0.7 ;
    _segHead.classNameArray = VCNameList ;
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight + 50 , WIDTH , HEIGHT - kNavigationBarHeight - 50  - kTabBarStatusBarHeight ) vcOrViews:VCList];
    
    _segScroll.loadAll = NO ;
    _segScroll.showIndex = 0 ;
    _segScroll.countLimit = 6 ;
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    }];
    
}



@end

//
//  MenuView.m
//  Object_framwork
//
//  Created by apple on 2020/4/25.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "MenuView.h"
#import "GameinfoListVC.h"
#import "JGMessageInfoVC.h"
#import "LiwuListVC.h"
#import "MLMSegmentManager.h"
#import "IncomeInfoTypeVC.h"



@interface MenuView ()
{
    NSArray * titleList;
    NSArray * VCList;
    NSArray * VCNameList ;
}
@property(strong , nonatomic)  UIView * bottomView ;
@property (nonatomic, strong) MLMSegmentHead *segHead ;
@property (nonatomic, strong) MLMSegmentScroll *segScroll ;

@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self updataInfo];
        
    }
    return self;
}

/*
 * 刷新 - 子控件
 */
-(void)updataInfo{
    
    self.backgroundColor = kClearColor ;
    self.bottomView = [QuickCreatUI creatUIViewWithSuperView:self andFrame:CGRectMake(0, 0, WIDTH , WIDTH * 1792/1506) color:kClearColor];
    self.bottomView.bottom = HEIGHT ;
    self.bottomView.layer.contents = (id)[UIImage imageNamed:@"bg_dlg_gift_list"].CGImage;
    
    titleList = @[ @"礼物" , @"游戏" ];
    
    VCList = @[  [[LiwuListVC alloc]init]  , [[GameinfoListVC alloc]init]  ] ;
    
    VCNameList = @[  @"IncomeInfoTypeVC1" , @"IncomeInfoTypeVC3" ] ;
    
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake( 0 , 0   , WIDTH, 44) titles:titleList headStyle:SegmentHeadStyleDefault layoutStyle:MLMSegmentLayoutCenter] ;
    _segHead.fontScale = 1.0 ;
    _segHead.fontSize = 14 ;
    _segHead.lineColor = kBlackColor ;
    _segHead.bottomLineColor = kBlackColor ;
    _segHead.bottomLineHeight = 0.01 ;
    _segHead.selectColor = kRedColor ;
//    _segHead.lineScale = 0.7 ;
    _segHead.classNameArray = VCNameList ;
    _segHead.headColor = kClearColor ;
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake( 0 , 44 , WIDTH , self.bottomView.height - 60 - kTabBarStatusBarHeight ) vcOrViews:VCList];
    _segScroll.backgroundColor = kClearColor ;
    _segScroll.loadAll = NO ;
    _segScroll.showIndex = 0 ;
    _segScroll.countLimit = 3 ;
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        
        [self.bottomView addSubview:self.segHead];
        [self.bottomView addSubview:self.segScroll];
    }];
    
    UIButton * cancleBtn = [ QuickCreatUI creatUIButton_Image_WithSuperView:self.bottomView andFrame:CGRectMake(0, 0, 44, 44) image:@"srxq_xlhbtn" andTarget:self SEL:@selector(clickBackBtn) ] ;
    cancleBtn.right = WIDTH - 10 ;
    cancleBtn.top = 5 ;
}

/*
 * 压下 - 视图
 */
-(void)clickBackBtn{
    
    [self close];
}

-(void)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.top = 0 ;
    }];
}

-(void)close{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.top = HEIGHT ;
    }];
}

@end

//
//  YSHomeVC.m
//  Object_framwork
//
//  Created by 高通 on 2019/2/16.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.

#import "YSHomeVC.h"
#import "OpenLiveBroadVC.h"
#import "IncomeDetailsVC.h"
#import "MyTuanduiTabBarVC.h"
#import "RankingListVC.h"
#import "myProfitVC.h"
@interface YSHomeVC ()

@property( strong , nonatomic ) UILabel * nameLabel ;
@property( strong , nonatomic ) UILabel * pyNameLabel ;
@property( strong , nonatomic ) UILabel * timeLabel ;
@property( strong , nonatomic ) UILabel * moneyLabel ;

@end

@implementation YSHomeVC

- (BOOL)fd_prefersNavigationBarHidden{
	return YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getHomeInfo] ;
}

-(void)getHomeInfo{
    
    self.url = User_today ;
    self.params = @{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
    };
    
    NSLog(@"params = %@", self.params ) ;
    
    [self getNORefreshDataWithSuccess:^(id  _Nonnull json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * dict = dataArr.firstObject ;
        dataArr = dict[@"time"][@"sec"];
        
        double money = [ dict[@"today_income_total"] doubleValue] ;
        
        self.timeLabel.text = [NSString stringWithFormat:@"%@",dataArr.firstObject] ;
        self.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",money];
        
    } andFaile:^(id  _Nonnull json) {
        
    }];
    
}

-(void)initSubviews{
    [self getCommonInfo];
    UIView * topView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, 0, WIDTH, syTopBackVHeight ) color:[UIColor whiteColor]] ;
    topView.layer.contents = (id)[UIImage imageNamed:@"WechatIMG28"].CGImage;
    topView.contentMode = UIViewContentModeScaleToFill ;
    
    self.pyNameLabel = [QuickCreatUI creatUILabelWithSuperView:self.view andFrame:CGRectMake(lrPad, kStatusBarHeight  , WIDTH - 2*lrPad, 25) andText:@"WELCOME" andStringColor:[UIColor whiteColor] andFont:20];
    self.pyNameLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    
    self.nameLabel = [QuickCreatUI creatUILabelWithSuperView:self.view andFrame:CGRectMake(15, self.pyNameLabel.bottom   , WIDTH - 30, 25) andText:@"主播助手" andStringColor:[UIColor whiteColor] andFont:20];
    self.nameLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    
    [self setMoneyInfo];
    [self getHomeInfo];
}

/*
 * 布局今日信息view
 */
-(void)setMoneyInfo{
    //初始化底层 view
    UIView * zbInfoView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(lrPad, self.nameLabel.bottom + lrPad, WIDTH - 2*lrPad, syInfoHeight) color:[UIColor whiteColor]] ;
    //添加阴影
    CALayer *subLayer=[CALayer layer];
    CGRect fixframe = zbInfoView.frame;
    subLayer.frame= fixframe;
    subLayer.cornerRadius=8;
    subLayer.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    subLayer.masksToBounds=NO;
    subLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = CGSizeMake(3,2);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    subLayer.shadowOpacity = 0.3;//阴影透明度，默认0
    subLayer.shadowRadius = 3;//阴影半径，默认3
    [self.view.layer insertSublayer:subLayer below:zbInfoView.layer];
    [zbInfoView viewCornersWith:8.0];
    
    UILabel * titleLabel = [QuickCreatUI creatUILabelWithSuperView:zbInfoView andFrame:CGRectMake(0, 5, zbInfoView.width, 30) andText:@"- 今日 -" andStringColor:twoBlaceFont andFont:14];
    titleLabel.textAlignment = NSTextAlignmentCenter ;
    
    self.timeLabel = [QuickCreatUI creatUILabelWithSuperView:zbInfoView andFrame:CGRectMake(0, titleLabel.bottom+ 10, zbInfoView.width / 2, 20) andText:@"00:00:00" andStringColor:oneBlaceFont andFont:15];
    self.timeLabel.textAlignment = NSTextAlignmentCenter ;
    
    UILabel * subtitle = [QuickCreatUI creatUILabelWithSuperView:zbInfoView andFrame:CGRectMake(0, self.timeLabel.bottom , zbInfoView.width / 2, 20) andText:@"⊙ 开播时长" andStringColor:[UIColor orangeColor] andFont:13];
    subtitle.textAlignment = NSTextAlignmentCenter ;
    
    self.moneyLabel = [QuickCreatUI creatUILabelWithSuperView:zbInfoView andFrame:CGRectMake(zbInfoView.width / 2, titleLabel.bottom + 10, zbInfoView.width / 2, 20) andText:@"¥ 0.00" andStringColor:oneBlaceFont andFont:15];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter ;
    
    UILabel * subtitleT = [QuickCreatUI creatUILabelWithSuperView:zbInfoView andFrame:CGRectMake(zbInfoView.width / 2, self.moneyLabel.bottom , zbInfoView.width / 2, 20) andText:@"⊙ 我的收入" andStringColor:[UIColor redColor] andFont:13];
    subtitleT.textAlignment = NSTextAlignmentCenter ;
    
   [QuickCreatUI creatUIViewWithSuperView:zbInfoView andFrame:CGRectMake(zbInfoView.width / 2, titleLabel.bottom + 10, 1, 35) color:lineGray];
    
    [self getmenuViewHeight:zbInfoView.bottom ] ;
}

// 设置 - 菜单栏选项
-(void)getmenuViewHeight:(double )height{
    
    double top = height + 15 ;
    NSArray * titleArr =  @[@"提现",@"排行榜"];
    NSArray * imgArr =  @[@"qb_ico",@"icon_rank"];
    for (int i = 0; i< titleArr.count; i++) {
        
        UIView * backVIew = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(lrPad, top, WIDTH - 2*lrPad, 50) color:[UIColor whiteColor]] ;
        backVIew.tag = i ;
        UIImageView * imageView = [QuickCreatUI creatUIImageViewWithSuperView:backVIew andFrame:CGRectMake(0, 0, 25, 25) andImg:imgArr[i]];
        imageView.centerY = backVIew.height / 2 ;
        
        UILabel * titleLabel = [ QuickCreatUI creatUILabelWithSuperView:backVIew andFrame:CGRectMake(imageView.right + 15, 0, backVIew.width - imageView.right - 25, 49) andText:titleArr[i] andStringColor:oneBlaceFont andFont:14] ;
        
        UIImageView * tralingImg = [QuickCreatUI creatUIImageViewWithSuperView:backVIew andFrame:CGRectMake(0, 0, 7, 12) andImg:@"tuikuan_gengduo"];
        tralingImg.centerY = backVIew.height / 2 ;
        tralingImg.right = backVIew.width  ;
        
        [QuickCreatUI creatUIViewWithSuperView:backVIew andFrame:CGRectMake(35, titleLabel.bottom , backVIew.width - 35, 1) color:lineGray];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenu:)];
               [backVIew addGestureRecognizer:tap];
        
        top += backVIew.height ;
    }
    
}

-(void)clickMenu:(UITapGestureRecognizer *)sender{
    
    UIView * view = sender.view;
    NSInteger tag = view.tag ;
    
    NSLog(@" tag = %ld",(long)tag) ;
    
    if (tag == 0) {
        
        MyPushVC( [myProfitVC new] ) ;
    }
//    else if (tag == 1){
//        MyPushVC( [IncomeDetailsVC new] ) ;
//    }
//    else if (tag == 1){
//        MyTuanduiTabBarVC *  vc = [MyTuanduiTabBarVC new];
//        vc.hidesBottomBarWhenPushed = YES ;
//        MyPushVC( vc ) ;
//    }
    else if (tag == 1){
        MyPushVC([RankingListVC new]) ;
//        MyPushVC([OpenLiveBroadVC new]) ;
    }
}




/*
 * =======请求配置信息=======
 */
-(void)getCommonInfo{
    
    [[ZKHttpTool shareInstance] post:[ZKSeriverBaseURL getUrlType:GetConfig] params:@{} success:^(id json) {
        
        NSLog(@"josn = %@" , json );
        if ([json[@"code"]  intValue] == 0) {
            NSArray * arr = json[@"info"] ;
            NSDictionary *subdic = [arr firstObject];
            if (![subdic isEqual:[NSNull null]]) {
                liveCommon *commons = [[liveCommon alloc]initWithDic:subdic];
                [common saveProfile:commons];
            }
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}



@end

//
//  MyInfoVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "MyInfoVC.h"
#import "userInfo.h"
#import "LiveHistory.h"
#import "SettingVC.h"
#import "MenuView.h"
#import "MyInfoModel.h"



@interface MyInfoVC ()

@property( strong , nonatomic ) UILabel * nameLabel ;
@property( strong , nonatomic ) UILabel * accountLabel ;
@property( strong , nonatomic ) UILabel * homeLabel ;
@property( strong , nonatomic ) UIImageView * iconImageView ;
@property(strong , nonatomic) MyInfoModel * modelInfo ;

@end

@implementation MyInfoVC

- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    
    [self getUserInfo];
}

-(void)initSubviews{
    
    self.view.backgroundColor = kWhiteColor ;
    UIImageView * topimg = [QuickCreatUI creatUIImageViewWithSuperView:self.view andFrame:CGRectMake(0, 0, WIDTH, grTopViewHeight) andImg:@"7501"] ;
    topimg.contentMode = UIViewContentModeScaleAspectFill ;
    
    
    [self getUserInfoView];
    [self getmenuViewHeight:topimg.bottom ];
}


/*
 * 获取用户 - 信息
 */
-(void)getUserInfo{
    
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:GetBaseInfo] params:@{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
        @"version_ios":@"1",
    } withHUD:NO success:^(id json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * dict = dataArr.firstObject ;
        self.modelInfo = [MyInfoModel yy_modelWithJSON:dict ];
        [UserInfoManaget sharedInstance].infoModel = self.modelInfo ;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.modelInfo.avatar]];
        self.nameLabel.text = self.modelInfo.user_nicename ;
//        self.accountLabel.text = self.modelInfo.
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

-(void)getUserInfoView{
    
    UIView * backView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, 0, WIDTH, 100) color:[UIColor clearColor] ] ;
    
    backView.bottom = grTopViewHeight ;
    backView.layer.contents = (id)[ UIImage imageNamed:@"WechatIMG27"].CGImage;
    
//    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
//    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];

//    位置x,y    自己根据需求进行设置   使其从不同位置进行渐变
//    gradientLayer.startPoint = CGPointMake(0.5, 0);
//    gradientLayer.endPoint = CGPointMake(0.5, 1);
//    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(backView.frame), CGRectGetHeight(backView.frame));
//    [backView.layer addSublayer:gradientLayer];
    
    self.iconImageView = [QuickCreatUI creatUIImageViewWithSuperView:backView andFrame:CGRectMake(lrPad, 0, 70, 70) andImg:@"launch_logo"];
    self.iconImageView.centerY = backView.height /2 ;
    [self.iconImageView viewCornersWith:35];
    self.iconImageView.layer.borderWidth = 1.0 ;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.nameLabel = [QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(self.iconImageView.right + 10, 0, WIDTH -self.iconImageView.right -10 - lrPad , 20) andText:@"姓名 - Man" andStringColor:oneBlaceFont andFont:14];
    
//    self.accountLabel = [QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(self.iconImageView.right + 10, 0, WIDTH -self.iconImageView.right -10 - lrPad , 20) andText:@"账号: - 786786786" andStringColor:oneBlaceFont andFont:13];
//
//    self.homeLabel = [QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(self.iconImageView.right + 10, 0, WIDTH -self.iconImageView.right -10 - lrPad , 20) andText:@"家族: - 热血" andStringColor:oneBlaceFont andFont:13];
    
//    self.accountLabel.centerY = backView.height /2 ;
    self.nameLabel.centerY = backView.height /2 ;
//    self.homeLabel.top = self.accountLabel.bottom ;
    
}


// 设置 - 菜单栏选项
-(void)getmenuViewHeight:(double )height{
    
    double top = height + 15 ;
    NSArray * titleArr =  @[@"个人资料",@"开播历史",@"设置"];
    NSArray * imgArr =  @[@"ic_userinfo",@"ic_kbls",@"ic_setting"];
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

/*
 * 点击菜单选项
 */
-(void)clickMenu:(UITapGestureRecognizer *)sender{
    
    UIView * view = sender.view;
    NSInteger tag = view.tag ;
    
    NSLog(@" tag = %ld",(long)tag) ;
    
    if( tag == 0 ){ // 点击了 个人资料
        
//        [self getUserInfo];
        MyPushVC([userInfo new]);
        
    }else if( tag == 1 ){// 点击了开播历史
         MyPushVC([LiveHistory new]);
    }else if( tag == 2 ){// 点击了设置
        MyPushVC([SettingVC new ]) ;
    }
}





@end

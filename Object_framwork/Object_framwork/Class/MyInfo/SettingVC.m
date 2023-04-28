//
//  SettingVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "SettingVC.h"
#import "ChangeLoginPWVC.h"
#import "LoginVC.h"



@interface SettingVC ()

@end

@implementation SettingVC{
   
    double top  ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置" ;
    self.view.backgroundColor = MainGray;
    top = 0;
}

-(void)initSubviews{

    
    top += kNavigationBarHeight;
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [self getViewWith:@"修改登录密码" andSubString:@"" andIsClick:YES andTag:1];
    [self getViewWith:StringFormat(@"当前版本:V%@",app_Version) andSubString:@"" andIsClick:YES andTag:2];
    
    UIButton * loginBtn = [ QuickCreatUI creatUIButtonWithSuperView:self.view andFrame:CGRectMake(100, 0, WIDTH - 200, 44) andText:@"退出登录" andStringColor:[UIColor redColor] andFont:15 andTarget:self SEL:@selector(clickLogOut)] ;
    [loginBtn viewCornersWith:22.0];
    loginBtn.backgroundColor = kWhiteColor ;
    loginBtn.bottom = HEIGHT - kTabBarStatusBarHeight ;
    
    //添加阴影
    CALayer *subLayer=[CALayer layer];
    CGRect fixframe = loginBtn.frame;
    subLayer.frame= fixframe;
    subLayer.cornerRadius=22;
    subLayer.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    subLayer.masksToBounds=NO;
    subLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = CGSizeMake(3,2);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    subLayer.shadowOpacity = 0.3;//阴影透明度，默认0
    subLayer.shadowRadius = 3;//阴影半径，默认3
    [self.view.layer insertSublayer:subLayer below:loginBtn.layer];
  
    
}

/*
 * 登出
 */
-(void)clickLogOut{
    
    [UserInfoManaget sharedInstance].model.isOpenLiveing = NO ;
    [[UserInfoManaget sharedInstance] save:[UserInfoManaget sharedInstance].model];
    MyPushVC( [LoginVC new] ) ;
    NSLog(@"退出登录") ;
}

-(void)getViewWith:(NSString *)title andSubString:(NSString*)subString  andIsClick:(BOOL)isClick andTag:(NSInteger)tag{
    
    UIView * backView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 44) color:[UIColor whiteColor]] ;
    backView.tag = tag ;
    [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:title andStringColor:twoBlaceFont andFont:14];
    
    
    UILabel * tralingLabel = [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:subString andStringColor:oneBlaceFont andFont:14];
    tralingLabel.textAlignment = NSTextAlignmentRight;
    
    UIImageView * icon = [QuickCreatUI creatUIImageViewWithSuperView:backView andFrame:CGRectMake(0, 0, 7, 12) andImg:@"tuikuan_gengduo"];
    icon.centerY = 22 ;
    icon.right = WIDTH - lrPad ;
    tralingLabel.right = icon.left - 10 ;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenu:)];
    [backView addGestureRecognizer:tap];
    
    UIView * lineView = [QuickCreatUI creatUIViewWithSuperView:backView andFrame:CGRectMake(0, 0, WIDTH, 1) color:MainGray];
    lineView.bottom = backView.height ;
    
    top += 44 ;
}

/*
 * 点击菜单选项
 */
-(void)clickMenu:(UITapGestureRecognizer *)sender{
    
    UIView * view = sender.view;
    NSInteger tag = view.tag ;
    
    NSLog(@" tag = %ld",tag) ;
    
    if( tag == 1 ){ // 点击了 修改密码
        MyPushVC([ChangeLoginPWVC new]) ;
    }else if( tag == 2 ){// 点击了查看当前版本
        
    }
}

@end

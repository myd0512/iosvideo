//
//  LoginVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/25.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UIImageView *backImgView;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UIView *pwsView;
@property (weak, nonatomic) IBOutlet UITextField *pws;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.accountView viewCornersWith:25];
    [self.pwsView viewCornersWith:25];
    [self.loginBtn viewCornersWith:25];
    
    [self.view bringSubviewToFront:self.accountView];
    [self.view bringSubviewToFront:self.pwsView];
    [self.view bringSubviewToFront:self.loginBtn];
    
}

- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}
  
-(BOOL)fd_interactivePopDisabled{
    return YES;
}

/*
 * 登录 - 登录页面
 */
- (IBAction)clickLogin:(UIButton *)sender {
    
    if( self.account.text.length == 0 || self.pws.text.length == 0){
        [SVProgressHUD showSuccessWithStatus:@"请完善信息"];
        return;
    }
    
    NSDictionary * dict = @{
        @"user_login":self.account.text,
          @"user_pass":self.pws.text,
        @"source":@"zb"
      };
      [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:Login] params:dict withHUD:YES success:^(id json) {

          NSLog(@"json = %@" , json ) ;
          NSDictionary * data = json[@"data"];
          if ([data[@"code"]  intValue ] == 0) {
            
              NSArray * dataArr = json[@"data"][@"info"];
              UserInfoModel * model = [UserInfoModel yy_modelWithJSON:dataArr.firstObject] ;
              model.isOpenLiveing = YES ;
              [UserInfoManaget sharedInstance].model = model;
              [[UserInfoManaget sharedInstance] save:model];
              
              CATransition *anim = [[CATransition alloc] init];
              anim.type = @"rippleEffect";
              anim.duration = 1.0;
              [[UIApplication sharedApplication].delegate.window.layer addAnimation:anim forKey:nil];
              [[UIApplication sharedApplication].delegate.window setRootViewController:[FWQMUIBaseTabBarVC new] ];
              
          }else{
              [SVProgressHUD  showErrorWithStatus:json[@"data"][@"msg"]] ;
          }

      } failure:^(NSError *error) {

          NSLog(@"error =  %@" ,[error description] ) ;
      }];
}



@end

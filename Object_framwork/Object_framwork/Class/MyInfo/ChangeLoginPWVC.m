//
//  ChangeLoginPWVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "ChangeLoginPWVC.h"

@interface ChangeLoginPWVC ()

@property(strong , nonatomic) UITextField * oldTextField ;
@property(strong , nonatomic) UITextField * neTextFiled ;
@property(strong , nonatomic) UITextField * neTextField2 ;


@end

@implementation ChangeLoginPWVC{
   
    double top  ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改登录密码" ;
    self.view.backgroundColor = MainGray;
    top = 0;
}

-(void)initSubviews{
    
    top += kNavigationBarHeight;
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    
    UIView * backView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH , 50) color:kWhiteColor];
    UITextField * textfield = [[ UITextField alloc] initWithFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 50)];
    textfield.placeholder = @"请输入原密码";
    textfield.font = [UIFont systemFontOfSize:15];
    textfield.backgroundColor = kWhiteColor;
    [backView addSubview:textfield];
    top += 50 ;
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 1) color:MainGray];
    top += 1 ;
    self.oldTextField = textfield;
    
    UIView * backView1 = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH , 50) color:kWhiteColor];
    UITextField * textfield1 = [[ UITextField alloc] initWithFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 50)];
    textfield1.placeholder = @"请输入新密码";
    textfield1.font = [UIFont systemFontOfSize:15];
    textfield1.backgroundColor = kWhiteColor;
    [backView1 addSubview:textfield1];
    top += 50 ;
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 1) color:MainGray];
    top += 1 ;
    self.neTextFiled = textfield1;
    
    UIView * backView2 = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH , 50) color:kWhiteColor];
    UITextField * textfield2 = [[ UITextField alloc] initWithFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 50)];
    textfield2.placeholder = @"请输入新密码";
    textfield2.font = [UIFont systemFontOfSize:15];
    textfield2.backgroundColor = kWhiteColor;
    [backView2 addSubview:textfield2];
    self.neTextField2 = textfield2;
    
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickRightBtn) string:@"保存" font:15 stringColor:[UIColor blueColor] ];
}

/*
 * 点击保存
 */
-(void)clickRightBtn{
    
    if (self.oldTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请完善信息重新提交"];
        return ;
    }
    
    if (self.neTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请完善信息重新提交"];
        return ;
    }
    
    if (self.neTextField2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请完善信息重新提交"];
        return ;
    }
    
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:UpdatePass] params:@{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
        @"oldpass":self.oldTextField.text ,
        @"pass":self.neTextFiled.text ,
        @"pass2":self.neTextField2.text
    } withHUD:NO success:^(id json) {
            
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * dict = dataArr.firstObject ;
        [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
        [self.navigationController popViewControllerAnimated:YES] ;
        
    } failure:^(NSError *error) {
        
        
    }];

    NSLog(@"点击保存") ;
}


/*
 * 登出
 */
-(void)clickLogOut{
    
    NSLog(@"退出登录") ;
}

-(void)getViewWith:(NSString *)title andSubString:(NSString*)subString  andIsClick:(BOOL)isClick andTag:(NSInteger)tag{
    
    UIView * backView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 44) color:[UIColor whiteColor]] ;
    backView.tag = tag ;
    [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:title andStringColor:twoBlaceFont andFont:14];
    
    
    UILabel * tralingLabel = [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:subString andStringColor:oneBlaceFont andFont:14];
    tralingLabel.textAlignment = NSTextAlignmentRight;
    
    if (isClick) {
        
        UIImageView * icon = [QuickCreatUI creatUIImageViewWithSuperView:backView andFrame:CGRectMake(0, 0, 7, 12) andImg:@"tuikuan_gengduo"];
        icon.centerY = 22 ;
        icon.right = WIDTH - lrPad ;
        tralingLabel.right = icon.left - 10 ;
        
    }
    
    if (isClick) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenu:)];
        [backView addGestureRecognizer:tap];
        
    }
    
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
    
    if( tag == 1 ){ // 点击了 个人资料
       
    }else if( tag == 3 ){// 点击了修改昵称
//        MyPushVC([ChangeNameVC new]);
    }
}
@end

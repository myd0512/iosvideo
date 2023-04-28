//
//  SetContantView.m
//  Object_framwork
//
//  Created by mac on 2020/7/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "SetContantView.h"

@implementation SetContantView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setInfoView];
    }
    return self;
}

-(void)setInfoView{
    
    self.frame = CGRectMake(0, 0, WIDTH*0.7, 180);
    self.layer.cornerRadius = 8.0 ;
    self.layer.masksToBounds = YES ;
    self.backgroundColor = kWhiteColor ;
    
    UILabel * topLabel = [QuickCreatUI creatUILabelWithSuperView:self andFrame:CGRectMake(0, 15, self.width , 25) andText:@"设置联系方式" andStringColor:kBlackColor andFont:15  ] ;
    topLabel.font = [UIFont systemFontOfSize:15 weight:3] ;
    topLabel.textAlignment = NSTextAlignmentCenter ;
    
    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, topLabel.bottom + 20, self.width - 40, 40)] ;
    textfield.keyboardType = UIKeyboardTypeEmailAddress ;
    textfield.placeholder = @"请输入联系方式" ;
    textfield.textColor = kBlackColor ;
    textfield.layer.borderColor = RGB(239, 239, 239).CGColor;
    textfield.layer.borderWidth = 1.0 ;
    self.textField = textfield ;
    [self addSubview:textfield];
    
    UIButton * subBtn = [QuickCreatUI creatUIButtonWithSuperView:self andFrame:CGRectMake(20, textfield.bottom + 20, self.width - 40, 40) andText:@"确定" andStringColor:kWhiteColor andFont:15 andTarget:self SEL:@selector(clickSubBtn)];
    subBtn.layer.cornerRadius = 20 ;
    subBtn.layer.masksToBounds = YES ;
    subBtn.backgroundColor = [UIColor  redColor ] ;
}

-(void)clickSubBtn{
    
    NSDictionary * para = @{ @"contact":self.textField.text };
    NSLog(@"paraString = %@", [para yy_modelToJSONString]) ;
    NSDictionary * params = @{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
        @"fields":[para yy_modelToJSONString]
    };
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:UpdateFields] params:params withHUD:NO success:^(id json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * dict = dataArr.firstObject ;
        [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
        
        [UserInfoManaget sharedInstance].model.contact = self.textField.text ;
        dispatch_async(dispatch_get_main_queue(), ^{
            
           [[ZKModal sharedInstance] hideAnimated:YES];
        });

    } failure:^(NSError *error) {
        
        [SVProgressHUD showSuccessWithStatus:@"修改失败"];

    }];
    
    NSLog(@"确定") ;
}

@end

//
//  ChangeNameVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "ChangeNameVC.h"

@interface ChangeNameVC ()

@property(strong,nonatomic) UITextField * nameTextfiled ;

@end

@implementation ChangeNameVC{
    NSInteger _VCtype;
}

-(instancetype)initWith:(NSInteger)type {
    if (self = [super init]) {
        
        _VCtype = type; // 1.昵称  2.生日  3.性别  4.地区  5.名片
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = MainGray ;
    if (_VCtype == 1) {
        
        self.title = @"设置昵称" ;
    }else if (_VCtype == 2) {
        
        self.title = @"设置生日" ;
    }else if (_VCtype == 3) {
        
        self.title = @"设置性别" ;
    }else if (_VCtype == 4) {
        
        self.title = @"设置地区" ;
    }else if (_VCtype == 5) {
        
        self.title = @"设置名片" ;
    }else if (_VCtype == 6) {
        
        self.title = @"设置联系方式" ;
    }
    
}

-(void)initSubviews{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickRightBtn) string:@"保存" font:15 stringColor:[UIColor blueColor] ];
    
    UITextField * textfield = [[ UITextField alloc] initWithFrame:CGRectMake(lrPad, kNavigationBarHeight + 10, WIDTH - 2*lrPad, 50)];
//    textfield.placeholder = @"请输入姓名";
    if (_VCtype == 1) {
        
        textfield.placeholder = @"请设置昵称" ;
    }else if (_VCtype == 2) {
        
        textfield.placeholder = @"请设置生日" ;
    }else if (_VCtype == 3) {
        
        textfield.placeholder = @"请设置性别" ;
    }else if (_VCtype == 4) {
        
        textfield.placeholder = @"请设置地区" ;
    }else if (_VCtype == 5) {
        
        textfield.placeholder = @"请设置名片" ;
    }else if (_VCtype == 6) {
        
        textfield.placeholder = @"请设置联系方式" ;
        textfield.keyboardType = UIKeyboardTypeEmailAddress ;
    }
    textfield.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textfield];
    self.nameTextfiled = textfield;
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(lrPad, textfield.bottom, WIDTH - 2*lrPad, 1) color:oneBlaceFont];
}


/*
 * 点击 - 右侧按钮
 */
-(void)clickRightBtn{
    
    NSDictionary * para ;
    if (_VCtype == 1) {
        
        para = @{
            @"user_nicename":self.nameTextfiled.text,};
        
    
        NSLog(@"paraString = %@", [para yy_modelToJSONString]) ;
        
    }else if (_VCtype == 2) {
       para = @{
                @"birthday":self.nameTextfiled.text,
                     };
              
              NSLog(@"paraString = %@", [para yy_modelToJSONString]) ;
        
    }else if (_VCtype == 3) {
        para = @{
                  @"user_nicename":@"",
                  @"sex":@"",
                  @"signature":@"",
                  @"birthday":@"",
                  @"location":@""
              };
              
          
              NSLog(@"paraString = %@", [para yy_modelToJSONString]) ;
        
    }else if (_VCtype == 4) {
        para = @{@"location":self.nameTextfiled.text
              };
              
              NSLog(@"paraString = %@", [para yy_modelToJSONString]) ;
        
    }else if (_VCtype == 5) {
        para = @{ @"signature":self.nameTextfiled.text};
              
          
              NSLog(@"paraString = %@", [para yy_modelToJSONString]) ;
    }else if (_VCtype == 6) {
        
        para = @{ @"contact":self.nameTextfiled.text };
              
          
              NSLog(@"paraString = %@", [para yy_modelToJSONString]) ;
    }
    
    NSDictionary * params = @{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
        @"fields":[para yy_modelToJSONString]
    };
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:UpdateFields] params:params withHUD:NO success:^(id json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * dict = dataArr.firstObject ;
        [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
        
        [self.navigationController popViewControllerAnimated:YES] ;

    } failure:^(NSError *error) {


    }];
    
    
    NSLog(@" 点击保存按钮 ") ;
}





@end

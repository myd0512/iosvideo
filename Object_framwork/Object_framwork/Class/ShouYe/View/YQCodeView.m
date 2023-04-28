//
//  YQCodeView.m
//  Object_framwork
//
//  Created by apple on 2020/4/21.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "YQCodeView.h"

@interface YQCodeView ()

@property(strong , nonatomic) UIView * bottomView ;


@end

@implementation YQCodeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self getCodeView] ;
    }
    return self;
}


-(void)getCodeView{
    
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    self.bottomView = [QuickCreatUI creatUIViewWithSuperView:self andFrame:CGRectMake(0, 0, WIDTH, 200) color:kWhiteColor] ;
    self.bottomView.bottom = HEIGHT ;
    
    UILabel * codeLabel = [ QuickCreatUI creatUILabelWithSuperView:self.bottomView andFrame:CGRectMake(0, 0, WIDTH, 60) andText:@"邀请码:77588" andStringColor:kBlueColor andFont:15];
    codeLabel.textAlignment = NSTextAlignmentCenter ;
    
    
    UIView * lineView = [ QuickCreatUI creatUIViewWithSuperView:self.bottomView andFrame:CGRectMake(0, 60, WIDTH, 1.5) color:lineGray] ;
    
    NSArray * titleArray = @[@"复制链接",@"推广海报",@"复制邀请码",@"删除邀请码"];
    NSArray * imgArr = @[@"copy_link_icon",@"generalize_icon",@"copy_code_icon",@"delete_code_icon"];
    double itemw = WIDTH / 4 ;
    double itemh = 100 ;
    for (int i = 0; i< titleArray.count; i++) {
        
        UIView * backView = [QuickCreatUI creatUIViewWithSuperView:self.bottomView andFrame:CGRectMake(i * itemw,lineView.bottom + 10, itemw, itemh) color:kWhiteColor];
        
        UIImageView * imgView = [QuickCreatUI creatUIImageViewWithSuperView:backView  andFrame:CGRectMake(0, 0, 50, 50) andImg:imgArr[i]];
        imgView.centerX = itemw / 2 ;
        imgView.centerY = itemh*0.7 / 2 ;
//        imgView.backgroundColor = kRedColor ;
        
        UILabel * title = [QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(0, itemh*0.7 , itemw, itemh*0.3) andText:titleArray[i] andStringColor:oneBlaceFont andFont:14];
        title.textAlignment = NSTextAlignmentCenter;
        
    }
    
}


+(void)show{
    YQCodeView * view = [[self alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [[QuickCreatUI sharedInstance].topViewController.navigationController.view addSubview:view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
}


@end

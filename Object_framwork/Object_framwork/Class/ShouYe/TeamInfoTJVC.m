//
//  TeamInfoTJVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "TeamInfoTJVC.h"

@interface TeamInfoTJVC ()

@property(strong , nonatomic) NSMutableArray * mutArray ; // 会员字符串

@end

@implementation TeamInfoTJVC{
    double top ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"团队统计" ;
    self.view.backgroundColor = kWhiteColor ;
    
       UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
     [leftBtn setImage:[UIImage imageNamed:@"black_back"] forState:UIControlStateNormal];
     [leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton * rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"说明" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"right_icon"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:oneBlaceFont forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

/*
 * 点击 返回按钮
 */
-(void)clickBack{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"点击 返回") ;
}

/*
 * 点击 - 说明
 */
-(void)clickRightBtn{
    
    
}

-(void)initSubviews{

    top = kNavigationBarHeight ;
    self.mutArray = @[].mutableCopy ;
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 1) color:lineGray];
    top += 1 ;
    [self layoutTopView];
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    [self layoutTwoView];
  
}


/*
 * 布局 第一部分view
 */
-(void)layoutTopView{
    
    UIView * topView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 80) color:kWhiteColor] ;
    
    double itemW = WIDTH / 3 ;double itemH = topView.height ;
    NSArray * titleArr = @[@"团队人数" ,@"投注金额" ,@"返点金额" ] ;

    for (int i = 0 ; i< titleArr.count ; i++) {
     
      UIView * backView = [ QuickCreatUI creatUIViewWithSuperView:topView andFrame:CGRectMake(i * itemW , 0, itemW, itemH) color:kWhiteColor];
      
      UILabel * titleLabel = [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(0, 0, itemW, 20) andText:titleArr[i] andStringColor:twoBlaceFont andFont:13] ;
      titleLabel.textAlignment = NSTextAlignmentCenter ;
      titleLabel.top = backView.height / 2 + 2  ;
      
      UILabel * moneyLabel = [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(0, 0, itemW, 20) andText:titleArr[i] andStringColor:kRedColor andFont:15] ;
      moneyLabel.textAlignment = NSTextAlignmentCenter ;
      moneyLabel.bottom = backView.height / 2  - 2 ;
    }
    
    UIView * lineView1 = [ QuickCreatUI creatUIViewWithSuperView:topView andFrame:CGRectMake(0, 0, 1, 40) color:lineGray];
    lineView1.centerY = topView.height / 2 ;
    lineView1.x  = itemW ;
    
    UIView * lineView2 = [ QuickCreatUI creatUIViewWithSuperView:topView andFrame:CGRectMake(0, 0, 1, 40) color:lineGray];
       lineView2.centerY = topView.height / 2 ;
       lineView2.x  =  2*itemW ;
    
    top += 80 ;
}

/*
 * 布局第二部分view
 */
-(void)layoutTwoView{
    
    UIView * topview = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 50) color:kWhiteColor];
    top += 50;
    
    UILabel * starTimeLabel = [ QuickCreatUI creatUILabelWithSuperView:topview andFrame:CGRectMake(lrPad, 0, 80, topview.height) andText:@"2020-14-11" andStringColor:twoBlaceFont andFont:14] ;
    [starTimeLabel sizeToFit];
    starTimeLabel.width += 10 ;
    starTimeLabel.height = topview.height ;
    starTimeLabel.textAlignment = NSTextAlignmentCenter ;
    
    UIImageView * imageDown = [QuickCreatUI creatUIImageViewWithSuperView:topview andFrame:CGRectMake(0, 0, 16, 10) andImg:@"srxq_xb_ico"] ;
    imageDown.left = starTimeLabel.right + 5 ;
    imageDown.centerY = topview.height /2 ;
    
    UILabel * titlelabel = [QuickCreatUI creatUILabelWithSuperView:topview andFrame:CGRectMake(imageDown.right, 0, 30, topview.height) andText:@"至" andStringColor:twoBlaceFont andFont:15];
    titlelabel.textAlignment = NSTextAlignmentCenter ;
    
    UILabel * endTimeLabel = [ QuickCreatUI creatUILabelWithSuperView:topview andFrame:CGRectMake(titlelabel.right, 0, 80, topview.height) andText:@"2020-14-11" andStringColor:twoBlaceFont andFont:14] ;
     [endTimeLabel sizeToFit];
     endTimeLabel.width += 10 ;
     endTimeLabel.height = topview.height ;
     endTimeLabel.textAlignment = NSTextAlignmentCenter ;
     
     UIImageView * imageDown2 = [QuickCreatUI creatUIImageViewWithSuperView:topview andFrame:CGRectMake(0, 0, 16, 10) andImg:@"srxq_xb_ico"] ;
     imageDown2.left = endTimeLabel.right + 5 ;
     imageDown2.centerY = topview.height/  2 ;
    
    
    UIButton * chaxun = [QuickCreatUI creatUIButtonWithSuperView:topview andFrame:CGRectMake(0, 0, 60, 24) andText:@"查询" andStringColor:kGrayColor andFont:14 andTarget:self SEL:@selector(clickLookBtn)];
    [chaxun viewCornersWith:12 ] ;
    chaxun.layer.borderColor = kGrayColor.CGColor ;
    chaxun.layer.borderWidth = 1.0 ;
    chaxun.right = WIDTH - lrPad ;
    chaxun.centerY = topview.height / 2 ;
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 1) color:lineGray];
    top += 1;
    
   NSArray * titleArr = @[ @"注册人数",@"投注人数",@"投注金额",@"中奖金额",@"充值金额",@"提现金额",@"下级返点金额",@"团队返点金额"] ;
    for (int i = 0; i< titleArr.count ; i++) {
        [self getViewWith:titleArr[i] andSubString:@"0"];
    }
    
}


/*
 * 点击 - 查询按钮
 */
-(void)clickLookBtn{
    
    NSLog(@"点击 - 查询按钮") ;
}


-(void)getViewWith:(NSString *)title andSubString:(NSString*)subString {
    
    UIView * backView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 44) color:[UIColor whiteColor]] ;
  
    [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:title andStringColor:oneBlaceFont andFont:14];
    
    UILabel * tralingLabel = [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:subString andStringColor:twoBlaceFont andFont:14];
    tralingLabel.textAlignment = NSTextAlignmentRight;
   
    UIView * lineView = [QuickCreatUI creatUIViewWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 1) color:MainGray];
    lineView.bottom = backView.height ;
    
    [self.mutArray addObject:tralingLabel] ;
    
    top += 44 ;
}



@end

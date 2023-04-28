//
//  SubordinateVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "SubordinateVC.h"
#import "MemberCell.h"

@interface SubordinateVC ()

@property(assign , nonatomic) NSInteger  type ;

@end

@implementation SubordinateVC{
    double top ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"下级报表" ;
    self.view.backgroundColor = MainGray ;
    
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
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 1) color:lineGray];
    top += 1 ;
    [self layoutTopView];
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    
    
    UIView * topview = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 50) color:kWhiteColor];
    top += topview.height ;
    UIButton * serchBtn = [QuickCreatUI creatUIButtonWithSuperView:topview andFrame:CGRectMake(0, 0, 60, 25) andText:@"搜索" andStringColor:kWhiteColor andFont:14 andTarget:self SEL:@selector(clickSearchBtn:)];
    [serchBtn setBackgroundColor:kRedColor];
    [serchBtn viewCornersWith:12.5];
    serchBtn.right = WIDTH - lrPad ;
    serchBtn.centerY = topview.height / 2 ;
    
    UIView * searchView = [ QuickCreatUI creatUIViewWithSuperView:topview andFrame:CGRectMake(lrPad, 0, WIDTH - lrPad - 10 - serchBtn.width -  lrPad, 30) color:RGB(239, 239, 239)];
    searchView.centerY = topview.height / 2 ;
    [searchView viewCornersWith:15];
    
    UIImageView * searchIMg = [QuickCreatUI creatUIImageViewWithSuperView:searchView andFrame:CGRectMake(15, 0, 13, 15) andImg:@"sousuo"];
    searchIMg.centerY = 15 ;
    
    UITextField * textfield = [[ UITextField alloc] initWithFrame:CGRectMake(searchIMg.right + 10, 0 , searchView.width - searchIMg.right - 10 - 15, 30)];
    textfield.placeholder = @"请输入账号或昵称查询";
    textfield.font = [UIFont systemFontOfSize:14];
    [searchView addSubview:textfield];
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, topview.bottom , WIDTH, 1.5) color:lineGray];
    top += 1.5 ;
    
    
    UIView * timeView = [QuickCreatUI creatUIViewWithSuperView:self.view  andFrame:CGRectMake(0, top, WIDTH, 60) color:kWhiteColor];
    top += timeView.height ;
    UILabel * nameLabel = [QuickCreatUI creatUILabelWithSuperView:timeView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 20) andText:@"2020-04" andStringColor:oneBlaceFont andFont:15];
    
    UILabel * money = [QuickCreatUI creatUILabelWithSuperView:timeView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 20) andText:@"返点收入:0.057" andStringColor:threeBlaceFont  andFont:13];
    
    UIButton * btn = [QuickCreatUI creatUIButton_Image_WithSuperView:timeView andFrame:CGRectMake(0, 0, 35, 35) image:@"srxq_rl_ico" andTarget:self SEL:@selector(clickDataBtn:)];
    
    [QuickCreatUI creatUIViewWithSuperView:timeView andFrame:CGRectMake(0, timeView.height - 1.5, WIDTH, 1.5) color:lineGray];
    
    UIView * lineView = [QuickCreatUI creatUIViewWithSuperView:timeView andFrame:CGRectMake(0, 0, 1, timeView.height / 2 ) color:lineGray];
    
    nameLabel.bottom = timeView.height / 2 + 1.5 ;
    money.top = timeView.height / 2 - 1.5  +3 ;
    btn.right = WIDTH - lrPad ;
    btn.centerY = timeView.height / 2 + 1.5 ;
    lineView.centerY = timeView.height / 2  + 1.5;
    lineView.right = btn.left - 10 ;
    
    self.cell_height = 60 ;
    [self.tableView registerClass:[MemberCell class] forCellReuseIdentifier:@"MemberCell" ];
    self.dataArr = @[ @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy ;
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
 * 点击 搜索按钮
 */
-(void)clickSearchBtn:(UIButton *)sender{
    
    
}

-(void)layoutTableView{
    self.tableView.frame = CGRectMake(0, top, WIDTH, HEIGHT - top - kTabBarHeight ) ;
}

#pragma mark 代理事件
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionTitleArray.count ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count  ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cell_height ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"MemberCell"];
    
    
    
    return cell ;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.01) ] ;
    return view ;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * view = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.01) ] ;
    return view ;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeTranslation(WIDTH, 1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeTranslation(1, 1, 1);
    }];
}

-(void)clickDataBtn:(UIButton *)sender{
    
    
}

@end

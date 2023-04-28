//
//  YQCodeVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "YQCodeVC.h"
#import "MemberCell.h"
#import "YQCodeView.h"



@interface YQCodeVC ()

@property(assign , nonatomic) NSInteger  type ;

@end

@implementation YQCodeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"邀请码" ;
    self.view.backgroundColor = MainGray ;
    
       UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
     [leftBtn setImage:[UIImage imageNamed:@"black_back"] forState:UIControlStateNormal];
     [leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    
    
    UIButton * rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"新增邀请码" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"add_code_icon"] forState:UIControlStateNormal];
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
 * 点击 添加邀请码
 */
-(void)clickRightBtn{
    
    NSLog(@"新增邀请码") ;
}

-(void)initSubviews{
   
    
    self.cell_height = 60 ;
    [self.tableView registerClass:[MemberCell class] forCellReuseIdentifier:@"MemberCell" ];
    self.dataArr = @[ @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy ;
}


/*
 * 点击 搜索按钮
 */
-(void)clickSearchBtn:(UIButton *)sender{
    
    
}

-(void)layoutTableView{
    self.tableView.frame = CGRectMake(0, kNavigationBarHeight , WIDTH, HEIGHT - kNavigationBarHeight - kTabBarHeight ) ;
}

#pragma mark 代理事件
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1  ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cell_height ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"MemberCell"];
    
    
    
    return cell ;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 5.0) ] ;
    view.backgroundColor = lineGray ;
    return view ;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5.0;
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
    
    [YQCodeView show];
    
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

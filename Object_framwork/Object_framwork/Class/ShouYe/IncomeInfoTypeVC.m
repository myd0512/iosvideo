//
//  IncomeInfoTypeVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "IncomeInfoTypeVC.h"
#import "InfoCell.h"
@interface IncomeInfoTypeVC ()

@property(assign , nonatomic) NSInteger  type ;

@end

@implementation IncomeInfoTypeVC

-(instancetype)initWithType:(NSInteger )type {
    
    if (self = [super init]) {
        
        self.type = type ;
        
    }
    return  self ;
}

- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    
}
-(void)initSubviews{
    
    self.cell_height = 60 ;
    [self.tableView registerClass:[InfoCell class] forCellReuseIdentifier:@"InfoCell" ];
    self.dataArr = @[ @"",@"",@"",@"",@"",@"",@""].mutableCopy ;
}

-(void)layoutTableView{
    self.tableView.frame = CGRectMake(0, 0, WIDTH, self.view.height) ;
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
    
    InfoCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    
    
    return cell ;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 80) ] ;
    view.backgroundColor = kWhiteColor ;
    
    [ QuickCreatUI creatUIViewWithSuperView:view andFrame:CGRectMake(0, 0, WIDTH, 10) color:lineGray ] ;
    
    UILabel * nameLabel = [QuickCreatUI creatUILabelWithSuperView:view andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 20) andText:@"名字名字" andStringColor:oneBlaceFont andFont:15];
    
    UILabel * money = [QuickCreatUI creatUILabelWithSuperView:view andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 20) andText:@"支出:¥0.00   收入:¥15.00" andStringColor:twoBlaceFont  andFont:13];
    
    UIButton * btn = [QuickCreatUI creatUIButton_Image_WithSuperView:view andFrame:CGRectMake(0, 0, 35, 35) image:@"srxq_rl_ico" andTarget:self SEL:@selector(clickDataBtn:)];
    
    [QuickCreatUI creatUIViewWithSuperView:view andFrame:CGRectMake(0, view.height - 5, WIDTH, 5) color:lineGray];
    
    UIView * lineView = [QuickCreatUI creatUIViewWithSuperView:view andFrame:CGRectMake(0, 0, 1, view.height / 2 ) color:lineGray];
    
    nameLabel.bottom = view.height / 2+5 ;
    money.top = view.height / 2 + 5  +3 ;
    btn.right = WIDTH - lrPad ;
    btn.centerY = view.height / 2 + 5 ;
    lineView.centerY = view.height / 2  + 5;
    lineView.right = btn.left - 10 ;
        
    return view ;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 80;
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



-(void)clickDataBtn:(UIButton *)sender{
    
    
}

@end

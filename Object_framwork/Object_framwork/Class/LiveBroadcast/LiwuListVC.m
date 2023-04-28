//
//  LiwuListVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/25.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "LiwuListVC.h"
#import "LiWuListViewModel.h"
#import "LiwuListViewCell.h"




@interface LiwuListVC ()
@property(strong , nonatomic) UIView * topView ;
@end

@implementation LiwuListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initSubviews{
    
    self.view.backgroundColor = kBlackColor ;
    
    self.topView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, 0, WIDTH, 35) color:RGB(27, 27, 36)];
    [self.topView viewCornersWith:17.5];
       NSArray *titleArr = @[ @"时间",@"昵称",@"礼物",@"数量",@"价值"] ;
       
       double x = 0 ;
       
       for ( int i = 0 ; i < titleArr.count ; i++ ) {
           
           double w = 0 ;
           if (i == 0||i == 1) {
               
               w  = 0.25 * WIDTH ;
           }else{
               
               w  = WIDTH * 1/6 ;
           }
           
           UILabel * label = [ QuickCreatUI creatUILabelWithSuperView:self.topView andFrame:CGRectMake( x , 0, w, 35) andText:titleArr[i] andStringColor:RGB(240, 240, 240) andFont:14];
           label.textAlignment = NSTextAlignmentCenter ;
           
           x += w;
       }
    
    self.dataArr = @[].mutableCopy ;
    self.cell_height = 35 ;
    [self.tableView registerClass:[LiwuListViewCell class] forCellReuseIdentifier:@"LiwuListViewCell"];
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView reloadData];
    [self getListData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
       selector:@selector(upLoad)
           name:@"gift"
         object:nil];
}

-(void)upLoad{
    self.dataArr = @[].mutableCopy ;
    self.send_index = self.current_index = 1 ;
    [self getListData];
}

-(void)getListData{
    
    self.url = GetHostGiftLog;
    self.params = @{
        @"liveuid":[UserInfoManaget sharedInstance].model.id
    };
    self.isShowNoDataImg = YES;
    
    [self getNORefreshDataWithSuccess:^(id  _Nonnull json) {
        
        NSLog(@"liveuid json = %@",json);
        NSArray * dataArr = json[@"info"];
        [self.dataArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[LiWuListViewModel class ] json:dataArr]];
        [self.tableView reloadData];
        
        if( self.dataArr.count ) {

            [QuickCreatUI dissmissNoContentView:self.tableView tag:1]; //

        }else {

            [QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
        }
        
    } andFaile:^(id  _Nonnull json) {
        
        NSLog(@"json = %@", [json description]) ;
    }];
 
}

-(void)ClickRefrishBtn:(UIButton *)sender{}

-(void)layoutTableView{
    
    self.tableView.frame = CGRectMake( 0 , 35, WIDTH, self.view.height - 35) ;
}


/*
 * 代理 - 方法
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"self.dataArr.count %lu",(unsigned long)self.dataArr.count );
    return self.dataArr.count  ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cell_height ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiWuListViewModel * model = self.dataArr[indexPath.row] ;
    LiwuListViewCell * cell =  [ tableView dequeueReusableCellWithIdentifier:@"LiwuListViewCell" ];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 5.0) ] ;
    view.backgroundColor = kBlackColor ;
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
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

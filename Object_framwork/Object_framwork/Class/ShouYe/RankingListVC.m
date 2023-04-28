//
//  RankingListVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/21.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "RankingListVC.h"
#import "RankingListCell.h"
#import "RankingListModel.h"





@interface RankingListVC ()<UITableViewDelegate , UITableViewDataSource>

@property(strong , nonatomic) UILabel * oneNameLabel ;
@property(strong , nonatomic) UILabel * oneLiWuLabel ;
@property(strong , nonatomic) UILabel * oneGuanZhuLabel ;
@property(strong , nonatomic) UIImageView * oneIconImg ;
@property(strong , nonatomic) UITableView * tableView ;
@property(strong , nonatomic) NSMutableArray * dataArr ; // 可变 数据源

@end

@implementation RankingListVC{
    double top ;
    NSString* type ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"排行榜" ;
    self.view.backgroundColor = MainGray ;
}


-(void)initSubviews{
   
    top = kNavigationBarHeight + 15 ;
    type = @"day" ;
    self.dataArr = @[].mutableCopy ;
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"ac_bg_rank"].CGImage;
    self.view.contentMode = UIViewContentModeScaleToFill ;
    
    [self topView];
}


-(void)topView{
    
    UISegmentedControl *segC = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, top , 200  , 30)];
    top += segC.height ;
    segC.centerX = WIDTH /2  ;
    //添加小按钮
    [segC insertSegmentWithTitle:@"日榜" atIndex:0 animated:YES];
    [segC insertSegmentWithTitle:@"周榜" atIndex:1 animated:YES];
    [segC insertSegmentWithTitle:@"月榜" atIndex:2 animated:YES];
    
    segC.selectedSegmentIndex = 0;
//    [segC viewCornersWith:15] ;
    
    //设置样式
    [segC setTintColor:kWhiteColor];
    [segC setBackgroundColor:RGB(250, 133, 133)];    //self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    if (@available(iOS 13.0, *)) {
        [segC setSelectedSegmentTintColor:kWhiteColor];
    } else {
        // Fallback on earlier versions
    }
    // self.segmentedControl.tintColor = [UIColor whiteColor];

    //设置字体样式
    [segC setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kWhiteColor} forState:UIControlStateNormal];
    [segC setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(250, 133, 133)} forState:UIControlStateSelected];
    
//    [segC setBackgroundColor:kWhiteColor];
    //添加事件
    [segC addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segC];
    
    
    UIImageView * backImage = [ QuickCreatUI creatUIImageViewWithSuperView:self.view andFrame:CGRectMake(0, top + 10 , 100, 285/234 * 100 ) andImg:@"pic_crown"];
    backImage.contentMode = UIViewContentModeScaleAspectFit;
    backImage.centerX = WIDTH / 2 ;
    
    UIImageView * iconImg = [ QuickCreatUI creatUIImageViewWithSuperView:self.view andFrame:CGRectMake(0, 0, 72, 72) andImg:@"default_head"];
    iconImg.centerX = WIDTH / 2 + 1.5 ;
    iconImg.bottom = backImage.bottom - 3.5 ;
    [iconImg viewCornersWith:36];
    self.oneIconImg = iconImg ;
    
    UILabel * numLabel= [ QuickCreatUI creatUILabelWithSuperView:self.view andFrame:CGRectMake(0, 0, 50, 14) andText:@"0" andStringColor:kWhiteColor andFont:10] ;
    [numLabel setBackgroundColor:twoBlaceFont];
    [numLabel viewCornersWith:numLabel.height / 2];
    self.oneGuanZhuLabel = numLabel ;
    
    
    [numLabel sizeToFit];
    numLabel.height = 14 ;
    numLabel.width += 15 ;
    numLabel.centerY = iconImg.bottom ;
    numLabel.centerX = WIDTH / 2 ;numLabel.textAlignment = NSTextAlignmentCenter ;
    
    
    UILabel * nameLabel = [QuickCreatUI creatUILabelWithSuperView:self.view andFrame:CGRectMake(0, numLabel.bottom + 10, WIDTH, 20) andText:@"虚位以待" andStringColor:kWhiteColor andFont:15];
    nameLabel.textAlignment = NSTextAlignmentCenter ;
    nameLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    self.oneNameLabel = nameLabel ;
    
    
    UILabel * num = [QuickCreatUI creatUILabelWithSuperView:self.view andFrame:CGRectMake(0, nameLabel.bottom , WIDTH, 20) andText:@"礼物:0.00" andStringColor:kWhiteColor andFont:12];
    num.textAlignment = NSTextAlignmentCenter ;
    self.oneLiWuLabel = num ;
    top = num.bottom + 5 ;
    
    UIView * listView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(lrPad, top, WIDTH - 2*lrPad, 450) color:kWhiteColor ];
    [listView viewCornersWith:8.0];
    
    self.tableView.frame = CGRectMake(0, 0, listView.width, listView.height) ;
    [self.tableView registerClass:[RankingListCell class] forCellReuseIdentifier:@"RankingListCell"];
    [listView addSubview:self.tableView];
    
    WeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        weakSelf.send_index = weakSelf.current_index = 1 ;
        [weakSelf getListData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        weakSelf.send_index = weakSelf.current_index + 1 ;
        [weakSelf getListData];
    }];
    
    [self getListData] ;
}

/*
 * 获取 数据
 */
-(void)getListData{
    
    self.url = ProfitList ;
    self.params = @{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"p":@(self.send_index) ,
        @"type":type
    };
    
    NSLog(@"params = %@" , self.params ) ;
    
    self.isShowNoDataImg = NO ;
    
    [self getRefreshDataWithSuccess:^(id json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
        
        if (dataArr.count != 0) {
            
            [self.dataArr addObjectsFromArray:[ NSArray yy_modelArrayWithClass:[RankingListModel class] json:dataArr]];
                    
            if (self.send_index == 1) {
                RankingListModel * model = self.dataArr.firstObject ;
                self.oneNameLabel.text = model.user_nicename ;
                self.oneLiWuLabel.text = [NSString stringWithFormat:@"礼物:%@", model.totalcoin];
                self.oneGuanZhuLabel.text = model.level_anchor ;
                [self.oneIconImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] ] ;
                [self.dataArr removeObjectAtIndex:0];
            }
           
        }else{
            
             if (self.send_index == 1) {
                self.oneNameLabel.text = @"虚伪以待";
                self.oneLiWuLabel.text = [NSString stringWithFormat:@"礼物:%@", @"0.00"];
                self.oneGuanZhuLabel.text = @"0" ;
                self.oneIconImg.image = [UIImage imageNamed:@"default_head"] ;
             }
        }
        
    } andFaile:^(id json) {
        
        
    }];
}


#pragma mark 网络请求-下拉刷新
-(void)getRefreshDataWithSuccess:(void (^)(id json))success andFaile:(void (^)(id json))faile{
    /**
     获取订单信息
     */
    [[ZKHttpTool shareInstance] get: [ZKSeriverBaseURL getUrlType:self.url] params:self.params withHUD:NO success:^(id json) {
        
        NSLog(@" json = %@" , json ) ;
        
        if ( self.send_index == 1 ) { // 下拉刷新
            
            [self.dataArr removeAllObjects];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
        }else{ // 上拉加载
            
            self.current_index++ ;
            [self.tableView.mj_footer endRefreshing] ;
        }
        
        success( json ) ;
        
        if (self.isShowNoDataImg) {
            
            if( self.dataArr.count) {
                
                [QuickCreatUI dissmissNoContentView:self.tableView tag:1]; //
                
            }else {
                
                [QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""];
            }
            
        }
        
        [self.tableView reloadData] ;
        
    } failure:^(NSError *error) {
        
        if (self.isShowNoDataImg) {
            
            if( self.dataArr.count == 0) {
                
                [QuickCreatUI createNoContentImageView:self.tableView target:self andSel:@selector(ClickRefrishBtn:) tag:1 Tishinsstring:@"没有数据" ClickBtnString:@""] ;
            }
        }
        
        [self.tableView.mj_header endRefreshing] ;
        [self.tableView.mj_footer endRefreshing] ;
        
        faile(error) ;
    }];
    NSLog(@"供子类重写") ;
}

-(void)ClickRefrishBtn:(id)sender{}

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [ [ UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped ] ;
        
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        
        /**
         去掉 分割线   去掉滑动块
         */
        _tableView.showsVerticalScrollIndicator = NO ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone  ;
        
        /**
         去掉 - 预估高度
         */
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.backgroundColor = MainGray ;
        
    }
    return _tableView ;
}


-(void)segCChanged:(UISegmentedControl *)seg{
    
    NSInteger i = seg.selectedSegmentIndex;
  
    if (i == 0) {
        type = @"day" ;
    }else if (i ==1){
        type = @"week" ;
    }else if (i ==2){
        type = @"month" ;
    }
    
    NSLog(@"i  = %ld" , (long)i) ;
    self.send_index = self.current_index = 1 ;
    [self getListData];

}


#pragma mark 代理事件
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"self.dataArr = %lu , ", (unsigned long)self.dataArr.count ) ;
    return self.dataArr.count<=10 ? 9 : self.dataArr.count  ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RankingListCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"RankingListCell"];
    
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 2];
    
    if (indexPath.row < self.dataArr.count ) {

        cell.model = self.dataArr[indexPath.row] ;
    }else{
        
        [cell clearDara];
    }
    
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



@end

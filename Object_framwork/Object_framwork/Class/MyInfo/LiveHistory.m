//
//  LiveHistory.m
//  Object_framwork
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "LiveHistory.h"
#import "LiveHistoryCell.h"
#import "LiveHistoryModel.h"


@interface LiveHistory ()

@end

@implementation LiveHistory

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"开播历史";
    self.view.backgroundColor = MainGray ;
}

-(void)initSubviews{

    self.dataArr = @[].mutableCopy ;
    self.cell_height = 50 ;
    [self.tableView registerClass:[LiveHistoryCell class] forCellReuseIdentifier:@"LiveHistoryCell"];
    [self.tableView reloadData];
    
    UIView * topView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake( 0 , kNavigationBarHeight , WIDTH , 35 ) color:RGB(240, 240, 240)] ;
    
    [QuickCreatUI creatUILabelWithSuperView:topView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 35) andText:@"开播历史,只展示近30天的数据" andStringColor:twoBlaceFont andFont:12];
    
    
    [self addHeadRefreshMethod];
    [self addFootRefreshMethod];
    [self getListData];
}


-(void)getListData{
    
    self.url = GetLiverecord;
    self.params = @{
        @"touid":[UserInfoManaget sharedInstance].model.id,
        @"p": @(self.send_index),
    };
    self.isShowNoDataImg = YES;
    [self getRefreshDataWithSuccess:^(id  _Nonnull json) {
        
        NSLog(@"json = %@",json);
        NSArray * dataArr = json[@"data"][@"info"];
        [self.dataArr addObjectsFromArray:[NSArray  yy_modelArrayWithClass:[LiveHistoryModel class] json:dataArr ]];
        [self.tableView reloadData];
        
    } andFaile:^(id  _Nonnull json) {
        
        NSLog(@"json = %@", [json description]) ;
    }];
}


-(void)layoutTableView{
    self.tableView.frame = CGRectMake(0, kNavigationBarHeight + 35, WIDTH, HEIGHT - kNavigationBarHeight - 35);
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
    
    LiveHistoryModel * model = self.dataArr[indexPath.row] ;
    LiveHistoryCell * cell =  [ tableView dequeueReusableCellWithIdentifier:@"LiveHistoryCell" ];
    cell.dataTimeLabel.text = model.datestarttime ;
    cell.longTimeLabel.text = model.length ;
    return cell ;
}


@end

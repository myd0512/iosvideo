//
//  GameinfoListVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/25.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "GameinfoListVC.h"
#import "GameHorsirInfoCell.h"
#import <SocketRocket/SocketRocket.h>
@interface GameinfoListVC ()<SRWebSocketDelegate>
{
    // 游戏相关
    SRWebSocket *socket;
}
@property(strong , nonatomic) UIView * topView ;
@property(strong , nonatomic) UILabel * qihaolabel ;
@end

@implementation GameinfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initSubviews{
    self.view.backgroundColor = kBlackColor ;
    
    
    self.topView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(10, 0, WIDTH - 20, 35) color:RGB(27, 27, 36)];
    [self.topView viewCornersWith:17.5 ];
    
    NSArray *titleArr = @[ [UserInfoManaget sharedInstance].gameInfoModel.gameName ,[NSString stringWithFormat:@"第--期"], @"火热下注中~" ] ;
    
    double w = (WIDTH - 20) / 3.5 ;
   
    for ( int i = 0 ; i < titleArr.count ; i++ ) {
        
        UILabel * label = [ QuickCreatUI creatUILabelWithSuperView:self.topView andFrame:CGRectMake( w * i , 0, w, 35) andText:titleArr[i] andStringColor:RGB(240, 240, 240) andFont:13];
        label.textAlignment = NSTextAlignmentCenter ;
        if (i == 1) self.qihaolabel = label ;
        if (i == 2) {
            label.textColor = kRedColor ;
            label.width = 1.5*w ;
        }
    }
    
    self.dataArr = @[].mutableCopy ;
    self.cell_height = 35 ;
    [self.tableView registerNib:[UINib nibWithNibName:@"GameHorsirInfoCell" bundle:nil] forCellReuseIdentifier:@"GameHorsirInfoCell"];
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView reloadData];
    
    [self addHeadRefreshMethod];
    [self addFootRefreshMethod];
    [self getListData];
    

    NSArray * gameArr = @[ gameurl , fiveurl , careurl ,timeeurl ,sixurl ,happyurl , famerurl , ] ;
    //wxm 请求游戏数据
    socket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:gameArr[[UserInfoManaget sharedInstance].gameInfoModel.gameID - 1]]];
    socket.delegate = self;
    [socket open];
}


-(void)getListData{
    
    self.url = Get_game_log;
    self.params = @{
        @"name":@"game",
        @"game_id":@([UserInfoManaget sharedInstance].gameInfoModel.gameID),
        @"page":@(self.send_index)
    };
    self.isShowNoDataImg = YES;
    [self getRefreshDataWithSuccess:^(id  _Nonnull json) {
        NSLog(@"json = %@",json);
        NSArray * dataArr = json[@"data"][@"info"];
    
        for (NSDictionary *dic in dataArr) {
            [self.dataArr addObject:dic ];
        }
        
        [self.tableView reloadData];
    } andFaile:^(id  _Nonnull json) {
        NSLog(@"json = %@", [json description]) ;
    }];
}

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
    
    NSDictionary * model = self.dataArr[indexPath.row] ;
    GameHorsirInfoCell * cell =  [ tableView dequeueReusableCellWithIdentifier:@"GameHorsirInfoCell" ];
//    cell.nameLabel.text = [UserInfoManaget sharedInstance].gameInfoModel.gameName ;
//    cell.qiNumLabel.text = [NSString stringWithFormat:@"第%@期",model[@"id"]];
//    cell.resultLabel.text = model[@"result"] ;
    [cell setDictInfo:model] ;
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
    [socket close];
    socket = nil ;
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark ============ 游戏链接  =============
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{

}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{

    NSLog(@"==-===---=-scoket=-=-=-=-=-=-=>>>>%@",pongPayload);

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {

    NSLog(@"0-==--3=-2-=-=3-=1-=-=2-=-=3-=2socket====>>%@",error);

}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
   
    NSLog(@"接收消息---- ===== %@",message);
    NSDictionary *configFirstDic = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding]
       options:NSJSONReadingMutableContainers
         error:nil];
 
   NSArray *keys = [configFirstDic allKeys];
   NSString *newKey ;
    for (NSString * k in keys) {
        
        if ([k containsString:@"game_id"]&&[k containsString:@"new"]) {
                                               newKey = k ;
                                               continue;;
                                           }
    }
    
    self.qihaolabel.text = [NSString stringWithFormat:@"第%@期", configFirstDic[newKey]   ];
    self.send_index = self.current_index = 1 ;
    [self getListData];
}


@end

//
//  LiveingVC.h
//  Object_framwork
//
//  Created by apple on 2020/4/22.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.


#import "FWQMUICommonVC.h"
#import <GPUImage/GPUImage.h>
#import "AllRoomShowLuckyGift.h"

NS_ASSUME_NONNULL_BEGIN
@class LiveingModel;
@interface LiveingVC : UIViewController
{
    NSTimer *gameTime;//检测游戏开奖时间
    NSTimer *listTimer;//定时刷新用户列表
    NSTimer *backGroundTimer;//检测后台时间（超过60秒执行断流操作）
    int backTime;//返回后台时间60s
    UIView *liansongliwubottomview;//连送礼物底部view
    AllRoomShowLuckyGift *luckyGift;
    
   
    
}


-(instancetype)initWithUrlString:(LiveingModel *)dict ; //初始化 房间数据
@property (nonatomic,strong)NSDictionary *dictModel; //
@property(nonatomic,strong)UITableView *tableView; //公聊 列表显示
@property(nonatomic,strong)NSArray *chatModels;//模型数组
@property GPUImageFilter     * filter;

@end

NS_ASSUME_NONNULL_END

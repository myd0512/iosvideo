//
//  ZKSeriverBaseURL.h
//  butlerUsedCar
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 zhengkun. All rights reserved.



/**
 网络请求 , url - 综合处理
 */
#import <Foundation/Foundation.h>


static NSString * const Base_URL = @"http://域名/"  ;
//http://www.gagmdmaqs.cn/api/public/
static NSString * const Login = @"api/public/?service=login.userLogin";//登录
static NSString * const CreateRoom = @"api/public/?service=Live.createRoom";//开播
static NSString * const ChangeLive = @"api/public/?service=live.changeLive";//修改房间状态 开启或关闭
static NSString * const StopRoom = @"api/public/?service=Live.stopRoom";//关播
static NSString * const ChangeLiveType = @"api/public/?service=live.changeLiveType";//修改房间类型
static NSString * const StopInfo = @"api/public/?service=live.stopInfo";//直播结束信息
static NSString * const ConsumeList = @"api/public/?service=Home.consumeList";//收益排行榜
static NSString * const ProfitList = @"api/public/?service=Home.profitList";//消费排行榜
static NSString * const GetBaseInfo = @"api/public/?service=User.getBaseInfo";//获取用户信息
static NSString * const UpdateAvatar = @"api/public/?service=User.updateAvatar";//修改用户头像
static NSString * const UpdatePass = @"api/public/?service=User.updatePass";//修改用户密码
static NSString * const UpdateFields = @"api/public/?service=User.updateFields";//修改用户信息
static NSString * const GetLiverecord = @"api/public/?service=User.getLiverecord";//获取直播记录
static NSString * const User_wallet = @"api/public/?service=User.user_wallet";//我的钱包

static NSString * const User_today = @"api/public/?service=User.user_today";//本日直播时间和本日收入
static NSString * const Get_game_log = @"api/public/?service=Game.get_game_log";//获取开奖记录
static NSString * const GetHostGiftLog = @"api/public/?service=Live.getHostGiftLog";//获取主播礼物记录

static NSString * const SetCash = @"api/public/?service=User.setCash";//主播提现
static NSString * const SetUserAccount = @"api/public/?service=User.setUserAccount";//主播添加提现账号
static NSString * const GetUserAccountList = @"api/public/?service=User.getUserAccountList";//获取主播提现账号
static NSString * const GetProfit = @"api/public/?service=User.getProfit";//获取我的收益

static NSString * const DelUserAccount = @"api/public/?service=User.delUserAccount";//主播删除提现账号
static NSString * const GetLiveClass = @"api/public/?service=Live.getLiveClass";//获取直播分类信息
static NSString * const GetConfig = @"api/public//?service=Home.getConfig";//获取配置信息
static NSString * const Get_game_start = @"api/public//?service=Game.get_game_start";//获取可玩游戏信息

@interface ZKSeriverBaseURL : NSObject

+(NSString *)getUrlType:(NSString *)urlString ;

@end

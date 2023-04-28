//
//  LiveingVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/22.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.

#import "LiveingVC.h"
#import "LiveingModel.h"

// 公聊
#import "chatModel.h"
#import "chatMsgCell.h"
// socket链接
#import "socketLive.h"
#import "YBToolClass.h"
#import "MenuView.h" //礼物按钮点击菜单view

// 金山SDK  kit
#import <libksygpulive/KSYGPUStreamerKit.h>
// 电话事件中心
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import <SocketRocket/SocketRocket.h>


//美颜
#import "beautifulview.h"
//人物头像
#import "ListCollection.h"
//礼物
#import "expensiveGiftV.h"
#import "continueGift.h"
#import "viplogin.h"
#import "userLoginAnimation.h"
#import "LoginVC.h"
#import "ZhongJiangView.h" //处理中奖信息
#import "upmessageInfo.h" //用户弹框
#import "SetContantView.h" // 设置联系方式VIew




#define gap 10

@interface LiveingVC ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,socketLiveDelegate,SRWebSocketDelegate,listDelegate,haohuadelegate,upmessageKickAndShutUp>

@property(strong , nonatomic) KSYGPUStreamerKit * kit ; //金山推流 kit类
@property (nonatomic,strong)CTCallCenter     *callCenter; //电话事件中心类
@property(strong , nonatomic) LiveingModel * model ; //直播信息类
@property(strong , nonatomic) MenuView * someMenuView ;
@property(nonatomic,strong)NSMutableArray *prizeArray;//中奖 中奖名字
@property(nonatomic,strong)NSMutableArray *userNArray;//中奖 用户
@property(nonatomic,strong)NSMutableArray *moneyArray;//中奖 钱

/**
开播时长 倒计时
 */
@property (nonatomic, strong) dispatch_source_t timer;
/**
刷新 - 用户列表
 */
@property (nonatomic, strong) dispatch_source_t uppeopleInfo;

@end

@implementation LiveingVC{
    
    // 游戏相关
    SRWebSocket *socketGame;
    SRWebSocket *socketTouZhu;
    NSInteger _gameTime ; //开奖时间
    NSMutableArray * mutGame ; // 可变的游戏
    NSMutableArray * mutjjArr ; // 奖金数组
    NSInteger gameAnimationTime; // 中奖索引游戏
    
    upmessageInfo *userView;//用户列表弹窗
    NSString * tanChuangID ;
    //美颜
    beautifulview *beautifulgirl;//美颜
    ListCollection *listView;//用户列表
    //礼物
    expensiveGiftV *haohualiwuV;//豪华礼物
    continueGift *continueGifts;//连送礼物
    // 进场动画
    viplogin *vipanimation;//坐骑
    userLoginAnimation *useraimation;//用户进入动画
    UIView * zjView ; //中奖view
    ZhongJiangView * zjAnimationView ; //中奖动效view
    
    //静音按钮
    UIImageView *jingYinImg;//
    BOOL isJingYin;//
    
    //开始动画倒计时123
     UILabel *label1;
     UILabel *label2;
     UILabel *label3;
     UIView *backView; // 倒计时view
    UIView *frontView; // 子控件布局在这上面
    UIImageView * gaosiImg ; // 封面搞死模糊图
    
    // 界面布局元素
    UILabel * liveingTimeLabel ;//开播时间
    UIView * timeLabelbackView ; //开播时间背景图
    UIView * timeOpenIcon ; //开播小红点
    NSInteger _openTime ;
    UILabel * giveNumLabel ;//礼物数量
    UIView * messageView ;// 消息滑动view
    UIView * gameTypeView ;//游戏view
    UILabel * gameTimeLabel ;// 游戏倒计时
    UIView * bonus ;// 奖金view
    UILabel *bonusLabel; // 中奖金额
    UIView * RewardView;// 举报view
    UIView * lotteryView;// 彩票view
    UIView * bottomMenuView;// 底部菜单view
    UIImageView * closeBtn ; //关闭直播间
    UILabel * onlineLabel ; //直播间人数
    // socket 链接
    socketLive *socketL;//socket
    
    
    UITextField *keyField;//聊天&输入框
    UIButton *keyBTN;
    CGFloat www;
    UIButton *pushBTN ;// 发送消息按钮
    UIView *toolBar; //
    
    NSString *titleColor;
    
    NSMutableArray *msgList; //消息数组
    
    //点亮图片
    UIImageView *starImage;
    CGFloat starX;
    CGFloat  starY;
    
//    UserBulletWindow *buttleView;// 用户信息弹框
    long long userCount;//用户数量
    BOOL isclosenetwork; //是否有网络
    BOOL ismessgaeshow;//限制直有发送消息得时候键盘弹出
    BOOL _canScrollToBottom;
    AFNetworkReachabilityManager *managerAFH;//判断网络状态
}

/*
 * 初始化 -
 */
-(instancetype)initWithUrlString:(LiveingModel *)dict {
    if (self = [super init]) {
        self.model = dict ;
    }
    return self ;
}
- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}
-(BOOL)fd_interactivePopDisabled{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self chushihua];
    [self initSubviews];
    [IQKeyboardManager sharedManager].enable = NO;
    
}

-(void)chushihua{

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLiveing"];
//    self.isRedayCloseRoom = NO;
//    backTime = 0;
//    _canScrollToBottom = YES;
//    _voteNums = @"0";//主播一开始的收获数
//    userCount = 0;//用户人数计算
    haohualiwuV.expensiveGiftCount = [NSMutableArray array];//豪华礼物数组
//    titleColor = @"0";//用此字段来判别文字颜色
    msgList = [[NSMutableArray alloc] init];//聊天数组
    _chatModels = [NSArray array];//聊天模型
    ismessgaeshow = NO;
    _canScrollToBottom = YES;
    userCount = 0;//用户人数计算
    _openTime = 0 ;
    _gameTime = 0 ;
    isJingYin = NO;
//    isLianmai = NO;
//    //预览界面的信息
//    liveClassID = @"-99999999";
//    roomType = @"0";
//    roomTypeValue = @"";
//    selectShareName = @"";
//    thumbImage = nil;
//    isAnchorLink = NO;
//    isTorch = NO;
}
- (void)initSubviews{
//    [super initSubviews];
    
        //弹出相机权限
         [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
             if (!granted) {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"权限受阻" message:@"请在设置中开启相机权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
                 return;
             }
         }];
         //弹出麦克风权限
         [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
             if (!granted) {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"权限受阻" message:@"请在设置中开启麦克风权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
                 return ;
             }
         }];

         isclosenetwork = NO;

         [self nsnotifition];
    
         __block LiveingVC *weakself = self;
         managerAFH = [AFNetworkReachabilityManager sharedManager];
         [managerAFH setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
             switch (status) {
                 case AFNetworkReachabilityStatusUnknown:
                     NSLog(@"未识别的网络");
                     self->isclosenetwork = YES;
                     [weakself backGround];
                     break;
                 case AFNetworkReachabilityStatusNotReachable:
                     NSLog(@"不可达的网络(未连接)");
                     self->isclosenetwork = YES;
                     [weakself backGround];
                     break;
                 case  AFNetworkReachabilityStatusReachableViaWWAN:
                     self->isclosenetwork = NO;
                     [weakself forwardGround];
                     if (self.model) {
                         [weakself checkLiveingStatus];
                     }
                     break;
                 case AFNetworkReachabilityStatusReachableViaWiFi:
                     self->isclosenetwork = NO;
                     if (self.model) {
                         [weakself checkLiveingStatus];
                     }
                     [weakself forwardGround];
                     break;
                 default:
                     break;
             }
         }];
    
         [managerAFH startMonitoring];
     #pragma mark 回到后台+来电话
         self.callCenter = [CTCallCenter new];
         
         self.callCenter.callEventHandler = ^(CTCall *call) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if ([call.callState isEqualToString:CTCallStateDialing]) {
                     NSLog(@"电话主动拨打电话");
                     [weakself reciverPhoneCall];
                 } else if ([call.callState isEqualToString:CTCallStateConnected]) {
                     NSLog(@"电话接通");
                     [weakself reciverPhoneCall];
                 } else if ([call.callState isEqualToString:CTCallStateDisconnected]) {
                     NSLog(@"电话挂断");
                     [weakself phoneCallEnd];
                 } else if ([call.callState isEqualToString:CTCallStateIncoming]) {
                     NSLog(@"电话被叫");
                     [weakself reciverPhoneCall];
                 } else {
                     NSLog(@"电话其他状态");
                 }
             });
         };
    
    [self getStarCaiji];
    [self startUI];
    
}
#pragma 懒加载
-(MenuView *)someMenuView{
    if (!_someMenuView) {
        
        _someMenuView = [[ MenuView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, HEIGHT)] ;
        [self.view addSubview:_someMenuView];
        [self.view bringSubviewToFront:_someMenuView] ;
        
    }
    return _someMenuView;
}

/*
 * 直播状态 - 处理
 */
- (void) onStreamStateChange:(NSNotification *)notification {
    
      if ( _kit.streamerBase.streamState == KSYStreamStateIdle) {
          NSLog(@"推流状态:初始化时状态为空闲");
      }
      else if ( _kit.streamerBase.streamState == KSYStreamStateConnected){
          NSLog(@"推流状态:已连接");
//          [self changePlayState:1];//推流成功后改变直播状态
          if (_kit.streamerBase.streamErrorCode == KSYStreamErrorCode_KSYAUTHFAILED ) {
              //(obsolete)
              NSLog(@"推流错误:(obsolete)");
          }
      }
      else if (_kit.streamerBase.streamState == KSYStreamStateConnecting ) {
          NSLog(@"推流状态:连接中");
      }
      else if (_kit.streamerBase.streamState == KSYStreamStateDisconnecting ) {
          NSLog(@"推流状态:断开连接中");
          [self onStreamError];
      }
      else if (_kit.streamerBase.streamState == KSYStreamStateError ) {
          NSLog(@"推流状态:推流出错");
          
          NSLog(@"ErrorCode=--=%ld",_kit.streamerBase.streamErrorCode);
          if (_kit.streamerBase.streamErrorCode == KSYStreamErrorCode_Connect_Server_failed ) {
              NSLog(@"跟RTMP服务器完成握手后,向{appname}/{streamname} 推流失败");
          }

          [self onStreamError];
          return;
      }
}

- (void) onStreamError {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->_kit.streamerBase stopStream];
        [self getStartShow];
    });
    
}

- (void) onNetStateEvent:(NSNotification *)notification {
    
    KSYNetStateCode netEvent = _kit.streamerBase.netStateCode;
      
      if ( netEvent == KSYNetStateCode_SEND_PACKET_SLOW ) {
        
          NSLog(@"发送包时间过长，( 单次发送超过 500毫秒 ）");
      }
      else if ( netEvent == KSYNetStateCode_EST_BW_RAISE ) {
    
          NSLog(@"估计带宽调整，上调" );
      }
      else if ( netEvent == KSYNetStateCode_EST_BW_DROP ) {

          
          NSLog(@"估计带宽调整，下调" );
      }
      else if ( netEvent == KSYNetStateCode_KSYAUTHFAILED ) {
          
          NSLog(@"SDK 鉴权失败 (暂时正常推流5~8分钟后终止推流)" );
      }
}

/*
 * 开启 采集预览
 */
-(void)getStarCaiji{
   self.kit = [[KSYGPUStreamerKit alloc] initWithDefaultCfg];
   [self.kit startPreview:self.view];
}
/*
 * 开启 - 直播
 */
-(void)getStartShow{
    
    NSString *  urlStrtimestring = self.model.stream ;
    NSString *   _socketUrl = self.model.chatserver;
    NSArray * gameArr = @[ gameurl , fiveurl , careurl ,timeeurl ,sixurl ,happyurl , famerurl , ] ;
    if (socketL) {
        [socketL closeRoom];//发送关闭直播的socket
        [socketL colseSocket];//注销socket
        socketL = nil;//注销socket
    }
    socketL = [[socketLive alloc]init];
    socketL.delegate = self;
//    socketL.zhuboDic = _roomDic;
//    [socketL getshut_time:_shut_time];//获取禁言时间
    [socketL addNodeListen:_socketUrl andTimeString:urlStrtimestring];
    
    //wxm 请求游戏数据
    socketGame = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:gameArr[self.model.gameID - 1]]];
     socketGame.delegate = self;
     [socketGame open];
//    //投注
     socketTouZhu = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:BETTING]];
     socketTouZhu.delegate = self;
     [socketTouZhu open];
    
    NSString *rtmpSrv  = self.model.push ;
//    http://tui.laipi917.com/live/
    NSURL* _hostURL = [[NSURL alloc] initWithString:rtmpSrv] ;
//    NSURL* _hostURL = [[NSURL alloc] initWithString:@"rtmp://tui.laipi917.com/rtmplive/34134_1591597075"] ;
    [self.kit.streamerBase startStream:_hostURL] ; //开始推流
    
    [self changeRoomStatus:@"1"]; //开播状态改变
    [self starTimeInfo];
    [self starTimeUpPeopleInfo];
}

/*
 * 退出直播间 - 关播
 */
-(void)clickCloseImg{
    
    [self onQuit];
}

/*
 * 进入页面 倒计时
 */
-(void)startUI{

    frontView = [[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT)];
    frontView.clipsToBounds = YES;
    frontView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:frontView];
    
    UIImageView * iamgeView = [QuickCreatUI creatUIImageViewWithSuperView:frontView andFrame:CGRectMake(0,0, WIDTH, HEIGHT) andImg:@"live_permission_bg"];
//    iamgeView.image = [ImgHelp tg_blurryImage:[UIImage imageNamed:@"ac_bg_rank"] withBlurLevel:10];
    gaosiImg = iamgeView ;
    
    //倒计时动画
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backView.opaque = YES;
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 -100, HEIGHT/2-200, 100, 100)];
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:90];
    label1.text = @"3";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.center = backView.center;
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 -100, HEIGHT/2-200, 100, 100)];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:90];
    label2.text = @"2";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.center = backView.center;
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 -100, HEIGHT/2-200, 100, 100)];
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:90];
    label3.text = @"1";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.center = backView.center;
    label1.hidden = YES;
    label2.hidden = YES;
    label3.hidden = YES;
    [backView addSubview:label3];
    [backView addSubview:label1];
    [backView addSubview:label2];
    [frontView addSubview:backView];
    [self kaishidonghua];
    self.view.backgroundColor = [UIColor clearColor];
}
//开始321
-(void)kaishidonghua{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->label1.hidden = NO;
        [self donghua:self->label1];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->label1.hidden = YES;
        self->label2.hidden = NO;
        [self donghua:self->label2];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->label2.hidden = YES;
        self->label3.hidden = NO;
        [self donghua:self->label3];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->label3.hidden = YES;
        self->backView.hidden = YES;
        [self->backView removeFromSuperview];
        [self->gaosiImg removeFromSuperview];
        [self layTopSubViews] ;
        [self getStartShow];//请求直播
    });
}
-(void)donghua:(UILabel *)labels{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.8;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(4.0, 4.0, 4.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(3.0, 3.0, 3.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 2.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)]];
    animation.values = values;
    animation.removedOnCompletion = NO;//是不是移除动画的效果
    animation.fillMode = kCAFillModeForwards;//保持最新状态
    [labels.layer addAnimation:animation forKey:nil];
}

/*
 * 初始化 - 界面布局
 */
-(void)layTopSubViews{
    
    // 开播时间
    timeLabelbackView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(gap, kStatusBarHeight + 5, 100, 22) color:[UIColor colorWithWhite:0.4 alpha:0.5]];
    liveingTimeLabel = [QuickCreatUI creatUILabelWithSuperView:frontView andFrame:CGRectMake(gap, kStatusBarHeight + 5, 100, 22) andText:@"00:00:00" andStringColor:kWhiteColor andFont:14];
    liveingTimeLabel.textAlignment = NSTextAlignmentCenter ;
    [liveingTimeLabel viewCornersWith:11];
//    liveingTimeLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    [liveingTimeLabel sizeToFit] ;
    liveingTimeLabel.width += 15 ;
    liveingTimeLabel.height = 22 ;
    liveingTimeLabel.left = liveingTimeLabel.left + 15;
    timeLabelbackView.width = liveingTimeLabel.width + 15 ;
    timeLabelbackView.height = liveingTimeLabel.height ;
    [timeLabelbackView viewCornersWith:11];
    
    listView = [[ListCollection alloc]initWithListArray:nil andID:[NSString stringWithFormat:@"%@",[UserInfoManaget sharedInstance].model.id]  andStream:self.model.stream];
    listView.frame = CGRectMake(timeLabelbackView.right + 10,kStatusBarHeight + 5,WIDTH - timeLabelbackView.right  - 100 - lrPad , 40 );
    listView.delegate = self;
    [frontView addSubview:listView];
    
    
    timeOpenIcon = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(0, 0, 8, 8) color:kRedColor];
    timeOpenIcon.centerY = liveingTimeLabel.height /2 + kStatusBarHeight + 5  ;
    timeOpenIcon.right = liveingTimeLabel.left ;
    [timeOpenIcon viewCornersWith:4];
    
//    liveingTimeLabel.hidden = YES ;
    
    // 礼物label
   UIImageView * giveBackView = [QuickCreatUI creatUIImageViewWithSuperView:frontView andFrame:CGRectMake(gap, liveingTimeLabel.bottom + 10, 90, 20) andImg:@"photos.9"];
    UIImageView * iconImg = [QuickCreatUI creatUIImageViewWithSuperView:frontView andFrame:CGRectMake(gap, liveingTimeLabel.bottom + 10, 20, 20) andImg:@"toubu"] ;
    giveNumLabel = [QuickCreatUI creatUILabelWithSuperView:frontView andFrame:CGRectMake(iconImg.right  +5, liveingTimeLabel.bottom + 10, 70 , 20) andText:@"588.12" andStringColor:kWhiteColor andFont:13] ;
    giveBackView.hidden = iconImg.hidden = giveNumLabel.hidden = YES ;
    
    //消息messageView
    messageView = [[UIView alloc ] initWithFrame:CGRectMake(gap, giveNumLabel.bottom + 5, WIDTH - 2*gap, 20)];
    [messageView viewCornersWith:4.0];
    messageView.hidden = YES ;
    messageView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5] ;
    [frontView addSubview:messageView];
    
    
    NSArray * gameIcon = @[ @"oneFencai",@"slectFive",@"shiYifen",@"shishiCai",@"selctOne",@"happyTime",@"enjoeFamer"] ;
    //游戏种类的不同
    gameTypeView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(0, 0, 60, 70) color:kClearColor] ;
    UIImageView * gameImg = [QuickCreatUI creatUIImageViewWithSuperView:gameTypeView andFrame:CGRectMake(5, 0, 50, 50) andImg:gameIcon[self.model.gameID- 1]];
    [QuickCreatUI creatUIImageViewWithSuperView:gameTypeView andFrame:CGRectMake(0, gameImg.bottom, gameTypeView.width, 20) andImg:@"bg_txt_sales"];
    UILabel * openGameTimeLabel = [QuickCreatUI creatUILabelWithSuperView:gameTypeView andFrame:CGRectMake(0, gameImg.bottom, gameTypeView.width, 20)  andText:@"0:00" andStringColor:kWhiteColor andFont:13];
    gameTimeLabel = openGameTimeLabel ;
    openGameTimeLabel.textAlignment = NSTextAlignmentCenter;
    gameTypeView.top = messageView.bottom + 10 ;
    gameTypeView.right = WIDTH - gap;
    
    
    // 奖金view
    bonus = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(0, 0, 60, 70) color:kClearColor] ;
    UIImageView * bonusimgView = [QuickCreatUI creatUIImageViewWithSuperView:bonus andFrame:CGRectMake(5, 0, 50, 50) andImg:@"ic_anchor_reward"];
    bonusimgView.contentMode = UIViewContentModeScaleAspectFit ;
    [QuickCreatUI creatUIImageViewWithSuperView:bonus andFrame:CGRectMake(0, gameImg.bottom, gameTypeView.width, 20) andImg:@"btn_family_withdraw"];
    UILabel * bonusopenGameTimeLabel = [QuickCreatUI creatUILabelWithSuperView:bonus andFrame:CGRectMake(0, gameImg.bottom, gameTypeView.width, 20)  andText:@"0.00" andStringColor:kWhiteColor andFont:10];
    bonusLabel = bonusopenGameTimeLabel ;
    bonusopenGameTimeLabel.textAlignment = NSTextAlignmentCenter;
    bonus.top = gameTypeView.bottom + 15 ;
    bonus.right = WIDTH - gap;
    
    
    // 举报有奖 RewardView
    RewardView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(0, 0, 60, 60) color:kClearColor] ;
    UIImageView * RewardViewImg = [QuickCreatUI creatUIImageViewWithSuperView:RewardView andFrame:CGRectMake(7.5, 0, 45, 45) andImg:@"ic_anchor_reward"];
    RewardViewImg.contentMode = UIViewContentModeScaleAspectFit ;
    UILabel * RewardViewTitleLabel = [QuickCreatUI creatUILabelWithSuperView:RewardView andFrame:CGRectMake(0, RewardViewImg.bottom, RewardView.width, 15)  andText:@"举报有奖" andStringColor:kWhiteColor andFont:10];
    RewardViewTitleLabel.textAlignment = NSTextAlignmentCenter;
    RewardView.top = bonus.bottom + 120 ;
    RewardView.right = WIDTH - gap;
    RewardView.hidden = YES ;
    
    
    // 彩票明细
    lotteryView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(0, 0, 60, 60) color:kClearColor] ;
    UIImageView * lotteryViewImg = [QuickCreatUI creatUIImageViewWithSuperView:lotteryView andFrame:CGRectMake(7.5, 0, 45, 45) andImg:@"ic_anchor_reward"];
    lotteryViewImg.contentMode = UIViewContentModeScaleAspectFit ;
    UILabel * lotteryViewLabel = [QuickCreatUI creatUILabelWithSuperView:lotteryView andFrame:CGRectMake(0, lotteryViewImg.bottom, lotteryView.width, 15)  andText:@"彩票走势图" andStringColor:kWhiteColor andFont:10];
    lotteryViewLabel.textAlignment = NSTextAlignmentCenter;
    lotteryView.top = RewardView.bottom + 20 ;
    lotteryView.right = WIDTH - gap;
    lotteryView.hidden = YES ;
    
    // 菜单按钮listview
    bottomMenuView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(0, 0, 140 + 5*gap, 35) color:kClearColor];
    bottomMenuView.right = WIDTH ;
    bottomMenuView.bottom = HEIGHT - kTabBarStatusBarHeight - 5;
    NSArray * titleArr = @[ @"ic_gift",@"btn_beauty",@"change_camera",@"stop_record_c"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIImageView * img = [QuickCreatUI creatUIImageViewWithSuperView:bottomMenuView andFrame:CGRectMake( (gap + 35 )*i, 0, 35, 35) andImg:titleArr[i]];
        [img viewCornersWith:17.5];
        img.userInteractionEnabled = YES ;
        img.tag = i + 10 ;
        
        if (i == titleArr.count - 1) {
            jingYinImg = img ;
        }
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg:)];
        [img addGestureRecognizer:tap];
    }
    
    closeBtn = [QuickCreatUI creatUIImageViewWithSuperView:frontView andFrame:CGRectMake(0, 0, 30, 30) andImg:@"btn_close"] ;
    closeBtn.userInteractionEnabled = YES ;
    closeBtn.right = WIDTH - lrPad ;
    closeBtn.top = kStatusBarHeight ;
    UITapGestureRecognizer * closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCloseImg)];
    [closeBtn addGestureRecognizer:closeTap];
    
    
    //在线人数
    onlineLabel = [[UILabel alloc]init];
    onlineLabel.frame = CGRectMake(0,0,65,30);
    onlineLabel.textAlignment = NSTextAlignmentCenter;
    onlineLabel.textColor = [UIColor whiteColor];
    onlineLabel.font = [UIFont systemFontOfSize:11];
    onlineLabel.right = closeBtn.left -5  ;
    onlineLabel.centerY = kStatusBarHeight + 15 ;
    onlineLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5] ;
    onlineLabel.layer.masksToBounds = YES ;
    onlineLabel.layer.cornerRadius = 15 ;
    NSString *liangname = [NSString stringWithFormat:@"%@",self.model.liang.name ];
    if ([liangname isEqual:@"0"]) {
        onlineLabel.text = [NSString stringWithFormat:@"ID:%@",[UserInfoManaget sharedInstance].model.id];
    }else{
        onlineLabel.text = [NSString stringWithFormat:@"%@",liangname];
    }
    [frontView addSubview:onlineLabel];
    
    
    //聊天
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0 ,WIDTH *0.75 - 15,HEIGHT*0.2) style:UITableViewStylePlain];
    self.tableView.bottom = bottomMenuView.top - 10 ;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.clipsToBounds = YES;
    self.tableView.estimatedRowHeight = 80.0;
    [frontView addSubview:self.tableView ];
    
    useraimation = [[userLoginAnimation alloc]init];
    useraimation.frame = CGRectMake(10,self.tableView.top - 40,_window_width,20);
    [frontView addSubview:useraimation ];
    
    //输入框
    keyField = [[UITextField alloc]initWithFrame:CGRectMake(10,7,WIDTH - 70, 30)];
    keyField.returnKeyType = UIReturnKeySend;
    keyField.delegate  = self;
    keyField.borderStyle = UITextBorderStyleNone;
    keyField.placeholder = @"和大家说些什么";
    keyField.backgroundColor = [UIColor whiteColor];
    keyField.layer.cornerRadius = 15.0;
    keyField.layer.masksToBounds = YES;
    UIView *fieldLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 30)];
    fieldLeft.backgroundColor = [UIColor whiteColor];
    keyField.leftView = fieldLeft;
    keyField.leftViewMode = UITextFieldViewModeAlways;
    keyField.font = [UIFont systemFontOfSize:15];
    keyField.inputAccessoryView = [[UIView alloc] init];
    keyField.returnKeyType = UIReturnKeySend;//变为搜索按钮
    
    www = 30;
    //键盘出现
    keyBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    keyBTN.tintColor = [UIColor whiteColor];
    keyBTN.userInteractionEnabled = YES;
    [keyBTN setBackgroundImage:[UIImage imageNamed:@"live_聊天"] forState:UIControlStateNormal];
    [keyBTN addTarget:self action:@selector(showkeyboard:) forControlEvents:UIControlEventTouchUpInside];
    keyBTN.layer.masksToBounds = YES;
    keyBTN.layer.shadowColor = [UIColor blackColor].CGColor;
    keyBTN.layer.shadowOffset = CGSizeMake(1, 1);
    keyBTN.frame = CGRectMake(10, 0, www, www);
    keyBTN.bottom = HEIGHT - kTabBarStatusBarHeight - 5 ;
    //发送按钮
    pushBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBTN setImage:[UIImage imageNamed:@"chat_send_gray"] forState:UIControlStateNormal];
    [pushBTN setImage:[UIImage imageNamed:@"chat_send_yellow"] forState:UIControlStateSelected];
    pushBTN.imageView.contentMode = UIViewContentModeScaleAspectFit;

    pushBTN.layer.masksToBounds = YES;
    pushBTN.layer.cornerRadius = 5;
    [pushBTN addTarget:self action:@selector(pushMessage:) forControlEvents:UIControlEventTouchUpInside];
    pushBTN.frame = CGRectMake(WIDTH-55,7,50,30);
    
    
    //tool绑定键盘
    toolBar = [[UIView alloc]initWithFrame:CGRectMake(0,HEIGHT+10, WIDTH, 44)];
    toolBar.backgroundColor = [UIColor clearColor];
    UIView *tooBgv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    tooBgv.backgroundColor = [UIColor whiteColor];
    tooBgv.alpha = 0.7;
    [toolBar addSubview:tooBgv];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(keyField.right+7, 11, 1, 20)];
    line2.backgroundColor = RGB(176, 176, 176);
    line2.alpha = 0.5 ;
    [toolBar addSubview:line2];
    [toolBar addSubview:pushBTN];
    [toolBar addSubview:keyField];
    [frontView addSubview:keyBTN];
    [self.view addSubview:toolBar];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangePushBtnState) name:UITextFieldTextDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(denglushixiao) name:@"denglushixiao" object:nil];
    
    liansongliwubottomview = [[UIView alloc]init];
    [self.view insertSubview:liansongliwubottomview belowSubview:frontView];
    liansongliwubottomview.frame = CGRectMake(0, self.tableView.top-150,WIDTH/2,140);
    
    [frontView bringSubviewToFront:useraimation];
    
    zjView = [[UIView alloc]init];
    zjView.frame = CGRectMake(WIDTH/2 - 80, RewardView.top - 50, WIDTH/2 + 50 , 20) ;
    [frontView addSubview:zjView];
}

#pragma mark ============ 计时器  =============
-(void)starTimeInfo{
    
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行

        dispatch_source_set_event_handler(_timer, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _openTime ++ ;
                  NSInteger h = _openTime / 3600 ;
                  NSInteger f = (_openTime - h * 3600 )  / 60;
                  NSInteger m = (_openTime - h * 3600  - f*60)  ;
                  
                  NSString * time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",h,f,m];
                  liveingTimeLabel.text = time ;
            });
           
        });
        dispatch_resume(_timer);
    
}

/*
 * 刷新用户列表
 */
-(void)starTimeUpPeopleInfo{
    
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _uppeopleInfo = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_uppeopleInfo, dispatch_walltime(NULL, 0), [self.model.userlist_time integerValue]*NSEC_PER_SEC,  0); //每秒执行

        dispatch_source_set_event_handler(_uppeopleInfo, ^{
            
            [self reloadUserList];
       
        });
        dispatch_resume(_uppeopleInfo);
}


-(void)upUserNumMethod:(NSString *)num{
    
    userCount = [num integerValue] ;
    onlineLabel.text = [NSString stringWithFormat:@"%lld",userCount] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->onlineLabel sizeToFit] ;
        self->onlineLabel.height = 30 ;
        if (self->onlineLabel.width+10 < 30) {
            
            self->onlineLabel.width = 30 ;
        }else{
            self->onlineLabel.width += 15 ;
        }
        
        self->onlineLabel.right = self->closeBtn.left -5  ;
        self->onlineLabel.centerY = kStatusBarHeight + 15 ;
        self->listView.frame = CGRectMake(self->timeLabelbackView.right + 10,kStatusBarHeight ,  self->onlineLabel.left  - self->timeLabelbackView.right  - 2*lrPad , 40 );
//        self->listView.centerY = kStatusBarHeight + 15 ;
    });
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
       if ((NSNull *)configFirstDic == [NSNull null]) {
           
       }else{
           
           if ( webSocket == socketTouZhu) { // 投注 socket
//{"id":["3580","3581"],"game_id":1,"room_id":"34134","type":"robot"}
               
               if ([configFirstDic[@"type"]  isEqualToString:@"robot" ] ) {

                    [self JiqiInfoDataInfo:configFirstDic ];
               }
               
           }else{ // 游戏 socket
               
           [self.userNArray removeAllObjects];
           [self.prizeArray removeAllObjects];
            [self.moneyArray removeAllObjects];
               
           NSArray *dataArray = configFirstDic[@"related_user_uid_result"];
           if (dataArray.count>0) {
               NSArray *arr = dataArray.firstObject;
               if (arr.count>0) {
                    for (NSDictionary *dic in dataArray) {
                        self.prizeArray = dic[@"list_nicename"];
                        self.userNArray = dic[@"list_id"];
                        self.moneyArray = dic[@"user_jiangjin"];
                      }
                   for (int i= 0; self.prizeArray.count >i; i++) {
                       NSString *user = self.userNArray[i];
                       NSString *pri = self.prizeArray[i];
                       NSString *dsmoeny = self.moneyArray[i] ;
                       [self prizeLiveUserNameData:pri userID:user gameType:self.model.gameName andMoney:dsmoeny];
                   }
               }
       }
           
           
           NSArray *keys = [configFirstDic allKeys];
           NSString *oldkey ;
           NSString *newKey ;
            for (NSString * k in keys) {
                
                if ([k containsString:@"game_id"]&&[k containsString:@"new"]) {
                                                       newKey = k ;
                                                       continue;;
                                                   }
                if ([k containsString:@"game_id"]&&[k containsString:@"old"]) {
                    oldkey = k ;
                    continue;
                }
               
            }
            _gameTime = [configFirstDic[@"time"] integerValue] == 0 ? 60 :[configFirstDic[@"time"] integerValue] ;
           
           if (   [FWUtils isBlankString:configFirstDic[@"dianshu_result"]] || _gameTime != 60 ) { //第一次进去  初始化倒计时
               
               if (gameTime) {
                   [gameTime invalidate];
                   gameTime = nil ;
               }
               
               if (_gameTime <= 10) {
                   
                   gameTimeLabel.text = @"封盘中" ;
               }else{
                   
                   gameTimeLabel.text = [NSString stringWithFormat:@"0:%02ld", _gameTime - 10 ];
                   gameTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeGameTime) userInfo:nil repeats:YES] ;
               }
              
           }else{

               if (gameTime) {
                     [gameTime invalidate];
                     gameTime = nil ;
                }
               gameTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeGameTime) userInfo:nil repeats:YES] ;
                [self creatInfoView:configFirstDic[oldkey] andResult:configFirstDic[@"dianshu_result"]];
               
               NSArray * infoarr = configFirstDic[@"related_host_uid_result"];
               id  firsArr = infoarr.firstObject ;
               if ( [firsArr isKindOfClass:[NSDictionary class]] ) {
                   NSLog(@"isKindOfClass") ;
                   
                   [self handleZJInfo:infoarr];
               }
           }
       }
       }
}

/*
 * 游戏计时
 */
-(void)changeGameTime{
    
    _gameTime-- ;
    if ( _gameTime - 10 <= 0 ) {
        
        gameTimeLabel.text = @"封盘中";
        [gameTime invalidate];
        gameTime = nil ;
    }else{
        
        gameTimeLabel.text = [NSString stringWithFormat:@"0:%02ld",_gameTime - 10];
    }
    
}
/*
 * 期号 - 和中奖结果
 */
-(void)creatInfoView:(NSString *)num andResult:(NSString *)result{
//    bg_title_lottery_number
    
    UIView * animaView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(WIDTH, messageView.bottom, WIDTH *2/3 , 70) color:[UIColor colorWithWhite:0.3 alpha:0.6]];
    [animaView viewCornersWith:5.0];
    
    UIImageView * img = [QuickCreatUI creatUIImageViewWithSuperView:animaView andFrame:CGRectMake(0, 0, animaView.width, 25) andImg:@"bg_title_lottery_number"];
    
    UILabel * gameName = [QuickCreatUI creatUILabelWithSuperView:animaView andFrame:CGRectMake(5, 0, 60, 25) andText:self.model.gameName andStringColor:kWhiteColor andFont:12];
    gameName.textAlignment = NSTextAlignmentCenter ;
    [gameName sizeToFit] ;
    gameName.width += 10 ;
    gameName.height = 25 ;
    
    [QuickCreatUI creatUILabelWithSuperView:animaView andFrame:CGRectMake(gameName.right + 5, 0, animaView.width - gameName.right - 10, 25) andText:[NSString stringWithFormat:@"%@期开奖",num] andStringColor:kWhiteColor andFont:10];
    gameName.textAlignment = NSTextAlignmentLeft ;
    
    UIView * openInfoView = [QuickCreatUI creatUIViewWithSuperView:animaView andFrame:CGRectMake(0, img.bottom, animaView.width, 45) color:kClearColor];
    
    NSArray * titleArr =  [result componentsSeparatedByString:@","];
    double x = 5 ;
    if (self.model.gameID == 7) { //农场
        
        double itemW = (WIDTH *2/3 /titleArr.count) >=  20 ? 20 : (WIDTH *2/3 /titleArr.count) ;
        double itemh = (WIDTH *2/3 /titleArr.count) >=  20 ? 20 : (WIDTH *2/3 /titleArr.count) ;
        
        for (int i = 0; i < titleArr.count; i++) {
            
            UIImageView * image = [QuickCreatUI creatUIImageViewWithSuperView:openInfoView andFrame:CGRectMake(x, 0, itemW, itemh) andImg:[NSString stringWithFormat:@"cqxync%02d",[titleArr[i]  intValue]]];
            image.centerY = 22.5 ;
            x += (itemW + 5);
        }
    }else if (self.model.gameID == 1){ // 一分快三
        double itemW = 25 ;
              double itemh = 25 ;
              
              for (int i = 0; i < titleArr.count; i++) {
                  
                  UIImageView * image = [QuickCreatUI creatUIImageViewWithSuperView:openInfoView andFrame:CGRectMake(x, 0, itemW, itemh) andImg:[NSString stringWithFormat:@"kuaisan_bg%02d",[titleArr[i]  intValue]]];
                  image.centerY = 25 ;
                  x += (itemW + 5);
              }
        
    }else if (self.model.gameID == 5){ // 一分六合彩
        
        NSMutableArray * ar = titleArr.mutableCopy;
        [ar insertObject:@"+" atIndex:ar.count - 1] ;
        double itemW = 22 ;
        double itemh = 22 ;
        
        NSArray * redArr = @[@"1",@"2",@"7",@"8",@"12",@"13",@"18",@"19",@"23",@"24",@"29",@"30",@"34",@"35",@"40",@"45",@"46"] ;
        
        NSArray * blueArr = @[@"3",@"4",@"9",@"10",@"14",@"15",@"20",@"25",@"26",@"31",@"36",@"37",@"41",@"42",@"47",@"48"] ;
        
        NSArray * greenArr = @[@"5",@"6",@"11",@"16",@"17",@"21",@"22",@"27",@"28",@"32",@"33",@"38",@"39",@"43",@"44",@"49"] ;
        
        for (int i = 0; i < ar.count; i++) {
                  
            UILabel * label = [QuickCreatUI creatUILabelWithSuperView:openInfoView andFrame:CGRectMake(x, 0, itemW, itemh) andText:ar[i] andStringColor:kWhiteColor andFont:10];
            [label viewCornersWith:11.0];
            label.textAlignment = NSTextAlignmentCenter ;
            if (i != ar.count - 2) {
                if ([redArr containsObject:ar[i]]) {
                    label.backgroundColor = changColors;
                }else if ([blueArr containsObject:ar[i]]){
                    label.backgroundColor = RGB(77, 172, 192);
                }else if ([greenArr containsObject:ar[i]]){
                    label.backgroundColor = RGB(160, 198, 117);
                }
            }
            label.centerY = 25 ;
            x += (itemW + 2);
        }
        
    }else if (self.model.gameID == 3){ // 一分赛车
        
        double itemW = (WIDTH *2/3 /titleArr.count) >=  20 ? 20 : (WIDTH *2/3 /titleArr.count) ;
        double itemh = (WIDTH *2/3 /titleArr.count) >=  20 ? 20 : (WIDTH *2/3 /titleArr.count) ;
       
       for (int i = 0; i < titleArr.count; i++) {
                 
           UILabel * label = [QuickCreatUI creatUILabelWithSuperView:openInfoView andFrame:CGRectMake(x, 0, itemW, itemh) andText:titleArr[i] andStringColor:kWhiteColor andFont:11];
           [label viewCornersWith:itemW/2];
           label.textAlignment = NSTextAlignmentCenter ;
           if ([label.text isEqualToString:@"1"]) {
               label.backgroundColor = RGB(228, 218, 80);
           }
           if ([label.text isEqualToString:@"2"]) {
               label.backgroundColor = RGB(69, 149, 213);
           }
           if ([label.text isEqualToString:@"3"]) {
               label.backgroundColor = RGB(75, 75, 75);
           }
           if ([label.text isEqualToString:@"4"]) {
               label.backgroundColor = RGB(238, 114, 47);
           }
           if ([label.text isEqualToString:@"5"]) {
               label.backgroundColor = RGB(112, 223, 225);
           }
           if ([label.text isEqualToString:@"6"]) {
               label.backgroundColor = RGB(76, 79, 236);
           }
           if ([label.text isEqualToString:@"7"]) {
               label.backgroundColor = RGB(191, 191, 191);
           }
           if ([label.text isEqualToString:@"8"]) {
               label.backgroundColor = RGB(216, 52, 33);
           }
           if ([label.text isEqualToString:@"9"]) {
               label.backgroundColor = RGB(107, 15, 11);
           }
           if ([label.text isEqualToString:@"10"]) {
               label.backgroundColor = RGB(112, 223, 225);
           }
           label.centerY = 25 ;
           x += (itemW + 5);
       }
        
    }else{ // 数字显示
        
        double itemW = (WIDTH *2/3 /titleArr.count) >=  20 ? 20 : (WIDTH *2/3 /titleArr.count) ;
        double itemh = (WIDTH *2/3 /titleArr.count) >=  20 ? 20 : (WIDTH *2/3 /titleArr.count) ;
        
        for (int i = 0; i < titleArr.count; i++) {
                  
            UILabel * label = [QuickCreatUI creatUILabelWithSuperView:openInfoView andFrame:CGRectMake(x, 0, itemW, itemh) andText:titleArr[i] andStringColor:kWhiteColor andFont:11];
            [label viewCornersWith:itemW/2];
            label.textAlignment = NSTextAlignmentCenter ;
            label.backgroundColor = [FWUtils getRandomColor] ;
            label.centerY = 25 ;
            x += (itemW + 5);
        }
    }
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        animaView.left = 10 ;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:4.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            animaView.bottom = 0 ;
            animaView.alpha = 0 ;
        } completion:^(BOOL finished) {
            
            [animaView removeFromSuperview];
        }];
    }];
}

/*
 *
 */
-(void)getZhongJiangInfoViewJJ:(NSArray *)jjArr{

////    bg_bonus.9   709  82
//    mutGame = @[].mutableCopy ;
//    gameAnimationTime = 0 ;
//    mutjjArr = jjArr.mutableCopy ;
//    for (int i = 0; i<self.prizeArray.count ; i++) {
//
//        NSString * name = self.prizeArray[i] ;
//        NSString * money = self.moneyArray[i] ;
////        NSString * jj = jjArr[i] ;
//
//        UIView * jjView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(WIDTH, RewardView.top - 50, WIDTH *3/5, 40) color:kClearColor];
//
//        jjView.layer.contents = (id)[UIImage imageNamed:@"bg_bonus.9"].CGImage ;
//        jjView.contentMode = UIViewContentModeScaleAspectFill ;
//
//        UILabel * label = [QuickCreatUI creatUILabelWithSuperView:jjView andFrame:CGRectMake(10, 0, jjView.width - 20, 40) andText:[NSString stringWithFormat:@"%@中奖,奖金%@" ,name , money ] andStringColor:kWhiteColor andFont:13];
//
//        [jjView viewCornersWith:5.0];
//
//        [mutGame addObject:jjView];
//    }
//
//    [self animationView:mutGame[gameAnimationTime] ];
    
    if (!zjAnimationView) {
        zjAnimationView = [[ZhongJiangView alloc]initWithFrame:zjView.bounds];
        [zjView addSubview:zjAnimationView];
        //初始化礼物空位
        [zjAnimationView initGift];
    }
//    self.prizeArray = dic[@"list_nicename"];
//    self.userNArray = dic[@"list_id"];
//    self.moneyArray = dic[@"user_jiangjin"];
    for (int i = 0; i < self.prizeArray.count; i++) {
            
        NSString * uid = self.userNArray[i];
        NSString *money  = self.moneyArray[i];
        NSString *name  = self.prizeArray[i];
        
        NSDictionary * params = @{
            @"userid":uid ,
            @"money":money ,
            @"name":name ,
        };
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i*0.5 + 0.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSString * money = [NSString stringWithFormat:@"%@",jjArr[i] ];
            
            if ( i == 0 ) {
                
                self->bonusLabel.text = StringFormat(@"%.3lf",[money doubleValue]) ;
            }else{
                
                self->bonusLabel.text = StringFormat(@"%.3lf",[self->bonusLabel.text doubleValue] + [money doubleValue]);
            }
            
            [self->zjAnimationView GiftPopView:params];
        });
    }
}

-(void)animationView:(UIView *)view {
    gameAnimationTime++ ;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
           
           view.right = WIDTH - 10 ;
           
       } completion:^(BOOL finished) {
           
           [UIView animateWithDuration:0.2 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
               view.bottom = self->bonus.bottom ;
               view.alpha = 0 ;
           } completion:^(BOOL finished) {
               
               [view removeFromSuperview];
               
               NSString * money = [NSString stringWithFormat:@"%@",mutjjArr[gameAnimationTime - 1] ];
               if (gameAnimationTime - 1 == 0   ) {
                   
                   self->bonusLabel.text = money ;
               }else{
                   bonusLabel.text = StringFormat(@"%.3lf",[bonusLabel.text doubleValue] + [money doubleValue]);
               }
               
               if ( self->gameAnimationTime < self->mutGame.count  ) {
                   
                   [self animationView: self->mutGame[gameAnimationTime]] ;
               }
           }];
       }];
}

/*
 * 处理 - 中奖信息
 */
-(void)handleZJInfo:(NSArray * )array{
    
    NSDictionary * dictdata = array.firstObject ;
    NSArray * idArr = dictdata[@"list_id"] ;
//    NSArray * nameArr = dictdata[@"list_nicename"] ;
    NSArray * fhjg = dictdata[@"host_jiangjin"] ;
//    NSLog(@"==idArr = %@ , nameArr = %@", idArr , nameArr );
    NSMutableArray * myidArr = @[].mutableCopy ;
//    NSMutableArray * mynameArr = @[].mutableCopy ;
    NSMutableArray * hostJJArr = @[].mutableCopy ;
    
    for (int i = 0; i<idArr.count; i++) {
        NSArray * itemArr = idArr[i] ;
//        NSArray *itemNameArr = nameArr[i] ;
//        NSLog(@"==itemArr = %@ , itemNameArr = %@", itemArr , itemNameArr );
        for (int j = 0; j < itemArr.count ; j++) {
            NSString * idString = itemArr[j] ;
//            NSString * nameString = itemNameArr[j] ;
//            NSLog(@"==idString = %@ .id %@ , nameString = %@", idString ,[UserInfoManaget sharedInstance].model.id , nameString );
            if ([[UserInfoManaget sharedInstance].model.id isEqualToString:StringFormat(@"%@" ,idString ) ]) {
                
//                NSLog(@"==idString = %@ , nameString = %@", idString , nameString );
                
                [myidArr addObject:StringFormat(@"%d",i)];
//                [mynameArr addObject:nameString];
                break;
            }
        }
    }
    for (int i = 0; i<myidArr.count; i++) {
        NSInteger index = [myidArr[i] integerValue];
        [hostJJArr addObject:fhjg[index]];
    }
    
    [self getZhongJiangInfoViewJJ:hostJJArr];
//    NSLog(@"本直播间中奖 mynameArr = %@ , hostJJArr = %@",mynameArr , hostJJArr) ;
}


//  =====  中奖消息
- (void)prizeLiveUserNameData:(NSString *)userName userID:(NSString *)userID gameType:(NSString *)game andMoney:(NSString *)dsmoney{
  
    NSString *centent = [NSString stringWithFormat:@"SystemNotZj#恭喜%@在%@中奖了",userName,game];
    [socketL sendKaiJiangInfo:centent andDaShangID:userID andDSMoney:dsmoney];
}

//  =====  机器人投注信息
//  {"id":["5134","5135","5136","5137"],"game_id":1,"room_id":"6","type":"robot","robot_name":"\u6d4b\u8bd53","totalcoin":"39","user_id":"3"}
- (void)JiqiInfoDataInfo:(nonnull NSDictionary *)dic{
  
    NSArray * arr = @[ @"一分快三",@"一分11选5" ,@"一分赛车",@"一分时时彩",@"一分六合彩",@"一分快乐十分",@"一分幸运农场"] ;
    NSInteger index = [dic[@"game_id"] integerValue];
    NSString * gameName = arr[index - 1] ; //游戏名字
    NSString *money = dic[@"totalcoin"] ; //钱
    NSString *userName = dic[@"robot_name"] ; //人名
    
    NSString *centent = [NSString stringWithFormat:@"SystemNotTz#%@ 在%@中,下注了%@元",userName,gameName,money];
    NSArray *dataArray = dic[@"id"];
    NSString *game_id = dic[@"game_id"];
    NSString *type = dic[@"type"];
    NSString *number = @"";
    for (NSString *str in dataArray) {
        if (number.length == 0) {
            number = str;
        }else{
            number = [NSString stringWithFormat:@"%@,%@",number,str];
        }
    }
    
    [socketL bettingInfo:centent gameType:type gameID:game_id gameNumnber:number];
}

- (NSMutableArray *)prizeArray{
    if (!_prizeArray) {
        _prizeArray = [NSMutableArray array];
    }
    return _prizeArray;
    
}
- (NSMutableArray *)userNArray{
    if (!_userNArray) {
        _userNArray = [NSMutableArray array];
    }
    return _userNArray;
    
}

- (NSMutableArray *)moneyArray{
    if (!_moneyArray) {
        _moneyArray = [NSMutableArray array];
    }
    return _moneyArray;
    
}

#pragma mark ============公聊消息=============

/*
 * 计费房间进入 - 改变魅力值
 */
-(void)addvotesdelegate:(NSString *)votes{
//    [self addCoin:[votes longLongValue]];
}
//用户进入直播间发送XXX进入了直播间
-(void)userLoginSendMSG:(NSDictionary *)dic {
    titleColor = @"userLogin";
    NSString *uname = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"user_nicename"]];
    NSString *levell = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"level"]];
    NSString *ID = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"id"]];
    NSString *vip_type = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"vip_type"]];
    NSString *liangname = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"liangname"]];
    NSString *usertype = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"usertype"]];
    NSString *guard_type = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"guard_type"]];

    NSString *conttt = @" 进入了直播间";
    NSString *isadmin;
    if ([[NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"usertype"]] isEqual:@"40"]) {
        isadmin = @"1";
    }else{
        isadmin = @"0";
    }
    NSDictionary *chat = [NSDictionary dictionaryWithObjectsAndKeys:uname,@"userName",conttt,@"contentChat",levell,@"levelI",ID,@"id",titleColor,@"titleColor",vip_type,@"vip_type",liangname,@"liangname",usertype,@"usertype",guard_type,@"guard_type",nil];
    [msgList addObject:chat];
    titleColor = @"0";
    if(msgList.count>30)
    {
        [msgList removeObjectAtIndex:0];
    }
    [self.tableView reloadData];
    [self jumpLast:self.tableView];
}
/*
 * 系统消息
 */
-(void)socketSystem:(NSString *)ct{
    
    NSString *uname = @"直播间消息";
    NSString *levell = @" ";
    NSString *ID = @" ";
    NSString *vip_type = @"0";
    NSString *liangname = @"0";
    NSString *content = ct;
    
    if ([ct containsString:@"System"]&&[ct containsString:@"#"]) {
        
        NSArray * arr = [ct componentsSeparatedByString:@"#"] ;
           
       if ([ @"SystemNotTz"  isEqualToString: arr.firstObject ]) {
           
           titleColor = @"xiazhu";
       }else if ([ @"SystemNotZj"  isEqualToString: arr.firstObject ]){
           
           titleColor = @"zhongjiang";
       }
       content = arr.lastObject ;
           
    }else {
        
        titleColor = @"firstlogin";
    }
    
    NSDictionary *chat = [NSDictionary dictionaryWithObjectsAndKeys:uname,@"userName",content,@"contentChat",levell,@"levelI",ID,@"id",titleColor,@"titleColor",vip_type,@"vip_type",liangname,@"liangname",nil];
    [msgList addObject:chat];
   
    if(msgList.count>30)
    {
        [msgList removeObjectAtIndex:0];
    }
    [self.tableView reloadData];
    [self jumpLast:self.tableView];
    titleColor = @"0";
    
}
/**
   获取打赏 - 消息
 */
-(void)socketSystemWithDs:(NSString *)ct{
    
    UIView * dsView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(WIDTH, messageView.bottom + 80, WIDTH*2/3, WIDTH*2/3 * 82 / 709) color:kClearColor];
    
    [frontView bringSubviewToFront:dsView];
    
    [QuickCreatUI creatUIImageViewWithSuperView:dsView andFrame:dsView.bounds andImg:@"bg_bonus.9"];
    
    UILabel * label = [QuickCreatUI creatUILabelWithSuperView:dsView andFrame:CGRectMake(25, 0, dsView.width - 25 , dsView.height) andText:ct andStringColor:kWhiteColor andFont:14];
    label.font = [UIFont systemFontOfSize:14 weight:3];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

         dsView.left = 10 ;

     } completion:^(BOOL finished) {

         [UIView animateWithDuration:0.3 delay:4.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
             dsView.bottom = 0 ;
             dsView.alpha = 0 ;
         } completion:^(BOOL finished) {

             [dsView removeFromSuperview];
         }];
     }];
    
}

/*
 * 发送 - 消息
 */
-(void)sendMessage:(NSDictionary *)dic{
    [msgList addObject:dic];
    if(msgList.count>30)
    {
        [msgList removeObjectAtIndex:0];
    }
    [self.tableView reloadData];
    [self jumpLast:self.tableView];
}

// 改变 发送按钮的样式
- (void)ChangePushBtnState{
    if (keyField.text.length > 0) {
        pushBTN.selected = YES;
    }else{
        pushBTN.selected = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (keyField.text.length >50) {
        [SVProgressHUD showErrorWithStatus:@"字数最多50字"];
        return YES;
    }
    pushBTN.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->pushBTN.enabled = YES;
    });
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [keyField.text stringByTrimmingCharactersInSet:set];
    if ([trimedString length] == 0) {
        
        return YES;
    }
    [socketL sendMessage:keyField.text];
    keyField.text = @"";
    pushBTN.selected = NO;
    NSLog(@"点击了发送");
    [self.view endEditing:YES] ;
    
return YES;

}
/*
 * 键盘代理
 */
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (!ismessgaeshow) {
        return;
    }
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    NSLog(@"height = %f",height) ;
    [UIView animateWithDuration:0.3 animations:^{
        
        self->toolBar.bottom = HEIGHT -  height ;
        self.tableView.bottom =  HEIGHT -  height - 50  ;
        [self changecontinuegiftframe];
        [self.view bringSubviewToFront:self->toolBar];
    }];
}
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    ismessgaeshow = NO;
    [UIView animateWithDuration:0.1 animations:^{
        self->toolBar.frame = CGRectMake(0, HEIGHT+10, WIDTH, 44);
        self.tableView.frame = CGRectMake(10,HEIGHT - HEIGHT*0.2 - 50 - kTabBarStatusBarHeight,WIDTH*0.75 - 15,HEIGHT*0.2);
        [self changecontinuegiftframe];
    }];
}


- (void)anchor_stopLink:(NSDictionary *)dic{
//    startPKBtn.hidden = YES;
//    [startPKBtn removeFromSuperview];
//    if (_js_playrtmp) {
//        [_js_playrtmp stopConnect];
//        [_js_playrtmp stopPush];
//        [_js_playrtmp removeFromSuperview];
//        _js_playrtmp = nil;
//    }
//    if (_tx_playrtmp) {
//        NSDictionary *hunDic = @{@"selfUrl":_hostURL,@"otherUrl":@""};
//        [_tx_playrtmp hunliu:hunDic andHost:YES];
//        [_tx_playrtmp stopConnect];
//        [_tx_playrtmp stopPush];
//        [_tx_playrtmp removeFromSuperview];
//        _tx_playrtmp = nil;
//    }
//    if (pkView) {
//        [pkView removeTimer];
//        [pkView removeFromSuperview];
//        pkView = nil;
//    }

//    [UIView animateWithDuration:0.3 animations:^{
//        .frame = CGRectMake(0, 0, WIDTH, HEIGHT);
//        if (![_sdkType isEqual:@"1"]) {
//             _gpuStreamer.preview.size = CGSizeMake(WIDTH, HEIGHT);
//        }
//    }];
//    isAnchorLink = NO;
//    [self changeLivebroadcastLinkState:NO];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
}
//  发送消息
-(void)pushMessage:(UITextField *)sender{
    if (keyField.text.length >50) {
        [SVProgressHUD showErrorWithStatus:@"字数最多50字"];
        return;
    }
    pushBTN.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->pushBTN.enabled = YES;
    });
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [keyField.text stringByTrimmingCharactersInSet:set];
    if ([trimedString length] == 0) {
        
        return ;
    }
    [socketL sendMessage:keyField.text];
    keyField.text = @"";
    pushBTN.selected = NO;
    [self.view endEditing:YES] ;
}
//聊天输入框
-(void)showkeyboard:(UIButton *)sender{
    
    ismessgaeshow = YES;
    [keyField becomeFirstResponder];
    
}

/*
 * 点击 - 图片
 */
-(void)clickImg:( UITapGestureRecognizer *)tap {
    
    NSInteger tag = tap.view.tag ;
    
    if (tag == 10) { //点击了  礼物
        
        [self.someMenuView show];
        
    }else if (tag == 11) { //点击了  美颜
        
        if (!beautifulgirl) {
            __weak LiveingVC *weakself = self;
               beautifulgirl = [[beautifulview alloc]initWithFrame:self.view.bounds andhide:^(NSString *type) {
                   [weakself hidebeautifulgirl];
                   if (self->frontView) {
                       self->frontView.hidden = NO;
                   }
              } andslider:^(NSString *type) {
                   [weakself sliderValueChanged:[type floatValue]];
              } andtype:^(NSString *type) {
                  [weakself setMeiYanData:[type intValue]];
            }];
            [self.view addSubview:beautifulgirl];
        }
        beautifulgirl.hidden = NO;
        [self.view bringSubviewToFront:beautifulgirl];
        
    }else if (tag == 12) { //点击了  切换摄像头
        
        [self.kit.vCapDev rotateCamera];
    }else if (tag == 13) { //点击了  静音
        
        isJingYin = !isJingYin ;
        
        
        if (isJingYin) {
            [self.kit.streamerBase muteStream:YES];
           
        
            jingYinImg.image = [UIImage imageNamed:@"stop_record"];
        }else{
           
            [self.kit.streamerBase muteStream:NO];
            jingYinImg.image = [UIImage imageNamed:@"stop_record_c"];
        
        }
         NSLog(@"点击 静音");
    }
    NSLog(@"点击");
}

#pragma mark ============  礼物效果  =============
/************ 礼物弹出及队列显示开始 *************/
//红包
-(void)redbag{
    
}
-(void)expensiveGiftdelegate:(NSDictionary *)giftData{
    if (!haohualiwuV) {
        haohualiwuV = [[expensiveGiftV alloc]init];
        haohualiwuV.delegate = self;
        [frontView addSubview:haohualiwuV ];
        [frontView bringSubviewToFront:haohualiwuV];
    }
    if (giftData == nil) {
        
    }
    else
    {
        [haohualiwuV addArrayCount:giftData];
    }
    if(haohualiwuV.haohuaCount == 0){
        [haohualiwuV enGiftEspensive];
    }
}
-(void)expensiveGift:(NSDictionary *)giftData{
    
    if (!haohualiwuV) {
        haohualiwuV = [[expensiveGiftV alloc]init];
        haohualiwuV.delegate = self;
        [frontView addSubview:haohualiwuV];
        [frontView bringSubviewToFront:haohualiwuV];
    }
    if (giftData == nil) {
    }
    else
    {
        [haohualiwuV addArrayCount:giftData];
    }
    if(haohualiwuV.haohuaCount == 0){
        [haohualiwuV enGiftEspensive];
    }
}

/*
 * 幸运礼物全站效果
 */
- (void)showAllLuckygift:(NSDictionary *)dic{
    if (!luckyGift) {
        luckyGift = [[AllRoomShowLuckyGift alloc]initWithFrame:messageView.frame];
        [frontView addSubview:luckyGift];
    }
    [luckyGift addLuckyGiftMove:dic];
}

#pragma mark ============ 设置美颜  =============
//设置美颜
-(void)setMeiYanData:(int)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            _filter = [[KSYGPUBeautifyExtFilter alloc] init];
        }
            break;
        case 1:
        {
            _filter = [[KSYGPUBeautifyFilter alloc] init];
        }
            break;
        case 2:
        {
            _filter = [[KSYGPUDnoiseFilter alloc] init];
        }
            break;
        case 3:
        {
            _filter = [[KSYGPUBeautifyPlusFilter alloc] init];
        }
            break;
        default:
            _filter = nil;
            _filter = [[KSYGPUFilter alloc] init];
            break;
    }

    [self.kit setupFilter:_filter];

}
-(void)sliderValueChanged:(float)slider
{
    [(KSYGPUBeautifyExtFilter *)_filter setBeautylevel: slider];
}
-(void)hidebeautifulgirl
{
    beautifulgirl.hidden = YES;
}


/*
 * 注册 - 通知
 */
-(void)nsnotifition{
    //注册进入后台的处理
    NSNotificationCenter* notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self
           selector:@selector(appactive)
               name:UIApplicationDidBecomeActiveNotification
             object:nil];
    [notification addObserver:self
           selector:@selector(appnoactive)
               name:UIApplicationWillResignActiveNotification
             object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onStreamStateChange:)
                                                 name:KSYStreamStateDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onNetStateEvent:)
                                                 name:KSYNetStateEventNotification
                                               object:nil];
//    [notification addObserver:self selector:@selector(changeMusic:) name:@"wangminxindemusicplay" object:nil];
    [notification addObserver:self selector:@selector(shajincheng) name:@"shajincheng" object:nil];
    //@"shajincheng"
//    [notification addObserver:self selector:@selector(forsixin:) name:@"sixinok" object:nil];
//    [notification addObserver:self selector:@selector(getweidulabel) name:@"gengxinweidu" object:nil];
//    [notification addObserver:self selector:@selector(toolbarHidden) name:@"toolbarHidden" object:nil];
//    [notification addObserver:self selector:@selector(onAudioStateChange:)name:KSYAudioStateDidChangeNotification object:nil];
}

#pragma mark ============tableview的方法=============
// 以下是 tableview的方法
///*******    连麦 注意下面的tableview方法    *******/
//懒加载
-(NSArray *)chatModels{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in msgList) {
        chatModel *model = [chatModel modelWithDic:dic];
        if (_chatModels.count != 0) {
            [model setChatFrame:[_chatModels lastObject]];
        }
        [array addObject:model];
    }
    _chatModels = array;
    return _chatModels;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.chatModels.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    chatMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatMsgCELL"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"chatMsgCell" owner:nil options:nil] lastObject];
    }
    cell.model = self.chatModels[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    chatModel *model = self.chatModels[indexPath.section];
    [keyField resignFirstResponder];
    if ([model.userName isEqual:@"直播间消息"]) {
        return;
    }
    NSString *IsUser = [NSString stringWithFormat:@"%@",model.userID];
    if (IsUser.length > 1 && ![model.userID isEqualToString:[UserInfoManaget sharedInstance].model.id]  ) {
       NSDictionary *subdic = @{@"id":model.userID};
           [self GetInformessage:subdic];
    }
    
}

/**
 用户 弹框 -
 */
-(void)GetInformessage:(NSDictionary *)subdic{
    if (userView) {
        [userView removeFromSuperview];
        userView = nil;
    }

    if (!userView) {
        //添加用户列表弹窗
        userView = [[upmessageInfo alloc]initWithFrame:CGRectMake(WIDTH*0.1,HEIGHT,WIDTH*0.8,WIDTH*0.8/2+40 + 40 ) andPlayer:@"movieplay"];
        userView.lastLine.hidden = YES;
        userView.upmessageDelegate = self;
        userView.backgroundColor = [UIColor whiteColor];
        userView.layer.cornerRadius = 10;
        userView.clipsToBounds = YES;
        UIWindow *mainwindows = [UIApplication sharedApplication].keyWindow;
        [mainwindows addSubview:userView];
    }
    
    //用户弹窗
    tanChuangID = [NSString stringWithFormat:@"%@",[subdic valueForKey:@"id"]];
    [userView getUpmessgeinfo:subdic andzhuboDic:self.dictModel];
    [UIView animateWithDuration:0.2 animations:^{
        self->userView.frame = CGRectMake(WIDTH*0.1,HEIGHT*0.35,WIDTH*0.8,WIDTH*0.8/2+40 +40);
    }];
    
    /*
     _danmuView->backscrollview 5
     gamevc->backscrollview 6
     userview->backscroll添加 7
     haohualiwuv->backscrollview 8
     liansongliwubottomview->backscrollview 8
     */
}

/**
 发送ID
 */
-(void)clickSendInfo:(NSString *)touid anduserName:(NSString *)name{
    
    if ( [UserInfoManaget sharedInstance ].model.contact && [UserInfoManaget sharedInstance ].model.contact.length > 0 ) {

           [socketL sendMingPianInfoMessage:touid andToname:name] ;
           [self doCancle];

       }else{
           
           SetContantView * view = [[ SetContantView alloc] init ] ;
           [self.view addSubview:view] ;
           [[ZKModal sharedInstance] setTapOutsideToDismiss:YES];
           [[ZKModal sharedInstance] showWithContentView:view andAnimated:YES] ;
           [ SVProgressHUD  showErrorWithStatus:@"请先设置联系方式" ] ;
        
       }
}

-(void)doupCancle{
    [self doCancle];
}
//列表信息退出
-(void)doCancle{
    userView.forceBtn.enabled = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self->userView.frame = CGRectMake( WIDTH*0.1,HEIGHT*2, WIDTH*0.8,WIDTH*0.8);
    }];
    self.tableView.userInteractionEnabled = YES;
}

#pragma mark ============电话监听=============
- (void)reciverPhoneCall{

    [self.kit stopPreview];
}
- (void)phoneCallEnd{

    [self.kit startPreview:self.view];
    [self.kit.streamerBase startStream: [NSURL URLWithString:self.model.push]];

}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
      name:KSYStreamStateDidChangeNotification
    object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"shajincheng" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"denglushixiao" object:nil];
    
}
//杀进程
-(void)shajincheng{
    [self overRoomStatus];
}
-(void)backgroundselector{
    backTime +=1;
    NSLog(@"返回后台时间%d",backTime);
    if (backTime > 30) {
        [self overRoomStatus];
    }
}
-(void)backGround{
        //进入后台
        if (!backGroundTimer) {
            [self sendEmccBack];
            backGroundTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(backgroundselector) userInfo:nil repeats:YES];
        }
}
-(void)forwardGround{
    if (backTime != 0) {
        [socketL phoneCall:@"主播回来了"];
    }
    // 进入前台
    if (backTime > 30) {
        [self overRoomStatus];
    }
    
    [backGroundTimer invalidate];
    backGroundTimer  = nil;
    backTime = 0;
}
-(void)appactive{ //app 进入前台活跃
    NSLog(@"哈哈哈哈哈哈哈哈哈哈哈哈 app回到前台");
    [self.kit appBecomeActive];
   [self forwardGround];
}
-(void)appnoactive{//app 进入后台
    [self.kit  appEnterBackground];
    [self backGround];
    NSLog(@"0000000000000000000 app进入后台");
}
//来电话
-(void)sendEmccBack {
    [socketL phoneCall:@"主播离开一下，精彩不中断，不要走开哦"];
}


#pragma mark ============检查开播状态=============
- (void)checkLiveingStatus{
    [YBToolClass postNetworkWithUrl:@"Live.checkLiveing" andParameter:@{@"stream":minstr(self.model.stream)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        if (code == 0) {
            NSDictionary *dic = [info firstObject];
            NSLog(@"info=%@",info);
            if ([minstr([dic valueForKey:@"status"]) isEqual:@"0"]) {
            
                [SVProgressHUD showErrorWithStatus:@"连接已断开，请重新开播"];
                [self getCloseShow];
            }
        }
    } fail:^{

    }];
}

//直播结束选择 alertview
- (void)onQuit {
    
    UIAlertController  *alertlianmaiVCtc = [UIAlertController alertControllerWithTitle:@"确定退出直播吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //修改按钮的颜色，同上可以使用同样的方法修改内容，样式
    UIAlertAction *defaultActionss = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
        if (self->isclosenetwork) {
            
            dispatch_async(dispatch_get_main_queue(), ^{

                
                if (self->continueGifts) {
                      [self->continueGifts stopTimerAndArray];
                      [self->continueGifts initGift];
                      [self->continueGifts removeFromSuperview];
                      self->continueGifts = nil;
                  }
                  if (self->haohualiwuV) {
                      [self->haohualiwuV stopHaoHUaLiwu];
                      [self->haohualiwuV removeFromSuperview];
                      self->haohualiwuV.expensiveGiftCount = nil;
                  }

                [self->socketGame close];
                [self->socketTouZhu close];
                self->socketGame= nil ;
                self->socketTouZhu= nil ;
                
                if (self->gameTime) {
                    [self->gameTime invalidate];
                      self->gameTime = nil ;
                }
                
                if (self->backGroundTimer) {
                    [self->backGroundTimer invalidate];
                      self->backGroundTimer = nil ;
                }
                
                if (self.timer) {
                       dispatch_source_cancel(self.timer);
                       self.timer = nil;
                }
                
                if (self.uppeopleInfo) {
                    dispatch_source_cancel(self.uppeopleInfo);
                    self.uppeopleInfo = nil;
                }
                
                [self->socketL colseSocket];//注销socket
                self->socketL = nil;//注销socket
                [self.kit stopPreview];
                self.kit = nil;
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else{
            
            [self overRoomStatus];
        }
         
    }];
    UIAlertAction *cancelActionss = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    
    if (version.doubleValue < 9.0) {
        
    }
    else{
        [defaultActionss setValue:normalColors forKey:@"_titleTextColor"];
        [cancelActionss setValue:normalColors forKey:@"_titleTextColor"];
    }
    
    [alertlianmaiVCtc addAction:defaultActionss];
    [alertlianmaiVCtc addAction:cancelActionss];
    [self presentViewController:alertlianmaiVCtc animated:YES completion:nil];
    
}

// 代理方法 - token失效 在其他地方登陆
- (void)loginOnOtherDevice{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前账号已在其他设备登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       [self overRoomStatus];
        
        [UserInfoManaget sharedInstance].model.isOpenLiveing = NO;
        [[UserInfoManaget sharedInstance] save:[UserInfoManaget sharedInstance].model];
        MyTopVCPush([LoginVC new]);
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
// 退出直播间
-(void)superStopRoom:(NSString *)params{
    NSLog(@"params = %@", params ) ;
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出直播" message:nil preferredStyle:UIAlertControllerStyleAlert];
//       [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
          [self overRoomStatus];
           
//           [UserInfoManaget sharedInstance].model.isOpenLiveing = NO;
//           [[UserInfoManaget sharedInstance] save:[UserInfoManaget sharedInstance].model];
//           MyTopVCPush([LoginVC new]);
//
//       }]];
//       [self presentViewController:alert animated:YES completion:nil];
  
}


//请求关闭直播
-(void)getCloseShow
{
////    [self musicPlay];
//    NSString *url = [NSString stringWithFormat:@"Live.stopRoom&uid=%@&token=%@&stream=%@",[UserInfoManaget sharedInstance].model.id,[UserInfoManaget sharedInstance].model.token,self.model.stream];
//    [YBToolClass postNetworkWithUrl:url andParameter:nil success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
////        [QMUITips hideHUD];
////        [socketL closeRoom];//发送关闭直播的socket
//
////        [self dismissVC];
////        [self liveOver];//停止计时器
//        [socketL colseSocket];//注销socket
//        socketL = nil;//注销socket
//        //直播结束
////        [self onQuit:nil];//停止音乐、停止推流
////        [self rmObservers];//释放通知
//        //            [self.navigationController popViewControllerAnimated:YES];
////        [self requestLiveAllTimeandVotes];
//    } fail:^{
////        [MBProgressHUD hideHUD];
//        [socketL closeRoom];//发送关闭直播的socket
////        [self dismissVC];
////        [self liveOver];//停止计时器
//        [socketL colseSocket];//注销socket
//        socketL = nil;//注销socket
//        //直播结束
////        [self onQuit:nil];//停止音乐、停止推流
////        [self rmObservers];//释放通知
////        //        [self.navigationController popViewControllerAnimated:YES];
////        [self requestLiveAllTimeandVotes];
//    }];
}

/*
 * 改变 直播间状态
 */
-(void)changeRoomStatus:(NSString *)isopen{
    NSDictionary * dict = @{
        @"uid":[UserInfoManaget sharedInstance].model.id,
        @"token":[UserInfoManaget sharedInstance].model.token,
        @"stream":self.model.stream,
        @"status":isopen,
    };
    
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:ChangeLive] params:dict withHUD:YES success:^(id json) {
       
        NSLog(@"json = %@" , json ) ;
//        NSArray * dataArr = json[@"data"][@"info"];
//        NSDictionary * dict = dataArr.firstObject ;
        
    } failure:^(NSError *error) {
        
        NSLog(@"error =  %@" ,[error description] ) ;
        
    }];
}

/*
* 关播
*/
-(void)overRoomStatus{
    
    if (continueGifts) {
          [continueGifts stopTimerAndArray];
          [continueGifts initGift];
          [continueGifts removeFromSuperview];
          continueGifts = nil;
      }
      if (haohualiwuV) {
          [haohualiwuV stopHaoHUaLiwu];
          [haohualiwuV removeFromSuperview];
          haohualiwuV.expensiveGiftCount = nil;
      }

    [socketGame close];
    [socketTouZhu close];
    socketGame= nil ;
    socketTouZhu= nil ;
    
    if (gameTime) {
        [gameTime invalidate];
          gameTime = nil ;
    }
    
    if (backGroundTimer) {
        [backGroundTimer invalidate];
          backGroundTimer = nil ;
    }
    
    if (self.timer) {
           dispatch_source_cancel(self.timer);
           self.timer = nil;
    }
    
    if (self.uppeopleInfo) {
        dispatch_source_cancel(self.uppeopleInfo);
        self.uppeopleInfo = nil;
    }
 
    
    NSDictionary * dict = @{
        @"uid":[UserInfoManaget sharedInstance].model.id,
        @"token":[UserInfoManaget sharedInstance].model.token,
        @"stream":self.model.stream,
        @"type":@"1",
    };
    
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:StopRoom] params:dict withHUD:YES success:^(id json) {
            [self->socketL closeRoom];//发送关闭直播的socket
            [self->socketL colseSocket];//注销socket
            self->socketL = nil;//注销socket
            [self.kit stopPreview];
            self.kit = nil;
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self overliveingInfo]; //获取关播的信息
            [self changeRoomStatus:@"0"] ;
    } failure:^(NSError *error) {
        NSLog(@"error =  %@" ,[error description] ) ;
    }];
}
/*
 * 获取直播结束的信息
 */
-(void)overliveingInfo{
    NSDictionary * dict = @{
        @"stream":self.model.stream,
    };
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:StopInfo] params:dict withHUD:NO success:^(id json) {
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * dict = dataArr.firstObject ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self lastview:dict];
//            [self->frontView removeFromSuperview];
        });
    } failure:^(NSError *error) {
        NSLog(@"error =  %@" ,[error description] ) ;
    }];
}

/*
 * 直播结束 展示的view
 */
-(void)lastview:(NSDictionary *)dic{
    
    //无数据都显示0
    if (!dic) {
        dic = @{@"votes":dic[@"length"],@"nums":dic[@"nums"],@"length":dic[@"length"]};
    }
    
    UIImageView *lastView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    lastView.userInteractionEnabled = YES;
    [lastView sd_setImageWithURL:[NSURL URLWithString:[UserInfoManaget sharedInstance].model.avatar]];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0,WIDTH,HEIGHT);
    [lastView addSubview:effectview];
    
    
    UILabel *labell= [[UILabel alloc]initWithFrame:CGRectMake(0,24+kStatusBarHeight, WIDTH, HEIGHT*0.17)];
    labell.textColor = normalColors;
    labell.text = @"直播已结束" ;
    labell.textAlignment = NSTextAlignmentCenter;
    labell.font = [UIFont systemFontOfSize:20];
    [lastView addSubview:labell];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*0.1, labell.bottom+50, WIDTH*0.8, WIDTH*0.8*8/13)];
    backView.backgroundColor = RGB_COLOR(@"#000000", 0.2);
    backView.layer.cornerRadius = 5.0;
    backView.layer.masksToBounds = YES;
    [lastView addSubview:backView];
    
    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-50, labell.bottom, 100, 100)];
    [headerImgView sd_setImageWithURL:[NSURL URLWithString:[UserInfoManaget sharedInstance].model.avatar] placeholderImage:[UIImage imageNamed:@"bg1"]];
    headerImgView.layer.masksToBounds = YES;
    headerImgView.layer.cornerRadius = 50;
    [lastView addSubview:headerImgView];

    
    UILabel *nameL= [[UILabel alloc]initWithFrame:CGRectMake(0,50, backView.width, backView.height*0.55-50)];
    nameL.textColor = [UIColor whiteColor];
    nameL.text = [UserInfoManaget sharedInstance].model.user_nicename;
    nameL.textAlignment = NSTextAlignmentCenter;
    nameL.font = [UIFont systemFontOfSize:18];
    [backView addSubview:nameL];

    [[YBToolClass sharedInstance] lineViewWithFrame:CGRectMake(10, nameL.bottom, backView.width-20, 1) andColor:RGB_COLOR(@"#585452", 1) andView:backView] ;
    
    NSArray *labelArray = @[@"直播时长",StringFormat(@"收获%@",moneyNameInfo),@"观看人数"];
    for (int i = 0; i < labelArray.count; i++) {
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*backView.width/3, nameL.bottom, backView.width/3, backView.height/4)];
        topLabel.font = [UIFont boldSystemFontOfSize:15];
        topLabel.textColor = [UIColor whiteColor];
        topLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            topLabel.text = minstr([dic valueForKey:@"length"]);
        }
        if (i == 1) {
            topLabel.text = [NSString stringWithFormat:@"%.2f",[minstr([dic valueForKey:@"votes"]) floatValue]];
        }
        if (i == 2) {
            topLabel.text = minstr([dic valueForKey:@"nums"]);
        }
        [backView addSubview:topLabel];
        UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(topLabel.left, topLabel.bottom, topLabel.width, 14)];
        footLabel.font = [UIFont systemFontOfSize:13];
        footLabel.textColor = RGB_COLOR(@"#cacbcc", 1);
        footLabel.textAlignment = NSTextAlignmentCenter;
        footLabel.text = labelArray[i];
        [backView addSubview:footLabel];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH*0.1,HEIGHT *0.75, WIDTH*0.8,50);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(docancle) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundColor:normalColors];
    [button setBackgroundImage:[UIImage imageNamed:@"startLive_back"] forState:UIControlStateNormal];

    [button setTitle:@"返回首页" forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds  =YES;
    [lastView addSubview:button];
    [self.view addSubview:lastView];
    
}

- (void)docancle{
//    isRedayCloseRoom = YES;
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark ================ 直播结束 ===============
-(void)sendBarrage:(NSDictionary *)msg{
//    NSString *text = [NSString stringWithFormat:@"%@",[[msg valueForKey:@"ct"] valueForKey:@"content"]];
//    NSString *name = [msg valueForKey:@"uname"];
//    NSString *icon = [msg valueForKey:@"uhead"];
//    NSDictionary *userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:text,@"title",name,@"name",icon,@"icon",nil];
//    [danmuview setModel:userinfo];
}
-(void)sendDanMu:(NSDictionary *)dic{
//    NSString *text = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"content"]];
//    NSString *name = [dic valueForKey:@"uname"];
//    NSString *icon = [dic valueForKey:@"uhead"];
//    NSDictionary *userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:text,@"title",name,@"name",icon,@"icon",nil];
//    [danmuview setModel:userinfo];
//    long totalcoin = [self.danmuPrice intValue];//
//    [self addCoin:totalcoin];
}
-(void)getZombieList:(NSArray *)list{
    NSArray *arrays =[list firstObject];
    userCount += arrays.count;
//    onlineLabel.text = [NSString stringWithFormat:@"%lld",userCount];
    if (!listView) {
            listView = [[ListCollection alloc]initWithListArray:nil andID:[NSString stringWithFormat:@"%@",[UserInfoManaget sharedInstance].model.id]  andStream:self.model.stream];
        listView.frame = CGRectMake(timeLabelbackView.right + 10,kStatusBarHeight + 5,timeLabelbackView.right  - 60,40);
        listView.delegate = self;
        [frontView addSubview:listView];
    }
      [listView listarrayAddArray:[list firstObject]];
}

-(void)reloadUserList{
    if (listView) {
        [listView listReloadNoew];
    }
}

-(void)jumpLast:(UITableView *)tableView
{
    if (_canScrollToBottom) {
    NSUInteger sectionCount = [tableView numberOfSections];
    if (sectionCount) {
        
        NSUInteger rowCount = [tableView numberOfRowsInSection:0];
        if (rowCount) {
            
            NSUInteger ii[2] = {sectionCount-1, 0};
            NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
            [tableView scrollToRowAtIndexPath:indexPath
                             atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
    }
}
-(void)quickSort1:(NSMutableArray *)userlist
{
    for (int i = 0; i<userlist.count; i++)
    {
        for (int j=i+1; j<[userlist count]; j++)
        {
            int aac = [[[userlist objectAtIndex:i] valueForKey:@"level"] intValue];
            int bbc = [[[userlist objectAtIndex:j] valueForKey:@"level"] intValue];
            NSDictionary *da = [NSDictionary dictionaryWithDictionary:[userlist objectAtIndex:i]];
            NSDictionary *db = [NSDictionary dictionaryWithDictionary:[userlist objectAtIndex:j]];
            if (aac >= bbc)
            {
                [userlist replaceObjectAtIndex:i withObject:da];
                [userlist replaceObjectAtIndex:j withObject:db];
            }else{
                [userlist replaceObjectAtIndex:j withObject:da];
                [userlist replaceObjectAtIndex:i withObject:db];
            }
        }
    }
}
-(void)socketUserLive:(NSString *)ID and:(NSDictionary *)msg{
    int x =( arc4random() % 5)+1 ;
    userCount -= x;
    onlineLabel.text = [NSString stringWithFormat:@"%lld",userCount];
    if (listView) {
        [listView userLive:msg];
    }
}
-(void)socketUserLogin:(NSString *)ID andDic:(NSDictionary *)dic{
    int x =( arc4random() % 6) + 5 ;
    userCount += x;
    if (listView) {
        [listView userAccess:dic];
    }
    onlineLabel.text = [NSString stringWithFormat:@"%lld",userCount];
//    进场动画级别限制
    NSString *levelLimit = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"level"]];
    int levelLimits = [levelLimit intValue];
    int levelLimitsLocal = [[common enter_tip_level] intValue];
    if(levelLimitsLocal >levelLimits) {
        NSLog(@"不显示动画") ;
        
    }else{
    
//    NSString *vipType = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"vip_type"]];
//    NSString *guard_type = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"guard_type"]];
//    if ([vipType isEqual:@"1"] || [guard_type isEqual:@"1"] || [guard_type isEqual:@"2"]) {
//        [useraimation addUserMove:dic];
//        useraimation.frame = CGRectMake(10,self.tableView.top - 40,_window_width,20);
//    }

//  进场动画级别限制
    NSString *levelLimit = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"ct"] valueForKey:@"level"]];
    
    int levelLimits = [levelLimit intValue];
    int levelLimitsLocal = [[common enter_tip_level] intValue];
    //NSLog(@"===================>>%@---------------%d",levelLimit,levelLimitsLocal);
    if (2 >levelLimits) {

    }else{

        [useraimation addUserMove:dic];
        useraimation.frame = CGRectMake( 10,self.tableView.top - 80,_window_width,20);
    }
        
        
    NSString *car_id = minstr([[dic valueForKey:@"ct"] valueForKey:@"car_id"]);
    if (![car_id isEqual:@"0"]) {
        if (!vipanimation) {
            vipanimation = [[viplogin alloc]initWithFrame:CGRectMake(0,80,_window_width,_window_width*0.8) andBlock:^(id arrays) {
                [self->vipanimation removeFromSuperview];
                self->vipanimation = nil;
            }];
            vipanimation.frame =CGRectMake(0,80,_window_width,_window_width*0.8);
            [self.view insertSubview:vipanimation atIndex:10];
            [self.view bringSubviewToFront:vipanimation];
        }
        [vipanimation addUserMove:dic];
    }
    
    [self userLoginSendMSG:dic];
    }
}
-(void)socketLight{
    starX = bottomMenuView.centerX ;
    starY = bottomMenuView.top - 20;
    starImage = [[UIImageView alloc]initWithFrame:CGRectMake(starX, starY, 30, 30)];
    starImage.contentMode = UIViewContentModeScaleAspectFit;
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_6",@"heart_7",@"heart_8",@"heart_9",@"heart_10" ,nil];
    NSInteger random = arc4random()%array.count;
    starImage.image = [UIImage imageNamed:[array objectAtIndex:random]];
    [UIView animateWithDuration:0.2 animations:^{
        self->starImage.alpha = 1.0;
        self->starImage.frame = CGRectMake(starX+random - 10, starY-random - 30, 30, 30);
        CGAffineTransform transfrom = CGAffineTransformMakeScale(1.3, 1.3);
        self->starImage.transform = CGAffineTransformScale(transfrom, 1, 1);
    }];
    [self.view insertSubview:starImage atIndex:10];
    CGFloat finishX = WIDTH - round(arc4random() % 200);
    //  动画结束点的Y值
    CGFloat finishY = 200;
    //  imageView在运动过程中的缩放比例
    CGFloat scale = round(arc4random() % 2) + 0.7;
    // 生成一个作为速度参数的随机数
    CGFloat speed = 1 / round(arc4random() % 900) + 0.6;
    //  动画执行时间
    NSTimeInterval duration = 4 * speed;
    //  如果得到的时间是无穷大，就重新附一个值（这里要特别注意，请看下面的特别提醒）
    if (duration == INFINITY) duration = 2.412346;
    //  开始动画
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(starImage)];
    //  设置动画时间
    [UIView setAnimationDuration:duration];
    
    //  设置imageView的结束frame
    starImage.frame = CGRectMake( finishX, finishY, 30 * scale, 30 * scale);
    
    //  设置渐渐消失的效果，这里的时间最好和动画时间一致
    [UIView animateWithDuration:duration animations:^{
        self->starImage.alpha = 0;
    }];
    
    //  结束动画，调用onAnimationComplete:finished:context:函数
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    //  设置动画代理
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

/// 动画完后销毁iamgeView
- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    UIImageView *imageViewsss = (__bridge UIImageView *)(context);
    [imageViewsss removeFromSuperview];
    imageViewsss = nil;
}

//改变连送礼物的frame
-(void)changecontinuegiftframe{
    liansongliwubottomview.frame = CGRectMake(0, self.tableView.top - 150,WIDTH/2,140);
}

-(void)sendGift:(NSDictionary *)msg{
    
    NSLog(@"msg = %@", msg ) ;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gift" object:@""];
    titleColor = @"2";
    NSString *haohualiwuss =  [NSString stringWithFormat:@"%@",[msg valueForKey:@"evensend"]];
    NSDictionary *ct = [msg valueForKey:@"ct"];
    NSDictionary *GiftInfo = @{@"uid":[msg valueForKey:@"uid"],
                               @"nicename":[msg valueForKey:@"uname"],
                               @"giftname":[ct valueForKey:@"giftname"],
                               @"gifticon":[ct valueForKey:@"gifticon"],
                               @"giftcount":[ct valueForKey:@"giftcount"],
                               @"giftid":[ct valueForKey:@"giftid"],
                               @"level":[msg valueForKey:@"level"],
                               @"avatar":[msg valueForKey:@"uhead"],
                               @"type":[ct valueForKey:@"type"],
                               @"swf":minstr([ct valueForKey:@"swf"]),
                               @"swftime":minstr([ct valueForKey:@"swftime"]),
                               @"swftype":minstr([ct valueForKey:@"swftype"]),
                               @"isluck":minstr([ct valueForKey:@"isluck"]),
                               @"lucktimes":minstr([ct valueForKey:@"lucktimes"]),
                               @"mark":minstr([ct valueForKey:@"mark"])

                               };
    
//    _voteNums = minstr([ct valueForKey:@"votestotal"]);
//    [self changeState];
    
    if (  [[ct valueForKey:@"type"] isEqual:@"1"]) {
        [self expensiveGift:GiftInfo];
    }else{
        if (!continueGifts) {
            continueGifts = [[continueGift alloc]init];
            [liansongliwubottomview addSubview:continueGifts];
            //初始化礼物空位
            [continueGifts initGift];
        }
   
        [continueGifts GiftPopView:GiftInfo andLianSong:haohualiwuss];
    }
//聊天区域显示送礼物去除
    NSString *ctt = [NSString stringWithFormat:@"送了%@个%@", [ct valueForKey:@"giftcount"] ,[ct valueForKey:@"giftname"]];
    NSString* uname = [msg valueForKey:@"uname"];
    NSString *levell = [msg valueForKey:@"level"];
    NSString *ID = [msg valueForKey:@"uid"];
    NSString *avatar = [msg valueForKey:@"uhead"];
    NSString *vip_type =minstr([msg valueForKey:@"vip_type"]);
    NSString *liangname =minstr([msg valueForKey:@"liangname"]);

    NSDictionary *chat6 = [NSDictionary dictionaryWithObjectsAndKeys:uname,@"userName",ctt,@"contentChat",levell,@"levelI",ID,@"id",titleColor,@"titleColor",avatar,@"avatar",vip_type,@"vip_type",liangname,@"liangname",nil];
    [msgList addObject:chat6];
    titleColor = @"0";
    if(msgList.count>30)
    {
        [msgList removeObjectAtIndex:0];
    }
    [self.tableView reloadData];
    [self jumpLast:self.tableView];
}

@end

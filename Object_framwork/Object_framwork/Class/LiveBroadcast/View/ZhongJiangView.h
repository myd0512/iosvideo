//
//  ZhongJiangView.h
//  Object_framwork
//
//  Created by mac on 2020/6/6.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhongJiangView : UIView

@property(nonatomic,strong)NSShadow *shadow;//
@property(nonatomic,strong)NSString *haohualiwus;//判断是不是连送
@property(nonatomic,strong)UIButton *imageVs;
@property(nonatomic,strong)UIButton *imageView;
@property(nonatomic,assign)CGFloat newheight;
@property(nonatomic,strong)NSNumber *previousGiftID2;//礼物上次id 2
@property(nonatomic,strong)NSNumber *previousGiftID1;//礼物上次id 1 用于判断是否是连送礼物
@property(nonatomic,assign)int popShowTime2;//礼物下显示时间
@property(nonatomic,assign)int popShowTime1;//礼物上显示时间
@property(nonatomic,assign)int popListItem2;
@property(nonatomic,assign)int popListItem1;
@property(nonatomic,assign)int GiftPosition;//标记礼物位置 0 全无 1上有，2下有，3全有；
@property(nonatomic,strong)NSMutableArray *GiftqueueArray;
@property(nonatomic,strong)NSTimer *GiftqueueTIME;

-(void)GiftPopView:(NSDictionary *)giftData ;

-(void)initGift;//初始化礼物

-(void)stopTimerAndArray;


@end

NS_ASSUME_NONNULL_END

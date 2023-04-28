//
//  ZhongJiangView.m
//  Object_framwork
//
//  Created by mac on 2020/6/6.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "ZhongJiangView.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "CFGradientLabel.h"

@implementation ZhongJiangView

-(void)GiftPopView:(NSDictionary *)giftData
{
    
    _newheight = 5 ;
    
 
    /*
     UIView * jjView = [QuickCreatUI creatUIViewWithSuperView:frontView andFrame:CGRectMake(WIDTH, RewardView.top - 50, WIDTH *3/5, 40) color:kClearColor];
     
     jjView.layer.contents = (id)[UIImage imageNamed:@"bg_bonus.9"].CGImage ;
     jjView.contentMode = UIViewContentModeScaleAspectFill ;
     
     UILabel * label = [QuickCreatUI creatUILabelWithSuperView:jjView andFrame:CGRectMake(10, 0, jjView.width - 20, 40) andText:[NSString stringWithFormat:@"%@中奖,奖金%@" ,name , money ] andStringColor:kWhiteColor andFont:13];
     
     [jjView viewCornersWith:5.0];
     
     */
    int giftid = [[giftData valueForKey:@"userid"] intValue];
    NSString *money  = [giftData valueForKey:@"money"];
    NSString *name  = [giftData valueForKey:@"name"];
    NSString *content   = [NSString stringWithFormat:@"%@中奖,奖金%@" ,name , money ];

    UIView * GiftPopView = [[UIView alloc] init];//礼物
    CFGradientLabel *labGiftNum = [[CFGradientLabel alloc] init];//礼物数量
    int tagID = giftid;
    labGiftNum.tag = giftid;
    int height = 20;
    int width = self.width;
    int x = 5;
    int flag = 0;
        if (_popListItem1!=0) {
            if (_popListItem1 == tagID && _previousGiftID1 == [giftData valueForKey:@"userid"]) {
                _popShowTime1=3;
                [self GiftNumAdd:tagID];
                flag = 1;
            }
            else if(_popListItem1 == tagID  && _previousGiftID1 != [giftData valueForKey:@"userid"])
            {
                [_GiftqueueArray addObject:giftData];
                [self startGiftTimer];
                flag = 1;
                
            }
        }
        if (_popListItem2!=0) {
            if (_popListItem2 == tagID  && _previousGiftID2 == [giftData valueForKey:@"userid"]) {
                _popShowTime2 = 3;
                [self GiftNumAdd:tagID];
                flag = 1;
            }
            else  if(_popListItem2 == tagID  && _previousGiftID1 != [giftData valueForKey:@"userid"])
            {
                //如果换了礼物则替换礼物
                [_GiftqueueArray addObject:giftData];
                [self startGiftTimer];
                flag = 1;
            }
    }
    if (flag == 1) {
        
        return;
    }
    int y = 0;
    if (_GiftPosition ==0) {//全空显示在第一
        y = _newheight;
        _GiftPosition = 1;
        _popListItem1 = (int)labGiftNum.tag;
        _previousGiftID1 = [giftData valueForKey:@"userid"];
        
        
    }
    else if(_GiftPosition ==1)//一位有显示在二
    {
        y = _newheight+height+5;
        _GiftPosition = 3;
        _popListItem2 = (int)labGiftNum.tag;
        _previousGiftID2 = [giftData valueForKey:@"userid"];
        
    }
    else if (_GiftPosition == 2)//二为有显示在一
    {
        y = _newheight;
        _GiftPosition = 3;
        _popListItem1 = (int)labGiftNum.tag;
        _previousGiftID1 = [giftData valueForKey:@"userid"];
        
    }
    else                       //全有执行队列
    {
        y = 0;
    }
    if(y==0)//当前位置已满，启动队列
    {
        [_GiftqueueArray addObject:giftData];
        [self startGiftTimer];
        return;
    }
    [self addSubview:GiftPopView];

    [GiftPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(x);
        make.top.equalTo(self).offset(y);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
   
    GiftPopView.backgroundColor = [UIColor clearColor];
    
    
    //pop背景图
    UIImageView *giftBGView = [[UIImageView alloc] init];
    giftBGView.image = [UIImage imageNamed:@"bg_family_name.9"];
    giftBGView.contentMode = UIViewContentModeScaleToFill;
    [GiftPopView addSubview:giftBGView];
    [giftBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(GiftPopView);
        make.top.equalTo(GiftPopView);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width - 50);
    }];
    
    
    //礼物名称
    UILabel *labName = [[UILabel alloc] init];
    labName.text = content;
    labName.font = [UIFont systemFontOfSize:14];
    
    labName.textColor = kWhiteColor;
    [giftBGView addSubview:labName];
    [labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(giftBGView);
        make.height.equalTo(giftBGView.mas_height);
        make.width.equalTo(giftBGView.mas_width).offset(-20);
    }];

    UILabel *numL = [[UILabel alloc]init];
    numL.font = [UIFont boldSystemFontOfSize:15];
    numL.textColor = [UIColor whiteColor];
    [giftBGView addSubview:numL];
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(labName.mas_right).offset(8);
        make.top.equalTo(giftBGView);
        make.height.equalTo(giftBGView.mas_height);
    }];
    
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-8 * (CGFloat)M_PI / 180), 1, 0, 0);
    CFGradientLabel *giftXL = [[CFGradientLabel alloc] init];
    giftXL.outLinetextColor = kRedColor;
    giftXL.outLineWidth  = 1.5;
    giftXL.font = [UIFont boldSystemFontOfSize:15];
    giftXL.labelTextColor = kRedColor;
    giftXL.transform = matrix;
    [giftBGView addSubview:giftXL];
    [giftXL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numL.mas_left).offset(10);
        make.centerY.equalTo(giftBGView);
//        make.height.mas_equalTo(20);
    }];
    numL.text = @"";
    giftXL.text = @"X";
    //礼物数量
    labGiftNum.outLinetextColor = RGB_COLOR(@"#bd6d26", 1);
    labGiftNum.outLineWidth  = 2;
    labGiftNum.text = @"1";
//    labGiftNum.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:40];
    labGiftNum.font = [UIFont boldSystemFontOfSize:40];
    labGiftNum.labelTextColor = normalColors;
//    labGiftNum.colors = @[(id)RGB_COLOR(@"#ffa800", 1).CGColor ,(id)RGB_COLOR(@"#ffe400", 1).CGColor];
    labGiftNum.transform = matrix;
    [giftBGView addSubview:labGiftNum];
    [labGiftNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(giftXL.mas_right).offset(8);
        make.centerY.equalTo(giftBGView.mas_centerY);
    }];
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.2 animations:^{

        [GiftPopView layoutIfNeeded];
        [self layoutIfNeeded];

    } completion:^(BOOL finished) {

    }];

    if(_GiftPosition == 1)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(hideGiftPop1:) withObject:GiftPopView  waitUntilDone:NO];
        });
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(hideGiftPop2:) withObject:GiftPopView  waitUntilDone:NO];
        });
    }
}
-(void)startGiftTimer
{
    if (_GiftqueueTIME==nil) {
        _GiftqueueTIME = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(EnGiftqueue) userInfo:nil repeats:YES];
    }
}
-(int)returnGiftPos:(int)height
{
    int y = 0;
    if (_GiftPosition ==0) {//全空显示在第一
        y = _newheight;
        _GiftPosition = 1;
    }
    else if(_GiftPosition ==1)//一位有显示在二
    {
        y = _newheight+height+5;
        _GiftPosition = 3;
    }
    else if (_GiftPosition == 2)//二为有显示在一
    {
        y = _newheight;
        _GiftPosition = 3;
    }
    else                       //全有执行队列
    {
        y = 0;
    }
    
    return y;
}
-(void)hideGiftPop2:(UIView *)agr
{
    UIView *GiftPopView = agr;
    int height = _window_height/15;
    int width = _window_width/2;
    
    
    if (_popListItem2 != 0) {
        //判断显示时间 如果显示时间大于0则继续递归 否则 让其消失
        
        if (_popShowTime2 >0) {
            _popShowTime2 -= 0.5;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                
                [self performSelectorOnMainThread:@selector(hideGiftPop2:) withObject:GiftPopView  waitUntilDone:NO];
            });
        }
        else
        {
            [UIView animateWithDuration:0.8 animations:^{
                GiftPopView.frame =  CGRectMake(GiftPopView.frame.origin.x, GiftPopView.frame.origin.y, width, height);
                GiftPopView.alpha = 0;
                
                if (GiftPopView.frame.origin.y<= _newheight) {
                    //移除一级弹出
                    _popListItem1 = 0;
                    if(_GiftPosition == 3)
                        _GiftPosition = 2;//如果现在上下都有则设置成仅下有
                    else _GiftPosition = 0;                   //否则设置成全无
                }
                else
                {
                    _popListItem2 = 0;
                    //移除二级弹出
                    if(_GiftPosition == 3)   _GiftPosition = 1;//如果现在上下都有则设置成仅上有
                    else _GiftPosition = 0;                   //否则设置成全无
                }
            }];
            
            //0.8秒后删除视图
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                [self performSelectorOnMainThread:@selector(removeGiftPop:) withObject:GiftPopView  waitUntilDone:NO];
            });
        }
        return;
    }
    [UIView animateWithDuration:0.8 animations:^{
        GiftPopView.frame =  CGRectMake(GiftPopView.frame.origin.x, GiftPopView.frame.origin.y, width, height);
        GiftPopView.alpha = 0;
        
        if (GiftPopView.frame.origin.y<= _newheight) {
            //移除一级弹出
            _popListItem1 = 0;
            if(_GiftPosition == 3)
                _GiftPosition = 2;//如果现在上下都有则设置成仅下有
            else _GiftPosition = 0;                   //否则设置成全无
        }
        else
        {
            _popListItem2 = 0;
            //移除二级弹出
            if(_GiftPosition == 3)   _GiftPosition = 1;//如果现在上下都有则设置成仅上有
            else _GiftPosition = 0;                   //否则设置成全无
        }
    }];
    
    //0.8秒后删除视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [self performSelectorOnMainThread:@selector(removeGiftPop:) withObject:GiftPopView  waitUntilDone:NO];
    });
    
}
-(void)hideGiftPop1:(UIView *)agr
{
    
    UIView *GiftPopView = agr;
    int height = _window_height/15;
    int width = _window_width/2;
    
    if (_popListItem1 != 0) {
        //判断显示时间 如果显示时间大于0则继续递归 否则 让其消失
        
        if (_popShowTime1 >0) {
            _popShowTime1 -= 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                
                [self performSelectorOnMainThread:@selector(hideGiftPop1:) withObject:GiftPopView  waitUntilDone:NO];
            });
        }
        else
        {
            [UIView animateWithDuration:0.8 animations:^{
                GiftPopView.frame =  CGRectMake(GiftPopView.frame.origin.x, GiftPopView.frame.origin.y, width, height);
                GiftPopView.alpha = 0;
                
                if (GiftPopView.frame.origin.y<= _newheight) {
                    //移除一级弹出
                    _popListItem1 = 0;
                    if(_GiftPosition == 3)
                        _GiftPosition = 2;//如果现在上下都有则设置成仅下有
                    else _GiftPosition = 0;                   //否则设置成全无
                }
                else
                {
                    _popListItem2 = 0;
                    //移除二级弹出
                    if(_GiftPosition == 3)   _GiftPosition = 1;//如果现在上下都有则设置成仅上有
                    else _GiftPosition = 0;                   //否则设置成全无
                }
            }];
            //0.8秒后删除视图
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                [self performSelectorOnMainThread:@selector(removeGiftPop:) withObject:GiftPopView  waitUntilDone:NO];
            });
        }
        return;
    }
    
    [UIView animateWithDuration:0.8 animations:^{
        GiftPopView.frame =  CGRectMake(GiftPopView.frame.origin.x, GiftPopView.frame.origin.y, width, height);
        GiftPopView.alpha = 0;
        
        if (GiftPopView.frame.origin.y<= _newheight) {
            //移除一级弹出
            _popListItem1 = 0;
            if(_GiftPosition == 3)
                _GiftPosition = 2;//如果现在上下都有则设置成仅下有
            else _GiftPosition = 0;                   //否则设置成全无
        }
        else
        {
            _popListItem2 = 0;
            //移除二级弹出
            if(_GiftPosition == 3)   _GiftPosition = 1;//如果现在上下都有则设置成仅上有
            else _GiftPosition = 0;                   //否则设置成全无
        }
    }];
    
    //0.8秒后删除视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [self performSelectorOnMainThread:@selector(removeGiftPop:) withObject:GiftPopView  waitUntilDone:NO];
    });
    
    
}
-(void)removeGiftPop:(UIView *)viewa
{
    [viewa removeFromSuperview];
    viewa=nil;
    NSLog(@"礼物送完了");
}
//礼物队列
-(void)EnGiftqueue
{
    NSLog(@"当前队列个数:%lu",(unsigned long)_GiftqueueArray.count);
    if (_GiftqueueArray.count == 0 || _GiftqueueArray == nil) {//判断队列中有item且不是满屏
        [_GiftqueueTIME invalidate];
        _GiftqueueTIME = nil;
        return;
    }
    NSDictionary *Dic = [_GiftqueueArray firstObject];
    [_GiftqueueArray removeObjectAtIndex:0];
    [self GiftPopView:Dic];
}
//添加礼物数量
-(void)GiftNumAdd:(int)tag
{
    __weak CFGradientLabel *labGiftNum = (CFGradientLabel *)[self viewWithTag:tag];
//    __weak UIImageView *giftIcon = [self viewWithTag:tag-40000];

    int oldnum = [labGiftNum.text intValue];
    int newnum = oldnum +1;
    labGiftNum.text = [NSString stringWithFormat:@"%d",newnum];
    if(labGiftNum == nil)
    {
        return;
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:1.5];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:0.8];     //结束伸缩倍数
    
    [labGiftNum.layer addAnimation:animation forKey:nil];
}
-(void)stopTimerAndArray{
    _GiftqueueArray = nil;
    _GiftqueueArray = [NSMutableArray array];
    [_GiftqueueTIME invalidate];
    _GiftqueueTIME = nil;
}
-(void)initGift{
    _GiftPosition = 0;
    _popListItem1 = 0;
    _popListItem2 = 0;
    _previousGiftID1 = 0;
    _previousGiftID1 = 0;
    _GiftqueueArray = [[NSMutableArray alloc] init];
}
@end

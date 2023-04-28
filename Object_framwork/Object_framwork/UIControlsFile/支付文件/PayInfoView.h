//
//  PayInfoView.h
//  Object_framwork
//
//  Created by 高通 on 2019/8/16.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol PayInfoViewDelegate <NSObject>

-(void)clickSureBtnWithCode:(NSString * )code andType:(NSInteger)type ;

@end

@interface PayInfoView : UIView

@property( strong , nonatomic ) NSString * money ; // 钱

@property( weak , nonatomic ) id<PayInfoViewDelegate> delegate ;

-(void)show ;

@property(nonatomic,strong)UIView * yuEView; //余额支付View 

@end

NS_ASSUME_NONNULL_END

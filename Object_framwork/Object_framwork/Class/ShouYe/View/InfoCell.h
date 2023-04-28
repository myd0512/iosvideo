//
//  InfoCell.h
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoCell : UITableViewCell

@property(strong , nonatomic) UILabel * titleLabel ;
@property(strong , nonatomic) UILabel * timeLabel ;
@property(strong , nonatomic) UILabel * moneyLabel ;

@end

NS_ASSUME_NONNULL_END

//
//  RankingListCell.h
//  Object_framwork
//
//  Created by apple on 2020/4/21.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingListModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface RankingListCell : UITableViewCell

@property(strong , nonatomic) UILabel * numLabel ;
@property(strong , nonatomic) UILabel * nameLabel ;
@property(strong , nonatomic) UILabel * scroeLabel ;
@property(strong , nonatomic) UILabel * liwuLabel ;
@property(strong , nonatomic) UIImageView * iconImg ;

@property(strong , nonatomic) RankingListModel * model ; // 排行榜列表数据

-(void)clearDara;

@end

NS_ASSUME_NONNULL_END

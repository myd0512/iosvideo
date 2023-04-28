//
//  GameHorsirInfoCell.h
//  Object_framwork
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameHorsirInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *qiNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *resultView;

-(void)setDictInfo:(NSDictionary *)mapInfo ;

@end

NS_ASSUME_NONNULL_END

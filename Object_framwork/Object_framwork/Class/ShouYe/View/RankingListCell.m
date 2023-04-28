//
//  RankingListCell.m
//  Object_framwork
//
//  Created by apple on 2020/4/21.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "RankingListCell.h"



@implementation RankingListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self laySubViews];
    }
    return self;
}

/*
 * 布局 - 子控件
 */
-(void)laySubViews{
    
    self.numLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 40, 50) andText:@"1" andStringColor:oneBlaceFont andFont:14];
    self.numLabel.textAlignment = NSTextAlignmentCenter ;
    
    self.iconImg = [QuickCreatUI creatUIImageViewWithSuperView:self.contentView andFrame:CGRectMake(self.numLabel.right, 0, 30, 30) andImg:@"default_head"] ;
    self.iconImg.centerY = 25 ;
    
    self.nameLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(self.iconImg.right + 10, 8, WIDTH - 2*lrPad - self.iconImg.right - 10 , 20) andText:@"虚位以待" andStringColor:oneBlaceFont andFont:13];
     self.scroeLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(self.iconImg.right + 10, 0, 25 , 12) andText:@"0" andStringColor:kWhiteColor andFont:10];
    self.scroeLabel.backgroundColor = kGrayColor;
    self.scroeLabel.textAlignment = NSTextAlignmentCenter ;
    self.scroeLabel.centerY = 35.5 ;
    [self.scroeLabel viewCornersWith:self.scroeLabel.height / 2];
    
    UIImageView * iconLiwu = [QuickCreatUI creatUIImageViewWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 15  , 15) andImg:@"rank_gift"];
    iconLiwu.right = WIDTH - 3*lrPad ;
    iconLiwu.centerY = 15.5 ;
    
    self.liwuLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(0, 0, WIDTH/2 , 20) andText:@"1" andStringColor:oneBlaceFont andFont:12];
    self.liwuLabel.textAlignment = NSTextAlignmentRight ;
    self.liwuLabel.text = @"0.00";
    self.liwuLabel.right = WIDTH - 3*lrPad ;
    self.liwuLabel.bottom = 43;
    
    [QuickCreatUI creatUIViewWithSuperView:self.contentView andFrame:CGRectMake(40, 49, WIDTH - 2*lrPad, 1) color:lineGray];
}


-(void)setModel:(RankingListModel *)model{
    _model = model ;
        
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] ];
    self.nameLabel.text = model.user_nicename ;
    self.liwuLabel.text = model.totalcoin ;
    self.scroeLabel.text = model.level_anchor ;
    
}


-(void)clearDara{
    self.iconImg.image = [UIImage imageNamed:@"default_head"];
    self.nameLabel.text = @"虚位以待" ;
    self.scroeLabel.text =@"0" ;
    self.liwuLabel.text = @"0.00" ;
    
}


@end

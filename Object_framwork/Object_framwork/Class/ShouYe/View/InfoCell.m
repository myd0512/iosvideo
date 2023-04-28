//
//  InfoCell.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self laySubViews];
    }
    return self;
}


-(void)laySubViews{
    
    self.contentView.backgroundColor = kWhiteColor ;
    self.titleLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 20) andText:@"金额类型" andStringColor:oneBlaceFont andFont:15];
    
    self.timeLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 20) andText:@"时间" andStringColor:twoBlaceFont andFont:13];
    
    self.moneyLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 20) andText:@"" andStringColor:kRedColor andFont:15];
    self.moneyLabel.textAlignment = NSTextAlignmentRight ;
    
    self.moneyLabel.attributedText = [NSString getmoneyString:@"¥ 0.03" andColor:kRedColor andFontSize:15];
    
    [QuickCreatUI creatUIViewWithSuperView:self.contentView andFrame:CGRectMake(lrPad, 59, WIDTH - lrPad, 1) color:lineGray ];
}

-(void)layoutSubviews{
    self.moneyLabel.centerY = self.contentView.centerY ;
    self.titleLabel.bottom = self.contentView.centerY -2 ;
    self.timeLabel.top = self.contentView.centerY +2 ;
}








@end

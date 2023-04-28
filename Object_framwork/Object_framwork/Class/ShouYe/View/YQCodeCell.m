//
//  YQCodeCell.m
//  Object_framwork
//
//  Created by apple on 2020/4/21.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "YQCodeCell.h"
@interface YQCodeCell ()

@property(strong , nonatomic) UIImageView * imgView ;
@property(strong , nonatomic) UILabel * nameLabel ;
@property(strong , nonatomic) UILabel * phoneLabel ;

@property(strong , nonatomic) UILabel * memberNumLabel ;
@property(strong , nonatomic) UILabel * fandianLabel ;

@end

@implementation YQCodeCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self laySubViews];
    }
    return self;
}


-(void)laySubViews{
    
    self.imgView = [ QuickCreatUI creatUIImageViewWithSuperView:self.contentView andFrame:CGRectMake(lrPad, 0, 40, 40) andImg:@"banner"] ;
    [self.imgView viewCornersWith:20];
    self.imgView.centerY = 30 ;
    
    self.nameLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(self.imgView.right+10, 0, WIDTH - self.imgView.right - 10 - 100 , 20) andText:@"名称那个" andStringColor:oneBlaceFont andFont:14];
    self.phoneLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(self.imgView.right+10, 0, WIDTH - self.imgView.right - 10 - 100 , 20) andText:@"13937195344" andStringColor:threeBlaceFont andFont:13];
    self.nameLabel.top = self.imgView.top   ;
    self.phoneLabel.bottom = self.imgView.bottom  ;
    
    UIImageView * iconImg = [ QuickCreatUI creatUIImageViewWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 8, 12) andImg:@"tuikuan_gengduo"];
    iconImg.centerY = 30 ;
    iconImg.right = WIDTH - lrPad ;
    
    
    // 返点率
    self.fandianLabel = [ QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 60, 20) andText:@"9.0%" andStringColor:kRedColor andFont:13];
    self.fandianLabel.right = iconImg.left - 10 ;
    self.fandianLabel.top = self.nameLabel.top ;
    self.fandianLabel.textAlignment = NSTextAlignmentCenter ;
    
    
    UILabel * label = [ QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 60, 20) andText:@"返点率" andStringColor:threeBlaceFont andFont:12];
    label.left = self.fandianLabel.left ;
    label.bottom = self.phoneLabel.bottom ;
    label.textAlignment = NSTextAlignmentCenter ;
    
    
    UIView * lineView = [QuickCreatUI creatUIViewWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 1, 30) color:lineGray] ;
    lineView.right = self.fandianLabel.left ;
    lineView.centerY = 30 ;
    
    
    // 团队人数
    self.memberNumLabel = [ QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 60, 20) andText:@"12" andStringColor:kRedColor andFont:13];
    self.memberNumLabel.right = lineView.left - 10 ;
    self.memberNumLabel.top = self.nameLabel.top ;
    self.memberNumLabel.textAlignment = NSTextAlignmentCenter ;


    UILabel * label1 = [ QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 60, 20) andText:@"已邀请数" andStringColor:threeBlaceFont andFont:12];
    label1.left = self.memberNumLabel.left ;
    label1.bottom = self.phoneLabel.bottom ;
    label1.textAlignment = NSTextAlignmentCenter ;

    UIView * lineView1 = [QuickCreatUI creatUIViewWithSuperView:self.contentView andFrame:CGRectMake(0, 0, 1, 30) color:lineGray] ;
    lineView1.right = self.memberNumLabel.left - 10 ;
    lineView1.centerY = 30 ;
    
    [QuickCreatUI creatUIViewWithSuperView:self.contentView andFrame:CGRectMake(0, 59, WIDTH, 1) color:lineGray ];
    
}



@end

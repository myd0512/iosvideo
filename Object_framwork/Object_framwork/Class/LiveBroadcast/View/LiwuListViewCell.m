//
//  LiwuListViewCell.m
//  Object_framwork
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "LiwuListViewCell.h"

@implementation LiwuListViewCell{
    NSMutableArray * labelArr ;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self laySubViews];
    }
    return self;
}


-(void)laySubViews{
    labelArr  = @[].mutableCopy ;
    
    NSArray *titleArr = @[ @"--",@"--",@"--",@"--",@"--"] ;
    
    double x = 0 ;
    
    for ( int i = 0 ; i < titleArr.count ; i++ ) {
        
        double w = 0 ;
        if (i == 0||i == 1) {
            
            w  = 0.25 * WIDTH ;
        }else{
            
            w  = WIDTH * 1/6 ;
        }
        
        UILabel * label = [ QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake( x , 0, w, 35) andText:titleArr[i] andStringColor:kWhiteColor andFont:13];
        label.textAlignment = NSTextAlignmentCenter ;
        x += w;
        [labelArr addObject:label];
    }
    [self.contentView viewCornersWith:17.5];
    self.contentView.backgroundColor = RGB(27, 27, 36);
    self.backgroundColor = kBlackColor;
}

-(void)setModel:(LiWuListViewModel *)model{
    _model = model ;
    
    NSArray * arr = @[ [FWUtils dateToString:model.addtime] , [NSString stringWithFormat:@"%@",model.user_nicename] , [NSString stringWithFormat:@"%@",model.gift_name] , [NSString stringWithFormat:@"%@",model.giftcount] , [NSString stringWithFormat:@"%.2f",[model.totalcoin doubleValue]] ] ;
    
    for (int i = 0; i < arr.count; i++) {
        
        UILabel * numLabel = labelArr[i];
        numLabel.text = arr[i] ;
        if (i == 0) {
            
            numLabel.text = [NSString ConvertStrToTime:arr[i]];
        }
    }
}

@end

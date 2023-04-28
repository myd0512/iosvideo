//
//  GameHorsirInfoCell.m
//  Object_framwork
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "GameHorsirInfoCell.h"

@implementation GameHorsirInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backView.backgroundColor = RGB(27, 27, 36) ;
    [self.backView viewCornersWith:17.5];
    self.contentView.backgroundColor = kBlackColor ;
    self.resultView.backgroundColor = RGB(27, 27, 36) ;
}


-(void)setDictInfo:(NSDictionary *)mapInfo {
    
    self.nameLabel.text = [UserInfoManaget sharedInstance].gameInfoModel.gameName ;
    self.qiNumLabel.text = [NSString stringWithFormat:@"第%@期",mapInfo[@"id"]];
//    self.resultLabel.text = mapInfo[@"result"] ;
    if (self.resultView.subviews) {
        
        for (UIView * sub in self.resultView.subviews) {
            [sub removeFromSuperview];
        }
    }
    
    NSArray * titleArr = [ mapInfo[@"result"]  componentsSeparatedByString:@"," ] ;
    
    
       if ([UserInfoManaget sharedInstance].gameInfoModel.gameID == 7 ) { //农场
           
           double itemW = ((WIDTH - 20)*3/7 /titleArr.count) >=  14 ? 14 : ((WIDTH - 20)*3/7 /titleArr.count) ;
           double itemh = itemW ;
           double x = 5 ;
           for (int i = 0; i < titleArr.count; i++) {
               
               UIImageView * image = [QuickCreatUI creatUIImageViewWithSuperView:self.resultView andFrame:CGRectMake(x, 0, itemW, itemh) andImg:[NSString stringWithFormat:@"cqxync%02d",[titleArr[i]  intValue]]];
               image.centerY = 17.5 ;
               x += (itemW + 2);
           }
       }else if ([UserInfoManaget sharedInstance].gameInfoModel.gameID == 1){ // 一分快三
           double itemW = 20 ;
                 double itemh = 20 ;
                 double x = 25 ;
                 for (int i = 0; i < titleArr.count; i++) {
                     
                     UIImageView * image = [QuickCreatUI creatUIImageViewWithSuperView:self.resultView  andFrame:CGRectMake(x, 0, itemW, itemh) andImg:[NSString stringWithFormat:@"kuaisan_bg%02d",[titleArr[i]  intValue]]];
                     image.centerY = 17.5 ;
                     x += (itemW + 5);
                 }
           
       }else if ([UserInfoManaget sharedInstance].gameInfoModel.gameID == 5){ // 一分六合彩
           
           NSMutableArray * ar = titleArr.mutableCopy;
           [ar insertObject:@"+" atIndex:ar.count - 1] ;
           double itemW =  ((WIDTH - 20)*3/7 /titleArr.count) >= 15 ? 15 : ((WIDTH - 20)*3/7 /titleArr.count) - 2 ;
           double itemh = itemW ;
           double x = 2 ;
           NSArray * redArr = @[@"1",@"2",@"7",@"8",@"12",@"13",@"18",@"19",@"23",@"24",@"29",@"30",@"34",@"35",@"40",@"45",@"46"] ;
           
           NSArray * blueArr = @[@"3",@"4",@"9",@"10",@"14",@"15",@"20",@"25",@"26",@"31",@"36",@"37",@"41",@"42",@"47",@"48"] ;
           
           NSArray * greenArr = @[@"5",@"6",@"11",@"16",@"17",@"21",@"22",@"27",@"28",@"32",@"33",@"38",@"39",@"43",@"44",@"49"] ;
           
           for (int i = 0; i < ar.count; i++) {
                     
               UILabel * label = [QuickCreatUI creatUILabelWithSuperView:self.resultView  andFrame:CGRectMake(x, 0, itemW, itemh) andText:ar[i] andStringColor:kWhiteColor andFont:8];
               [label viewCornersWith:itemW/2];
               label.textAlignment = NSTextAlignmentCenter ;
               if (i != ar.count - 2) {
                   if ([redArr containsObject:ar[i]]) {
                       label.backgroundColor = changColors;
                   }else if ([blueArr containsObject:ar[i]]){
                       label.backgroundColor = RGB(77, 172, 192);
                   }else if ([greenArr containsObject:ar[i]]){
                       label.backgroundColor = RGB(160, 198, 117);
                   }
               }
               label.centerY = 17.5 ;
               x += (itemW + 2);
           }
           
       }else if([UserInfoManaget sharedInstance].gameInfoModel.gameID == 3){  // 数字显示
           
           double itemW = ((WIDTH - 20)*3/7 /titleArr.count)  - 2 ;
           double itemh = itemW ;
           double x = 2 ;
           for (int i = 0; i < titleArr.count; i++) {
                     
               UILabel * label = [QuickCreatUI creatUILabelWithSuperView:self.resultView  andFrame:CGRectMake(x, 0, itemW, itemh) andText:titleArr[i] andStringColor:kWhiteColor andFont:8];
               [label viewCornersWith:itemW/2];
               label.textAlignment = NSTextAlignmentCenter ;
               if ([label.text isEqualToString:@"1"]) {
                   label.backgroundColor = RGB(228, 218, 80);
               }
               if ([label.text isEqualToString:@"2"]) {
                   label.backgroundColor = RGB(69, 149, 213);
               }
               if ([label.text isEqualToString:@"3"]) {
                   label.backgroundColor = RGB(75, 75, 75);
               }
               if ([label.text isEqualToString:@"4"]) {
                   label.backgroundColor = RGB(238, 114, 47);
               }
               if ([label.text isEqualToString:@"5"]) {
                   label.backgroundColor = RGB(112, 223, 225);
               }
               if ([label.text isEqualToString:@"6"]) {
                   label.backgroundColor = RGB(76, 79, 236);
               }
               if ([label.text isEqualToString:@"7"]) {
                   label.backgroundColor = RGB(191, 191, 191);
               }
               if ([label.text isEqualToString:@"8"]) {
                   label.backgroundColor = RGB(216, 52, 33);
               }
               if ([label.text isEqualToString:@"9"]) {
                   label.backgroundColor = RGB(107, 15, 11);
               }
               if ([label.text isEqualToString:@"10"]) {
                   label.backgroundColor = RGB(112, 223, 225);
               }
               label.centerY = 17.5 ;
               x += (itemW + 2);
           }
       }else{
           
           double itemW = ((WIDTH - 20)*3/7 /titleArr.count) >= 15 ? 15 : ((WIDTH - 20)*3/7 /titleArr.count) - 2 ;
            double itemh = itemW ;
            double x = 2 ;
            for (int i = 0; i < titleArr.count; i++) {
                              
                        UILabel * label = [QuickCreatUI creatUILabelWithSuperView:self.resultView  andFrame:CGRectMake(x, 0, itemW, itemh) andText:titleArr[i] andStringColor:kWhiteColor andFont:8];
                        [label viewCornersWith:itemW/2];
                        label.textAlignment = NSTextAlignmentCenter ;
                        label.backgroundColor = [FWUtils getRandomColor] ;
                        label.centerY = 17.5 ;
                        x += (itemW + 2);
                    }
       }
}


@end

//
//  LiveHistoryCell.m
//  Object_framwork
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "LiveHistoryCell.h"

@interface LiveHistoryCell()



@end

@implementation LiveHistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"初始化") ;
        
        [self initSubviews] ;
    }
    return self;
}

// 初始化
-(void)initSubviews{
    
    self.dataTimeLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake( lrPad, 0, WIDTH - 2*lrPad, self.contentView.height) andText:@"日期" andStringColor:twoBlaceFont andFont:14];
    
    self.longTimeLabel = [QuickCreatUI creatUILabelWithSuperView:self.contentView andFrame:CGRectMake( lrPad, 0, WIDTH- 2*lrPad, self.contentView.height) andText:@"直播时间" andStringColor:oneBlaceFont andFont:14];
    self.longTimeLabel.textAlignment = NSTextAlignmentRight ;
    
    
    [QuickCreatUI creatUIViewWithSuperView:self.contentView andFrame:CGRectMake(0, self.contentView.height - 1, WIDTH, 1 ) color:MainGray];
    
}

@end

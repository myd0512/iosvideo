#import "listCell.h"
#import "listModel.h"
#import "SDWebImage/UIButton+WebCache.h"
//#import "UIImageView+WebCache.h"
@implementation listCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,30,30)];
        _imageV.layer.masksToBounds = YES;
        _imageV.layer.cornerRadius = 15;
        _imageV.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.7].CGColor ;
        _imageV.layer.borderWidth = 1.5 ;
//        _imageV.layer.borderWidth = 1;
//        _imageV.layer.borderColor = normalColors.CGColor;
//        _imageV.center = self.contentView.center;
        [self.contentView addSubview:_imageV];
//        _kuang = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,40,40)];
//        _kuang.center = self.contentView.center;
//        [self.contentView addSubview:_kuang];
//
//        _levelimage = [[UIImageView alloc]initWithFrame:CGRectMake(23,27,13,13)];
//        _levelimage.layer.masksToBounds = YES;
//        _levelimage.layer.cornerRadius = 6.5;
//        _levelimage.contentMode = UIViewContentModeScaleAspectFit;
//        [self addSubview:_levelimage];
    }
    return self;
}
-(void)setModel:(listModel *)model{
    _model = model;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_model.iconName] placeholderImage:[UIImage imageNamed:@"defultAll.png"]];
//    if ([_model.guard_type isEqual:@"0"]) {
//        NSDictionary *levelDic = [common getUserLevelMessage:_model.level];
//        [_levelimage sd_setImageWithURL:[NSURL URLWithString:minstr([levelDic valueForKey:@"thumb_mark"])]];
//    }else if ([_model.guard_type isEqual:@"1"]){
//        _levelimage.image = [UIImage imageNamed:@"chat_shou_month"];
//    }else if ([_model.guard_type isEqual:@"2"]){
//        _levelimage.image = [UIImage imageNamed:@"chat_shou_year"];
//    }
}
+(listCell *)collectionview:(UICollectionView *)collectionview andIndexpath:(NSIndexPath *)indexpath{
    listCell *cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"list" forIndexPath:indexpath];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"listCell" owner:self options:nil].lastObject;
    }
    return cell;
}
@end

//
//  gameselected.m
//  yunbaolive
//
//  Created by 王敏欣 on 2017/4/13.
//  Copyright © 2017年 cat. All rights reserved.
//
#import "gameselected.h"
#import "gamecell.h"
@interface gameselected ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *items;
    NSMutableArray *images;
    NSMutableArray *action;
    NSMutableArray *stype;
}
@end
@implementation gameselected
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setview];
    }
    return self;
}
-(void)setview{
    /**
     1.一分快三
     2.一分11选5
     3.一分赛车
     4.一分时时彩
     5.一分六合彩
     6.一分快乐十分
     7.一分幸运农场
     */
    items = [NSMutableArray array];
    images = [NSMutableArray array];
    action = [NSMutableArray array];
    
    stype = @[].mutableCopy ;
    [self getgameInfo];
    for (int i=1; i<8; i++) {
        
        switch (i) {
            case 1:
                [items addObject:@"一分快三"];
                [images addObject:@"oneFencai"];
                [action addObject:@"1"];
                break;
            case 2:
                [items addObject:@"一分11选5"];
                [images addObject:@"slectFive"];
                [action addObject:@"2"];
                break;
            case 3:
                [items addObject:@"一分赛车"];
                [images addObject:@"shiYifen"];
                [action addObject:@"3"];
                break;
            case 4:
                [items addObject:@"一分时时彩"];
                [images addObject:@"shishiCai"];
                [action addObject:@"4"];
                break;
            case 5:
                [items addObject:@"一分六合彩"];
                [images addObject:@"selctOne"];
                [action addObject:@"5"];
                break;
            case 6:
                [items addObject:@"一分快乐十分"];
                [images addObject:@"happyTime"];
                [action addObject:@"6"];
                
                break;
            case 7:
                [items addObject:@"一分幸运农场"];
                [images addObject:@"enjoeFamer"];
                [action addObject:@"7"];
                
                break;
            default:
                break;
        }
    }
    
    //1炸金花  2海盗  3转盘  4牛牛  5二八贝
//    items = @[YZMsg(@"智勇三张"),YZMsg(@"海盗船长"),YZMsg(@"幸运转盘"),@"开心牛仔",@"二八贝"];
//    images = @[@"game图标2",@"game图标3",@"game图标5",@"game图标1",@"game图标4"];
//    items = [NSMutableArray array];
//    images = [NSMutableArray array];
//    action = [NSMutableArray array];
    
//    for (int i=0; i<_ganearrays.count; i++) {
//
//        int a = [_ganearrays[i] intValue];
//
//        switch (a) {
//            case 1:
//                [items addObject:YZMsg(@"智勇三张")];
//                [images addObject:@"game图标2"];
//                [action addObject:@"1"];
//                break;
//            case 2:
//                [items addObject:YZMsg(@"海盗船长")];
//                [images addObject:@"game图标3"];
//                [action addObject:@"2"];
//                break;
//            case 3:
//                [items addObject:YZMsg(@"幸运转盘")];
//                [images addObject:@"game图标5"];
//                [action addObject:@"3"];
//                break;
//            case 4:
//                [items addObject:YZMsg(@"开心牛仔")];
//                [images addObject:@"game图标1"];
//                [action addObject:@"4"];
//                break;
//            case 5:
//                [items addObject:YZMsg(@"二八贝")];
//                [images addObject:@"game图标4"];
//                [action addObject:@"5"];
//                break;
//            default:
//                break;
//        }
//    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    if (self.ganearrays.count <=3) {
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0,HEIGHT - WIDTH/3 - 80,WIDTH,(WIDTH/3 + 80)) collectionViewLayout:layout];
    
//    }
//    else{
//    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0,HEIGHT - WIDTH/3*2 - 80,WIDTH,WIDTH/3*2 + 80) collectionViewLayout:layout];

//    }
    
    //    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    layout.itemSize = CGSizeMake((WIDTH-20)/3.5,(WIDTH-20)/4.5);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionview.dataSource = self;
    _collectionview.delegate = self;
    _collectionview.scrollsToTop = YES;
    _collectionview.showsHorizontalScrollIndicator = NO;
    UINib *nib = [UINib nibWithNibName:@"gamecell" bundle:nil];
    [_collectionview registerNib:nib forCellWithReuseIdentifier:@"gamecell"];
    _collectionview.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.8];
    [self addSubview:_collectionview];
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    
    UIView *hidevc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - WIDTH/3 - 80)];
    [hidevc addGestureRecognizer:taps];
    [self addSubview:hidevc];

}
-(void)hide{
    [self removeFromSuperview];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return items.count;
}

#pragma mark----------cell间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 80);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    gamecell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gamecell" forIndexPath:indexPath];
    cell.gameimage.image = [UIImage imageNamed:images[indexPath.row]];
    cell.gamelabel.text = items[indexPath.row];
    if ( stype.count != 0 && [stype[indexPath.row]  integerValue] == 0) {
        cell.gamelabel.textColor = kRedColor ;
    }
    return cell;
}
//-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *view = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//        view.backgroundColor = [UIColor whiteColor];
//        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
//        title.text = YZMsg(@"选择游戏");
//        title.textColor = [UIColor blackColor];
//        title.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:title];
//        UILabel *imagesssss = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH*0.05,40,WIDTH*0.9,1)];
//        imagesssss.backgroundColor = [UIColor grayColor];
//        [view addSubview:imagesssss];
//    }
//    return view;
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( [stype[indexPath.row]  integerValue] == 0) {
        [SVProgressHUD showErrorWithStatus:@"游戏暂未开放"];
        return;
    }
    
    //wxm
    NSInteger a = [action[indexPath.row] intValue];
    [self.delegate gameselect:a andImag:images[indexPath.row] andTitle:items[indexPath.row]];
    [self hide];
}


-(void)getgameInfo{
    
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:Get_game_start] params:@{@"uid":[UserInfoManaget sharedInstance].model.id} withHUD:NO success:^(id json) {
        
        NSArray * arr = json[@"data"][@"info"];
        
        for (NSDictionary *dic in arr) {
            
            [self->stype addObject:dic[@"ratio"]];
        }
        
        [self.collectionview reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}


@end

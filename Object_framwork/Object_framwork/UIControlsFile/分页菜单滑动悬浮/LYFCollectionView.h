//
//  LYFCollectionView.h
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWQMUIPageMenuVC;

typedef void(^LYFCollectionViewAction)(CGFloat proportion);

@interface LYFCollectionView : UICollectionView

/// 控制器
@property (nonatomic, strong) FWQMUIPageMenuVC *viewController;
/// 横向偏移比例
@property (nonatomic, copy) LYFCollectionViewAction scrollAction;

@end

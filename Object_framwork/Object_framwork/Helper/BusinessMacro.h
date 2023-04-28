//
//  BusinessMacro.h
//  ceshi
//
//  Created by 高通 on 2018/11/7.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//


/// 项目业务相关的一些宏定义

#ifndef BusinessMacro_h
#define BusinessMacro_h

typedef void (^DataBlock)( void ) ;
typedef void (^DataBlockWithIDData)( id data ) ;


// 默认 图 __ 设置
#define Banner_plahold_Image [UIImage imageNamed:@"banner_defile_Icon"]

//integer类型转字符串
#define IntAsString(number) [NSString stringWithFormat:@"%d",number]
//float转字符串
#define FloatAsString(float)   [NSString stringWithFormat:@"%2.f",float]



// 快速处理
// 格式化字符
#define StringFormat( a,... )   [NSString stringWithFormat:a, ##__VA_ARGS__]
// 获取图片
#define GET_IMAGE(imageName)    (imageName ? [UIImage imageNamed:imageName] : nil)
/// URL
#define  GET_URL(urlString)            [NSURL URLWithString:urlString]

// weak 弱引用
#define WeakSelf __weak typeof(self) weakSelf = self


#endif /* BusinessMacro_h */

//
//  ToolMacro.h
//  ceshi
//
//  Created by 高通 on 2018/11/7.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

// 工具宏
#ifndef ToolMacro_h
#define ToolMacro_h


// Integer转String
#define StringFromInteger(i)        [NSString stringWithFormat:@"%@",@(i)]
// Int转String
#define StringFromInt(i)            [NSString stringWithFormat:@"%@",@(i)]

// 角度与弧度转换
#define degreesToRadian(x)          (M_PI * (x) / 180.0)
#define radianToDegrees(x)          (180.0 * (x) / M_PI)

// 获取图片资源
#define kFWGetImage(imageName)      [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

// 在主线程上运行
#define kDispatchMainThread(mainQueueBlock)             dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// 开启异步线程
#define kDispatchGlobalQueueDefault(globalQueueBlock)   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);



#endif /* ToolMacro_h */

//
//  ImgHelp.h
//  Object_framwork
//
//  Created by apple on 2020/4/23.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImgHelp : NSObject

+ (UIImage *)tg_blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur  ;

@end

NS_ASSUME_NONNULL_END

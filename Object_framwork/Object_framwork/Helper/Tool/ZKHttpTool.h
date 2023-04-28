//
//  ZKHttpTool.h
//  butlerUsedCar
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 zhengkun. All rights reserved.
//


/**
 网络请求 类
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZKHttpTool : NSObject

+ (instancetype)shareInstance;//单例

- (void)get:(NSString *)url params:(NSDictionary *)params withHUD:(BOOL)HUD  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

- (void)post:(NSString *)url params:(NSDictionary *)params withHUD:(BOOL)HUD  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;




/**
 不带 - 加载提示
 */
- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


-(void)UpImgpost:(NSString *)url params:(UIImage *)image parameters:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure; //图片上传


@end

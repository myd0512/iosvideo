//
//  UIImage+Extension.h
//  zhengkun
//
//  Created by 郑坤 on 2017/6/7.
//  Copyright © 2017年 郑坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EXtension)

/**
 *  返回一张圆形图片
 *
 *  @param scaleLeft : 值范围0-1 左边不拉伸区域的宽度 占图片宽度的比
 *  @param scaleTop  : 值范围0-1 上面不拉伸的高度 占图片高度的比
 *
 *  注意: 默认从中间拉伸
 */
+ (UIImage*)circleImage:(UIImage*)image withInset:(CGFloat)inset;



/*--------  另外一个文件 ----*/
/**
 *  传入一张图片,缩放到指定大小
 *
 *  @param img  传入的图片
 *  @param size 指定缩放到的尺寸
 *
 *  @return 返回指定大小的图片
 */

+(UIImage *)image:(UIImage *)img scaleToSize:(CGSize)size;
/**
 *  传入一张图片,缩放到指定比例
 *
 *  @param img   需要缩放的图片
 *  @param scale 缩放的比例
 *
 *  @return 返回指定缩放比例的图片
 */
+(UIImage *)image:(UIImage *)img scale:(CGFloat)scale;


/**
 *  使用imge 作为另一个 imge的 遮罩 返回遮罩后的img
 *
 *  @param image
 *  @param maskImage
 *
 *  @return
 */
+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;


/**
 *  使用V转image
 *
 *  @param v
 *
 *
 *  @return
 */
+(UIImage*)convertViewToImage:(UIView*)v;




//通过颜色来生成一个纯色图片
+(UIImage *)imageFromColor:(UIColor *)color inRect:(CGRect )rect;

//将画布截取成圆形，然后重新绘图
+(UIImage*) circleImage:(UIImage *) image withParam:(CGFloat) inset;

//生成圆形图片
+(UIImageView *)returnCircleImageViewWithImage:(UIImage *)image;

//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;

/**
 * 压缩图片到指定文件大小
 *
 * @param image 目标图片
 * @param size 目标大小（最大值）
 *
 * @return 返回的图片文件
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

//裁剪指定尺寸
+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;

/**
 *
 * 给图片添加文字水印
 */
+ (UIImage *)jx_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed ;

/**
 *
 * 给图片添加图片水印
 */
+ (UIImage *)jx_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect ;

/**
 *
 * 修复图片旋转 方向
 */
- (UIImage *)fixOrientation ;

/**
 *
 * 根据本地GIF图片名 获得GIF image对象
 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

@end

//
//  NSString+Extension.h
//  zhengkun
//
//  Created by 郑坤 on 17/4/25.
//  Copyright © 2017年 郑坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)



#pragma mark 字符串长度计算方法
/*********************************************************************/
/**
 *  计算字符串实际尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(CGFloat)font withWidth:(CGFloat)width  ;


/**
 返回 字符串的 size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;


/* JSON */
- (id) asJSON;



#pragma mark 验证性判断
/*
 *****************************************************************************
 */

/**
 *  判断一个字符串是否包含另一个字符
 */
-(BOOL)contains:(NSString *)str;
/**
 *  判断字符串 str 是否为空
 */
+(BOOL)stringNull:(NSString *)str;
/**
 字符串 为空判断
 */
+ (BOOL)isNotNULL:(id)obj;
/**
 *
 * 判断 cellNum 是否是手机号
 */
+ (BOOL)isMobelPhoneNumber:(NSString *) mobile;




#pragma mark 计时器 - 时间处理 分类方法
/*
 *****************************************************************************
 */
/**
 获取 当前时间
 */
+ (NSString *)getCurrentTimeyyyymmdd ;


/**
 获取 HH:MM:SS格式的时间
 */
+(NSString *)getHHMMSSZtimeString:(NSString *)nowDateStr ;


/*
 * 钱 的初始化
 */
/**
 格式化  金额显示
 */
+(NSAttributedString *)getmoneyString:(NSString *)moneyString andColor:(UIColor *)color andFontSize:(NSInteger)font ;

//时间戳变为格式时间
+ (NSString *)ConvertStrToTime:(NSString *)timeStr ;

@end

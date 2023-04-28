//
//  NSString+Extension.m
//  zhengkun
//
//  Created by 郑坤 on 17/4/25.
//  Copyright © 2017年 郑坤. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
	return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(CGFloat)font withWidth:(CGFloat)width {
	
	NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
	//    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
	/** 行高 */
	paraStyle.lineSpacing = lineSpeace;
	// NSKernAttributeName字体间距
	NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
						  };
	CGSize size = [self boundingRectWithSize:CGSizeMake( width , MAXFLOAT ) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size ;
	
	return size.height;
}


-(BOOL)contains:(NSString *)str{
	NSRange range = [self rangeOfString:str];
	if (range.location != NSNotFound) {
		return YES;
	}
	return NO;
}
/**
 *  判断字符串 str 是否为空
 */
+(BOOL)stringNull:(NSString *)str{
	if ([str isKindOfClass:[NSNull class]] || [str description].length == 0 || str == nil) {
		return YES;
	}
	return NO;
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
	NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
	attrs[NSFontAttributeName] = font;
	CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
	
	// 获得系统版本
	if (iOSDevice >= 7) {
		return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
	} else {
		return [self sizeWithFont:font constrainedToSize:maxSize];
		
	}
}

- (CGSize)sizeWithFont:(UIFont *)font
{
	return [self sizeWithFont:font maxW:MAXFLOAT];
}


- (id) asJSON {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

//判断各种空条件
+ (BOOL)isNotNULL:(id)obj
{
	return   NULL!=obj && nil!=obj && (NULL)!=obj && (Nil)!=obj  && [NSNull null]!=obj ?  YES: NO ;
}


+ (BOOL)isMobelPhoneNumber:(NSString *)mobile{
	
	//    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
	//    if (mobile.length != 11)
	//    {
	//        return NO;
	//    }else{
	//        /**
	//         * 移动号段正则表达式
	//         */
	//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
	//        /**
	//         * 联通号段正则表达式
	//         */
	//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
	//        /**
	//         * 电信号段正则表达式
	//         */
	//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
	//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
	//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
	//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
	//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
	//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
	//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
	//
	//        if (isMatch1 || isMatch2 || isMatch3) {
	//            return YES;
	//        }else{
	//            return NO;
	//        }
	//    }
	
	mobile = [ mobile stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
	if ( mobile.length == 11 )
	{
		return YES;
	}else{
		
		return NO;
	}
	
}





/**
 *********************时间 - 获取时间字符串*********************
 */

/**
 获取 当前时间  yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)getCurrentTimeyyyymmdd {
	
	NSDate *now = [NSDate date];
	NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
	formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	NSString *dayStr = [formatDay stringFromDate:now];
	
	return dayStr;
}

/**
 获取  时分秒格式字符串  HH:mm:ss
 */
+(NSString *)getHHMMSSZtimeString:(NSString *)nowDateStr{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss" ];
	NSDate *nowDate = [formatter dateFromString:nowDateStr];
	[formatter setDateFormat:@"HH:mm:ss" ];
	NSString*timeString=[formatter stringFromDate:nowDate];
	return timeString;
}


/*
 * 钱 的初始化
 */
/**
 格式化  金额显示
 */
+(NSAttributedString *)getmoneyString:(NSString *)moneyString andColor:(UIColor *)color andFontSize:(NSInteger)font{
    
    NSArray * stringArr = [moneyString componentsSeparatedByString:@"."];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:moneyString];
    NSString * strOne = stringArr.firstObject ;
    NSString * strTwo = stringArr.lastObject ;
//    NSRange firthRange = [ moneyString  rangeOfString:stringArr.firstObject ] ;
    NSRange firthRange = NSMakeRange(0, strOne.length );
//    NSRange secondRange = [ moneyString  rangeOfString:stringArr.lastObject ] ;
    NSRange secondRange = NSMakeRange( strOne.length , strTwo.length - 1);
    [attStr addAttributes:@{
                                NSFontAttributeName:[UIFont systemFontOfSize:font] ,
                                NSForegroundColorAttributeName:color
                                } range:firthRange];
    [attStr addAttributes:@{
                                NSFontAttributeName:[UIFont systemFontOfSize:font - 3] ,
                                NSForegroundColorAttributeName:color
                                } range:secondRange];
    
    return attStr.copy;
}


//时间戳变为格式时间
+ (NSString *)ConvertStrToTime:(NSString *)timeStr{
    
    long long time=[timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;

    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"MM-dd HH:mm"];

    NSString*timeString=[formatter stringFromDate:date];

    return timeString;
}



@end

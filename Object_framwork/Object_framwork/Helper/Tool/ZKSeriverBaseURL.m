//
//  ZKSeriverBaseURL.m
//  butlerUsedCar
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 zhengkun. All rights reserved.
//

#import "ZKSeriverBaseURL.h"

@implementation ZKSeriverBaseURL


+(NSString *)getUrlType:(NSString *)urlString {
	
	NSString * urlS = [Base_URL stringByAppendingString:urlString ] ;
	
	return urlS ;
}



@end


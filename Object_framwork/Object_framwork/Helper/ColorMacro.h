//
//  ColorMacro.h
//  ceshi
//
//  Created by 高通 on 2018/11/7.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h


// ====================================取色值相关的方法==========================================

#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]

#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:(a)]

//色值转换
#define UIColorFromRGB(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define RGBA_OF(rgbValue)   [UIColor colorWithRed:((float)(((rgbValue) & 0xFF000000) >> 24))/255.0 \
green:((float)(((rgbValue) & 0x00FF0000) >> 16))/255.0 \
blue:((float)(rgbValue & 0x0000FF00) >> 8)/255.0 \
alpha:((float)(rgbValue & 0x000000FF))/255.0]

#define RGBAOF(v, a)        [UIColor colorWithRed:((float)(((v) & 0xFF0000) >> 16))/255.0 \
green:((float)(((v) & 0x00FF00) >> 8))/255.0 \
blue:((float)(v & 0x0000FF))/255.0 \
alpha:a]
#define kColorWithStr(colorStr)      [UIColor colorWithHexString:colorStr]

#define RGB_COLOR(_STR_,a) ([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:a])
//app主色调s
#define normalColors [UIColor colorWithRed:255/255.0 green:97/255.0 blue:49/255.0 alpha:1]
#define oldNormalColors [UIColor colorWithRed:255/255.0 green:221/255.0 blue:0/255.0 alpha:1]
#define Line_Cor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]



// =====================================通用颜色=========================================

#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]
#define kRandomFlatColor    [UIColor randomFlatColor]

#define UIColorGray1 RGB(53, 60, 70)
#define UIColorGray2 RGB(73, 80, 90)
#define UIColorGray3 RGB(93, 100, 110)
#define UIColorGray4 RGB(113, 120, 130)
#define UIColorGray5 RGB(133, 140, 150)
#define UIColorGray6 RGB(153, 160, 170)
#define UIColorGray7 RGB(173, 180, 190)
#define UIColorGray8 RGB(196, 200, 208)
#define UIColorGray9 RGB(216, 220, 228)


// 项目主题色
#define ObjectSystemColor [UIColor orangeColor]
#define ThemeTintColor [UIColor orangeColor]
#define MainGray RGB(249, 249, 249)
#define lineGray RGB(238, 239, 240)


//字体的颜色
#define firthBlaceFont UIColorFromRGB(0x000000)
#define oneBlaceFont UIColorFromRGB(0x333333)
#define twoBlaceFont UIColorFromRGB(0x666666)
#define threeBlaceFont UIColorFromRGB(0x999999)

#endif /* ColorMacro_h */

//
//  FontMacro.h
//  ceshi
//
//  Created by 高通 on 2018/11/7.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.
//

#ifndef FontMacro_h
#define FontMacro_h



#define kAppLargeTextFont           [UIFont systemFontOfSize:16]
#define kAppMiddleTextFont_1        [UIFont systemFontOfSize:15]
#define kAppMiddleTextFont          [UIFont systemFontOfSize:14]
#define kAppSmallTextFont_1         [UIFont systemFontOfSize:13]
#define kAppSmallTextFont           [UIFont systemFontOfSize:12]
#define kAppSmallerTextFont_1       [UIFont systemFontOfSize:11]
#define kAppSmallerTextFont         [UIFont systemFontOfSize:10]


//百媚直播定义 s是same（一样）
#define kAppSTenTextFont              [UIFont systemFontOfSize:10]
#define kAppSElevenTextFont           [UIFont systemFontOfSize:11]
#define kAppSTwelveTextFont           [UIFont systemFontOfSize:12]
#define kAppSThirteenTextFont         [UIFont systemFontOfSize:13]
#define kAppSFourteenTextFont         [UIFont systemFontOfSize:14]
#define kAppSFifteenTextFont          [UIFont systemFontOfSize:15]
#define kAppSSixteenTextFont          [UIFont systemFontOfSize:16]
#define kAppSSeventeenTextFont        [UIFont systemFontOfSize:17]
#define kAppSEighteenTextFont         [UIFont systemFontOfSize:18]
#define kAppSNineteenTextFont         [UIFont systemFontOfSize:19]
#define kAppSTwentyTextFont           [UIFont systemFontOfSize:20]
#define kAppSTwentyFiveTextFont       [UIFont systemFontOfSize:25]
#define kAppSThirtyTextFont           [UIFont systemFontOfSize:30]
#define kAppSThirtyFiveTextFont       [UIFont systemFontOfSize:35]

// 间距大小
#define kAppSpaceSizeZero            0
#define kAppSpaceSizeOne             1
#define kAppSpaceSizeTwo             2
#define kAppSpaceSizeThree           3
#define kAppSpaceSizeFour            4
#define kAppSpaceSizeFive            5
#define kAppSpaceSizeSix             6
#define kAppSpaceSizeSeven           7
#define kAppSpaceSizeEight           8
#define kAppSpaceSizeNine            9
#define kAppSpaceSizeTen             10
#define kAppSpaceSizeEleven          11
#define kAppSpaceSizeTwelve          12
#define kAppSpaceSizeThirteen        13
#define kAppSpaceSizeFourteen        14
#define kAppSpaceSizeFifteen         15
#define kAppSpaceSizeSixteen         16
#define kAppSpaceSizeSeveteen        17
#define kAppSpaceSizeEighteen        18
#define kAppSpaceSizeNineteen        19
#define kAppSpaceSizeTwenty          20
#define kAppSpaceSizeTwentyFive      25
#define kAppSpaceSizeThirty          30
#define kAppSpaceSizeThirtyFive      35
#define kAppSpaceSizeForty           40
#define kAppSpaceSizeFortyFive       45
#define kAppSpaceSizeFifty           50
#define kAppSpaceSizeFiftyFive       55
#define kAppSpaceSizeSixty           60
#define kAppSpaceSizeSixtyFive       65
#define kAppSpaceSizeSeventy         70
#define kAppSpaceSizeSeventyFive     75
#define kAppSpaceSizeEighty          80
#define kAppSpaceSizeNinety          90
#define kAppSpaceSizeNinetyFive      95
#define kAppSpaceSizeOneHundred      100

//d是different（不一样）不一样的屏幕字体大小不一样，例如iphone5-iphone6 差1
#define kAppDNineTextFont                 [UIFont systemFontOfSize:NineTextFont()]
static __inline__ CGFloat NineTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 8;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 9;
	}else
	{
		return 10;
	}
}
#define kAppDTenTextFont                 [UIFont systemFontOfSize:TenTextFont()]
static __inline__ CGFloat TenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 9;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 10;
	}else
	{
		return 11;
	}
}

#define kAppDElevenTextFont                 [UIFont systemFontOfSize:ElevenTextFont()]
static __inline__ CGFloat ElevenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 10;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 11;
	}else
	{
		return 12;
	}
}

#define kAppDTwelveTextFont                 [UIFont systemFontOfSize:TwelveTextFont()]
static __inline__ CGFloat TwelveTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 11;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 12;
	}else
	{
		return 13;
	}
}

#define kAppDThirteenTextFont                 [UIFont systemFontOfSize:ThirteenTextFont()]
static __inline__ CGFloat ThirteenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 12;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 13;
	}else
	{
		return 14;
	}
}

#define kAppDFourteenTextFont                 [UIFont systemFontOfSize:FourteenTextFont()]
static __inline__ CGFloat FourteenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 13;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 14;
	}else
	{
		return 15;
	}
}

#define kAppDFifteenTextFont                 [UIFont systemFontOfSize:FifteenTextFont()]
static __inline__ CGFloat FifteenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 14;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 15;
	}else
	{
		return 16;
	}
}

#define kAppDSixteenTextFont                 [UIFont systemFontOfSize:SixteenTextFont()]
static __inline__ CGFloat SixteenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 15;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 16;
	}else
	{
		return 17;
	}
}

#define kAppDSeventeenTextFont                 [UIFont systemFontOfSize:SeventeenTextFont()]
static __inline__ CGFloat SeventeenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 16;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 17;
	}else
	{
		return 18;
	}
}

#define kAppDEighteenTextFont                 [UIFont systemFontOfSize:EighteenTextFont()]
static __inline__ CGFloat EighteenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 17;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 18;
	}else
	{
		return 19;
	}
}

#define kAppDNineteenTextFont                 [UIFont systemFontOfSize:NineteenTextFont()]
static __inline__ CGFloat NineteenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 18;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 19;
	}else
	{
		return 20;
	}
}

#define kAppDTwentyTextFont                 [UIFont systemFontOfSize:TwentyTextFont()]
static __inline__ CGFloat TwentyTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 19;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 20;
	}else
	{
		return 21;
	}
}

#define kAppDTwentyFiveTextFont                 [UIFont systemFontOfSize:AppDTwentyFiveTextFont()]
static __inline__ CGFloat TwentyFiveTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 24;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 25;
	}else
	{
		return 26;
	}
}

#define kAppDThirtyTextFont                 [UIFont systemFontOfSize:ThirtyTextFont()]
static __inline__ CGFloat ThirtyTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 29;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 30;
	}else
	{
		return 31;
	}
}

#define kAppDThirtyFiveTextFont                 [UIFont systemFontOfSize:ThirtyFiveTextFont()]
static __inline__ CGFloat ThirtyFiveTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 34;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 35;
	}else
	{
		return 36;
	}
}

#define kAppDOFourteenTextFont                 [UIFont boldSystemFontOfSize:OFourteenTextFont()]
static __inline__ CGFloat OFourteenTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 13;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 14;
	}else
	{
		return 15;
	}
}

#define kAppDOTwentyTextFont                 [UIFont boldSystemFontOfSize:OTwentyTextFont()]
static __inline__ CGFloat OTwentyTextFont()
{
	if (([UIScreen mainScreen].bounds.size.width == 320.0f))
	{
		return 19;
	}else  if(([UIScreen mainScreen].bounds.size.width == 375.0f))
	{
		return 20;
	}else
	{
		return 21;
	}
}



#endif /* FontMacro_h */

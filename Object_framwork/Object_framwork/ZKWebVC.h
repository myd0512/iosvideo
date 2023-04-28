//
//  ZKWebVC.h
//  ShuCaiPeiSong
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 zhengkun. All rights reserved.
//


/**
 *  加载所有 web 展示页面
 *
 *  协议 - 帮助 - 新闻网页展示
 */
typedef enum {
    
    AgreementWebType = 1  , // 入驻协议
    my_Help , // 我的帮助
    
} webType ;

//

#import <UIKit/UIKit.h>

@interface ZKWebVC : UIViewController

/**
 *
 * web页类型
 */
-(instancetype)initWithType:(webType )type ;



///**
// *
// * news_id车ID  type页类型
// */
//-(instancetype)initWithId:(NSString *)news_id Type:(webType )type;







@end

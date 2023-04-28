//
//  FXAppDetailWebView.h
//  fenxiao
//
//  Created by hln on 2018/5/29.
//  Copyright © 2018年 火烈鸟. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef void(^setWebViewHeight)(CGFloat wheight);

@interface FXAppDetailWebView : WKWebView

@property (assign,nonatomic)CGFloat webHeight;

@property (strong,nonatomic)setWebViewHeight setWebViewHeight;

@end

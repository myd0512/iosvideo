//
//  FXAppDetailWebView.m
//  fenxiao
//
//  Created by hln on 2018/5/29.
//  Copyright © 2018年 火烈鸟. All rights reserved.
//

#import "FXAppDetailWebView.h"

@implementation FXAppDetailWebView

- (id)initWithFrame:(CGRect)frame {
    
    if(self  = [super initWithFrame:frame]){
        [self setKVO];
    }
    return self;
}


- (void)setKVO {
    //一次性设置
    //self.scalesPageToFit = YES;
    self.userInteractionEnabled = YES;
    self.opaque = YES;
    [self.scrollView addObserver:self
                      forKeyPath:@"contentSize"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:nil];
    
    
    //    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    //    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    //    [wkUController addUserScript:wkUScript];
    //    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    //    wkWebConfig.userContentController = wkUController;
    //    WKWebView *contentWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig] ;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGSize size = [change[@"new"]CGSizeValue];
    self.webHeight = size.height;
    NSLog(@"%@", NSStringFromCGSize(size));
    if (_setWebViewHeight) {
        _setWebViewHeight(size.height);
    }
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end

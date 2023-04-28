//
//  ZKWebVC.m
//  ShuCaiPeiSong
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 zhengkun. All rights reserved.
//

#import "ZKWebVC.h"
#import <WebKit/WebKit.h>
#import "WeakScriptMessageDelegate.h"



@interface ZKWebVC ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate , WKScriptMessageHandler >

@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) WKWebView *wkWebView;

@property(nonatomic,strong)NSURL * LoadUrl;

@end

@implementation ZKWebVC{
    
    NSString * _newsInfo_id ;
    webType _webtypes ;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
	
}

-(instancetype)initWithType:(webType )type {
    
    if (self = [super init]) {
        
        _webtypes = type ;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad] ;
	
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
	
	WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
	
    _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH , HEIGHT ) configuration:config] ;

    _wkWebView.backgroundColor = [UIColor whiteColor];
    [_wkWebView setUserInteractionEnabled:YES];//是否支持交互
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    [_wkWebView setOpaque:NO];//opaque是不透明的意思
    
    [self.view addSubview:_wkWebView];
	
    
    //添加进度条
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 2)];
    self.progressView.backgroundColor = [UIColor blueColor];
	
    //设置进度条的高度，进度条宽度变为原来的1倍，高度变为原来的1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    //添加KVO，WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以监听这个属性
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
	
	
	
    if (_webtypes == AgreementWebType) { // 协议
        
        self.title = @"入驻协议" ;
        
        NSString *urlStr = [ZKSeriverBaseURL getUrlType:Login] ;
		
        NSURL *url = [NSURL URLWithString:urlStr];
        
        _LoadUrl = url ;
        
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
		
		[[_wkWebView configuration].userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"goStore"] ;
        
        
    }else if (_webtypes == my_Help ){ // 新闻详情页
        
        self.title = @"我的帮助" ;
        
        NSString *urlStr = [ZKSeriverBaseURL getUrlType: Login] ;
        ;
        
        NSURL *url = [NSURL URLWithString:urlStr];
        
        _LoadUrl = url ;
        
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
    
}

#pragma mark - 监听
/*
 *在监听方法中获取网页加载的进度，并将进度赋给progressView.progress
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKWKNavigationDelegate Methods
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载网页");
    
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
}
//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}

//页面跳
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
	
    
	decisionHandler(WKNavigationActionPolicyAllow);
}


//WKScriptMessageHandler协议方法 - //交互js调用,oc 方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
	//code
	NSLog(@"name = %@, body = %@", message.name, message.body);
	
	if ([message.name isEqualToString:@"getMessage"]) {
		
		
	}
	
}


- (void)dealloc {
	
	[self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
	
	[[_wkWebView configuration].userContentController removeScriptMessageHandlerForName:@"getMessage"];
	
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


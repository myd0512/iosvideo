//
//  WeakScriptMessageDelegate.h
//  Object_framwork
//
//  Created by 高通 on 2019/6/15.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

/**
 代理对象 - 用来解耦
 */
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, assign) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END

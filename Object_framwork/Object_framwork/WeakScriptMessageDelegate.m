//
//  WeakScriptMessageDelegate.m
//  Object_framwork
//
//  Created by 高通 on 2019/6/15.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate


- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
	self = [super init];
	if (self) {
		_scriptDelegate = scriptDelegate;
	}
	return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
	[self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}


@end


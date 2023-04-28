//
//  倒计时按钮 - 倒计时.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/12.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.



// 倒计时验证码
__weak __typeof__(self) weakSelf = self ;
self.codeButton = [[CQCountDownButton alloc] initWithDuration:60 buttonClicked:^{
	//------- 按钮点击 -------//
	[SVProgressHUD showWithStatus:@"正在获取验证码..."];
	
	[weakSelf.view endEditing:YES];
	
	UITextField * phoneText = _textArray[2] ;
	
	BOOL isMobile=[[ZKSimpleManager sharedInstance]JudgementMobile:phoneText.text];
	if(isMobile){
		
		//请求手机验证码
		NSDictionary *dict = @{@"phone":phoneText.text  , @"type":@"3"};
		[[ZKHttpTool shareInstance] post:[ZKSeriverBaseURL getNewUrlType:Type_New_sms] params:dict withHUD:YES success:^(id json) {
			//  NSLog(@"手机验证码：%@",json);
			
			[SVProgressHUD showSuccessWithStatus:json[@"result"]];
			// 获取到验证码后开始倒计时
			[weakSelf.codeButton startCountDown];
		} failure:^(NSError *error) {
			// 获取失败
			[SVProgressHUD showErrorWithStatus:@"获取失败，请重试"];
			weakSelf.codeButton.enabled = YES;
		}];
	}else{
		
		[SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
		weakSelf.codeButton.enabled = YES;
	}
	
} countDownStart:^{
	//------- 倒计时开始 -------  //
	
	[self.codeButton setTitleColor:threeBlaceFont forState:UIControlStateNormal];
	[self.codeButton setTitleColor:threeBlaceFont forState:UIControlStateDisabled];
	[weakSelf.codeButton setTitle:@"60s" forState:UIControlStateNormal] ;
	self.codeButton.layer.borderColor = threeBlaceFont.CGColor ;
	//  NSLog(@"倒计时开始");
} countDownUnderway:^(NSInteger restCountDownNum) {
	
	//------- 倒计时进行中 -------  //
	[weakSelf.codeButton setTitle:[NSString stringWithFormat:@"%lds", restCountDownNum] forState:UIControlStateNormal] ;
	
} countDownCompletion:^{
	//------- 倒计时结束 -------  //
	[weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
	[self.codeButton setTitleColor:ObjectSystemColor forState:UIControlStateNormal];
	self.codeButton.layer.borderColor = ObjectSystemColor.CGColor;
	//  NSLog(@"倒计时结束");
}];

self.codeButton.frame =CGRectMake(infoview.width - 100 , 0 , 100 , 35 ) ;
[self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
[self.codeButton setTitleColor:ObjectSystemColor forState:UIControlStateNormal];
self.codeButton.titleLabel.font = [UIFont systemFontOfSize:12];

[infoview addSubview:self.codeButton ];






// 倒计时  -   一定秒数倒计时
NSInteger secondsCountDown =  100000 ; //  - 倒计时的秒数

__weak __typeof(self) weakSelf = self;

if (_timer == nil) {
	
	__block NSInteger timeout = secondsCountDown; // 倒计时时间
	
	if (timeout!=0) {
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
		dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
		
		dispatch_source_set_event_handler(_timer, ^{
			if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
				dispatch_source_cancel(weakSelf.timer);
				weakSelf.timer = nil;
				dispatch_async(dispatch_get_main_queue(), ^{// 定时倒计时  到点处理
					
					[self handleTime];  // 重新倒计时
					
				});
				
			} else { // 倒计时重新计算 时/分/秒
				
				NSInteger days = (int)(timeout/(3600*24));
				NSInteger hours = (int)((timeout-days*24*3600)/3600);
				NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
				NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
				NSString *strTime = [NSString stringWithFormat:@"%02ld : %02ld", minute, second];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					if (days == 0) {
						weakSelf.timeLabel_倒计时.text = strTime;
					} else {
						weakSelf.timeLabel_倒计时.text = [NSString stringWithFormat:@" %02ld : %02ld", minute, second];
					}
					
				});
				timeout--; // 递减 倒计时-1(总时间以秒来计算)
			}
		});
		dispatch_resume(_timer);
	}

}

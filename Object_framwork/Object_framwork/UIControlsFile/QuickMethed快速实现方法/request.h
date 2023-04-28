//
//  request.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/12.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.



[[ZKHttpTool shareInstance] post:[ZKSeriverBaseURL getNewUrlType:Type_New_car_detail] params:@{@"cheid":pu_id} withHUD:YES success:^(id json) {
	
	if([json objectForKey:@"body"]) {
		
		if([json[@"body"] count]) {
			
			isSuccess(json[@"body"]);
		}else {
			
			[SVProgressHUD showErrorWithStatus:@"无详情数据"];
		}
	}
} failure:^(NSError *error) {

	
	
}];

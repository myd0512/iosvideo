//
//  lopcationSelectMethod.h
//  Object_framwork
//
//  Created by 高通 on 2019/4/28.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#ifndef lopcationSelectMethod_h
#define lopcationSelectMethod_h



#import "SPModalView.h" // - 采用动画的形式
#import "AddressView.h" // 点击地址



// 这个view添加了addressView，采用动画的形式从下往上弹出
@property (nonatomic, strong) SPModalView *modalView;
// 地址view，这个view上添加了本人封装的2大控件，一个是SPPageMenu，分页菜单;  另一个是本demo的主角:SPPickerView
@property (nonatomic, strong) AddressView *addressView;




// SPModalView是一个弹出视图
self.modalView = [[SPModalView alloc] initWithView:self.addressView inBaseViewController:self] ;
self.modalView.narrowedOff = YES ;

// 相当于网络请求
[self configureData] ;


/**
 点击 按钮  吊起地点选择
 */
[ self.modalView  show ] ;

- (void)configureData {
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"pcd.plist" ofType:nil];
	NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
	
	// 给addressView传数据
	self.addressView.datas = dictArray;
}



#pragma mark 点击 - 地址选择
- (AddressView *)addressView {
	
	if (!_addressView) {
		_addressView = [[AddressView alloc] init];
		_addressView.frame = CGRectMake(0, 0, WIDTH, 400) ;
		__weak __typeof(self) weakSelf = self;
		// 最后一列的行被点击的回调
		_addressView.lastComponentClickedBlock = ^(SPProvince *selectedProvince, SPCity *selectedCity, SPDistrict *selectedDistrict) {
			
			[weakSelf.modalView hide];
			
			weakSelf.sheng = selectedProvince ;
			weakSelf.shi = selectedCity ;
			weakSelf.qu = selectedDistrict ;
			
			weakSelf.locationLabel.text = [NSString stringWithFormat:@"%@%@%@",selectedProvince.fullname,selectedCity.fullname,selectedDistrict.fullname] ;
			weakSelf.locationLabel.textColor = kBlackColor ;
		};
	}
	return _addressView;
}


#endif /* lopcationSelectMethod_h */

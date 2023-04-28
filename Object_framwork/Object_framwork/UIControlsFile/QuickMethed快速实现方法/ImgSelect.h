//
//  ImgSelect.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/12.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.


#pragma mark 单图选择

CBImagePicker * picker = [CBImagePicker shared] ;
[picker startWithVC:self] ;

[picker setPickerCompletion:^(CBImagePicker * picker, NSError *error, UIImage *image) {
	
	if (!error) {
		
		self.imgView.image = image;
	}else{
		
		NSLog(@"error.description = %@",error.userInfo[@"description"]);
	}
	
}] ;



#pragma mark 多图选择

< HXPhotoViewDelegate >

@property( strong , nonatomic ) HXPhotoManager * manager  ;


self.navigationController.navigationBar.translucent = NO;
self.automaticallyAdjustsScrollViewInsets = YES;

HXPhotoView *photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(0, 100, WIDTH, 200) manager:self.manager];

photoView.outerCamera = YES ;
photoView.delegate = self ;
photoView.lineCount = 3 ;
photoView.spacing = 10 ;
photoView.backgroundColor = [UIColor WhiteColor] ;

[self.view addSubview:photoView] ;


// 懒加载 照片管理类
- (HXPhotoManager *)manager {
	if (!_manager) {
		_manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
		
		HXPhotoConfiguration * confi = [[HXPhotoConfiguration alloc] init];
		
		confi.openCamera = YES ;
		confi.showDeleteNetworkPhotoAlert = NO;
		confi.saveSystemAblum = YES;
		confi.photoMaxNum = 9 ;
		confi.maxNum = 9;
		confi.lookGifPhoto = NO ;
		confi.singleJumpEdit = NO ;
		
	}
	return _manager;
}

//// 代理返回 选择、移动顺序、删除之后的图片以及视频
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal{
	
	if (photos.count > 0) {
		
		HXPhotoModel *model = photos.lastObject ;
	
		dispatch_async(dispatch_get_main_queue(), ^{
			
			self.imgView.image = model.thumbPhoto  ;
		});
		
		NSSLog(@"%ld张图片",photos.count);
	}
}

// 当view更新高度时调用
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame{
	
	NSLog(@" frame = %lf , %lf ", frame.size.width ,  frame.size.height   ) ;
}

// 删除网络图片的地址
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl{
	
	
}

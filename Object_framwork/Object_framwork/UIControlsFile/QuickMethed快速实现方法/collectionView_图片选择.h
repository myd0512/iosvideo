//
//  collectionView.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/12.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.

/**
 
 collectionView 控件初始化  , 及属性设置

 图片选择 ( 单图 , 多图功能 )
 
 */

//1.初始化layout
UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//设置collectionView滚动方向
[layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//该方法也可以设置itemSize
layout.itemSize =CGSizeMake( ( WIDTH - 32 ) * 107/321.0 - 20  , ( WIDTH - 32 ) * 107/321.0 - 20 );
layout.minimumLineSpacing = 10.0 ;
layout.minimumInteritemSpacing = 10.0 ;

// layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) ;

//2.初始化collectionView
_mainCollectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(16, tthree_titleLabel.bottom + 5 , WIDTH - 32, ( WIDTH - 32 ) * 107/321.0  ) collectionViewLayout:layout];
[threeView addSubview:_mainCollectionView];
_mainCollectionView.backgroundColor = [UIColor clearColor] ;
_mainCollectionView.showsHorizontalScrollIndicator = NO ;
_mainCollectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10) ;
//3.注册collectionViewCell
//注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
[ _mainCollectionView registerNib:[UINib nibWithNibName:@"ZKPicSelectCell" bundle:nil] forCellWithReuseIdentifier:@"ZKPicSelectCell" ];

//4.设置代理
_mainCollectionView.delegate = self ;
_mainCollectionView.dataSource = self ;





//  多图选择图片选择
@property( strong , nonatomic ) HXPhotoManager * manager  ;



// 懒加载 照片管理类
- (HXPhotoManager *)manager {
	if (!_manager) {
		_manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
		
		HXPhotoConfiguration * confi = [[HXPhotoConfiguration alloc] init];
		
		confi.openCamera = YES ;
		confi.showDeleteNetworkPhotoAlert = NO;
		confi.saveSystemAblum = YES;
		confi.photoMaxNum = 4 ;
		confi.maxNum = 4;
		confi.lookGifPhoto = NO ;
		confi.singleJumpEdit = NO ;
		
		_manager.configuration = confi ;
	}
	return _manager;
}



//// 代理返回 选择、移动顺序、删除之后的图片以及视频
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal{
	
	if (photos.count > 0) {
		
		self.imgArray = @[].mutableCopy ;
		
		for (HXPhotoModel * model in photos) {
			
			[self.imgArray addObject:model.thumbPhoto];
		}
		
	}
}

// 当view更新高度时调用
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame{
	
	NSLog(@" frame = %lf , %lf ", frame.size.width ,  frame.size.height   ) ;
	
	self.SubBtn.frame = CGRectMake( 25, self.photoView.bottom + 40 , WIDTH - 50, 40 ) ;
	self.subLabel.top = self.SubBtn.bottom + 20 ;
	
	
	/**
	 刷新 尺寸
	 */
	self.baseBackView.height = self.subLabel.bottom + 20 ;
	self.baseBackScrollView.contentSize = CGSizeMake(0, self.baseBackView.height + kTabBarHeight + kNavigationBarHeight ) ;
}


/**
 视图, 自带选择框
 */
HXPhotoView *photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(0, addallImgsLabel.bottom + 10 , WIDTH, 200) manager:self.manager];

photoView.outerCamera = NO ;
photoView.delegate = self ;
photoView.lineCount = 3 ;
photoView.spacing = 15 ;
photoView.backgroundColor = kWhiteColor ;

self.photoView = photoView ;

[self.baseBackView addSubview:photoView ] ;




/**
 单图 - 选择
 */
CBImagePicker * picker = [CBImagePicker shared] ;
[picker startWithVC:self] ;

[picker setPickerCompletion:^(CBImagePicker * picker, NSError *error, UIImage *image) {
	
	if (!error) {
		
		self.imageView.image = image;
		
		self->_dataImg = image ;
		
	}else{
		
		NSLog(@"error.description = %@",error.userInfo[@"description"]);
	}
	
	}] ;




// 导入文件
#import "ZLPhotoActionSheet.h"
// 建立属性
@property(nonatomic,strong)ZLPhotoActionSheet *photoAC; // 相册 选择

#pragma mark 图片选择 - 相册
-(void)createPicSelect
{
	self.photoAC = [[ZLPhotoActionSheet alloc] init] ;
	self.photoAC.configuration.allowTakePhotoInLibrary = NO ;
	self.photoAC.configuration.allowMixSelect = NO ;
	self.photoAC.configuration.allowSelectVideo = NO ;
	self.photoAC.configuration.allowSelectGif = NO ;
	self.photoAC.configuration.maxSelectCount = 9 ;
	
	//如调用的方法无sender参数，则该参数必传
	self.photoAC.sender = self ;
	
	//选择回调
	WeakSelf;
	[self.photoAC  setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
		
		//your codes
		NSLog(@"%@",images);
		
		[weakSelf.imagePicArr addObjectsFromArray:images];
		
		[weakSelf.mainCollectionView reloadData];
	}];
}


#pragma mark 图片代理 - 相机

 // 提示框的代理事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIImagePickerController *pickerController=[[UIImagePickerController alloc]init];
	pickerController.delegate=self;
	[self.view endEditing:YES];
	if (buttonIndex==0){
		[self.photoAC showPhotoLibrary];
	}
	if (buttonIndex==1){
		pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
		//        pickerController.allowsEditing = YES;     // 设置选择后的图片是否能被编辑
		[self presentViewController:pickerController animated:YES completion:^{
		}];//调起
	}
	
}

// 图片选择的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
	NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
	// 当选择的类型是图片
	if ([type isEqualToString:@"public.image"])
	{
		UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"]; // 裁剪后的图片
		
		[self.imagePicArr addObject:image];
		[self.mainCollectionView reloadData];
	}
	[picker dismissViewControllerAnimated:YES completion:nil];
	
}

// 弹出提示框
UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍摄", nil] ;

[actionSheet showInView:self.view] ;

//
//  UpVideoVC.m
//  Object_framwork
//
//  Created by mac on 2020/6/8.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "UpVideoVC.h"
#import "MyTextView.h"
#import "AlbumVideoVC.h"
#import <AVFoundation/AVFoundation.h>




@interface UpVideoVC ()
{
    UIImage *videobackImage;
}

/** 顶部组合：视频预览、视频描述 */
@property(nonatomic,strong)UIView   *topMix;

@property(nonatomic,strong)UIView  *videoPreview;               //视频预览
@property(nonatomic,strong)MyTextView  *videoDesTV;             //视频描述
@property(nonatomic,strong) UILabel *wordsNumL;                 //字符统计

/** 定位组合：图标、位置 */
@property(nonatomic,strong)UIView *locationV;

/** 发布按钮 */
@property(nonatomic,strong)UIButton *publishBtn;


@end

@implementation UpVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)initSubviews{
    
    self.title = @"上传视频" ;
    self.view.backgroundColor = MainGray ;
    
 //顶部视图：预览、描述
   [self.view addSubview:self.topMix];
   
   //定位
   [self.view addSubview:self.locationV];
   
   //发布
   [self.view addSubview:self.publishBtn];
}

#pragma mark - set/get
-(UIView *)topMix {
    if (!_topMix) {
        _topMix = [[UIView alloc] initWithFrame:CGRectMake(15, kNavigationBarHeight+5, _window_width-30, 180)];
        _topMix.backgroundColor = [UIColor whiteColor];
        _topMix.layer.cornerRadius = 5.0;
        _topMix.layer.masksToBounds = YES;
        //视频预览
        _videoPreview = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 100, 150)];
        _videoPreview.layer.cornerRadius = 5.0;
        _videoPreview.layer.masksToBounds = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTapView)];
        [_videoPreview addGestureRecognizer:tap]; // 添加点击
        
        //视频描述
        _videoDesTV = [[MyTextView alloc] initWithFrame:CGRectMake(_videoPreview.right+10, 15, _topMix.width-_videoPreview.width - 35, _videoPreview.height)];
        _videoDesTV.backgroundColor = [UIColor clearColor];//RGB(242, 242, 242);
        _videoDesTV.delegate = self;
        _videoDesTV.layer.borderColor = _topMix.backgroundColor.CGColor;
        _videoDesTV.font = [UIFont systemFontOfSize:16];
        _videoDesTV.textColor = RGB_COLOR(@"#969696", 1);
        _videoDesTV.placeholder = @"添加视频描述~";
        _videoDesTV.placeholderColor = RGB_COLOR(@"#969696", 1);
        
        _wordsNumL = [[UILabel alloc] initWithFrame:CGRectMake(_videoDesTV.right-50, _videoDesTV.bottom-12, 50, 12)];
        _wordsNumL.text = @"0/50";
        _wordsNumL.textColor = RGB_COLOR(@"#969696", 1);
        _wordsNumL.font = [UIFont systemFontOfSize:12];
        _wordsNumL.backgroundColor =[UIColor clearColor];
        _wordsNumL.textAlignment = NSTextAlignmentRight;
        
        [_topMix addSubview:_videoPreview];
        [_topMix addSubview:_videoDesTV];
        [_topMix addSubview:_wordsNumL];
        
    }
    return _topMix;
}

-(UIView *)locationV {
    if (!_locationV) {
        //显示定位
        _locationV = [[UIView alloc]initWithFrame:CGRectMake(15, _topMix.bottom+5, _window_width-30, 50)];
        _locationV.backgroundColor = [UIColor whiteColor];;
        _locationV.layer.cornerRadius = 5.0;
        _locationV.layer.masksToBounds = YES;

        UIImageView *imageloca = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pink_location"]];
        imageloca.contentMode = UIViewContentModeScaleAspectFit;
        imageloca.frame = CGRectMake(15,_locationV.height/2-7.5,15,15);
        [_locationV addSubview:imageloca];
        
        UILabel *locationlabels = [[UILabel alloc]initWithFrame:CGRectMake(imageloca.right+5, 0, _window_width-50, 50)];
        locationlabels.font = [UIFont systemFontOfSize:15];
        locationlabels.text = [NSString stringWithFormat:@"%@",@"好像在火星"];
        locationlabels.textColor = RGB_COLOR(@"#969798", 1);
        
        [_locationV addSubview:locationlabels];
    }
    return _locationV;
}

-(UIButton *)publishBtn {
    if (!_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishBtn.frame = CGRectMake(40, _locationV.bottom+20, _window_width-80, 40);
        [_publishBtn setTitle:@"确认发布" forState:0];
        [_publishBtn setTitleColor:[UIColor whiteColor] forState:0];
        _publishBtn.backgroundColor = normalColors;
        _publishBtn.layer.masksToBounds = YES;
        _publishBtn.layer.cornerRadius = 20;
        [_publishBtn addTarget:self action:@selector(clickPublishBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView*)textView {

    NSString *toBeString = textView.text;
    NSString *lang = [[[UITextInputMode activeInputModes]firstObject] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];//获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 50) {
                textView.text = [toBeString substringToIndex:50];
                _wordsNumL.text = [NSString stringWithFormat:@"%u/50",(50-textView.text.length)];
            }else{
                _wordsNumL.text = [NSString stringWithFormat:@"%u/50",(50-toBeString.length)];
            }
        }else{
            //有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > 50) {
            textView.text = [toBeString substringToIndex:50];
            _wordsNumL.text = [NSString stringWithFormat:@"%u/50",(50-textView.text.length)];
        }else{
            _wordsNumL.text = [NSString stringWithFormat:@"%u/50",(50-toBeString.length)];
        }
    }
    
}


- (void)applicationWillEnterForeground:(NSNotification *)noti {
    //temporary fix bug
    if ([self.navigationItem.title isEqualToString:@"发布中"])
        return;
    
}

- (void)applicationDidEnterBackground:(NSNotification *)noti {

    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


// 点击 - 上传
-(void)clickTapView{
    
    _videoPreview.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_videoPreview.userInteractionEnabled = YES;
    });
    __weak UpVideoVC *weakSelf = self;
    AlbumVideoVC *albunVC = [[AlbumVideoVC alloc]init];
    albunVC.selEvent = ^(NSString *path) {
        [weakSelf zhuanma:path];
    };
    
    [self presentViewController:albunVC animated:YES completion:nil];
}

// 点击 - 发布
-(void)clickPublishBtn{
    
    
    
}

//需要导入AVFoundation.h
- (UIImage*) getVideoPreViewImageWithPath:(NSURL *)videoPath{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time   = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error  = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img   = [[UIImage alloc] initWithCGImage:image];
    return img;
    
}
-(void)zhuanma:(NSString *)videlPathsss{
//    [MBProgressHUD showMessage:YZMsg(@"视频转码中")];
    //转码
    //获取缩略图
    videobackImage = [self getVideoPreViewImageWithPath:[NSURL URLWithString:videlPathsss]];
    // 视频转码
//    if ([videlPathsss hasSuffix:@".mp4"] || [videlPathsss hasSuffix:@".MP4"] || [videlPathsss hasSuffix:@".Mp4"]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
////            [MBProgressHUD hideHUD];
//            TXRecordResult *recordResult = [TXRecordResult new];
//            recordResult.coverImage = videobackImage;
//            recordResult.videoPath  = videlPathsss;
//            self.view.userInteractionEnabled = NO;
//            [self pushresult:recordResult];
//        });
//
//    }else{
//    NSString *random = [PublicObj getNameBaseCurrentTime:@""];
//    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videlPathsss] options:nil];
//
//    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPreset1280x720];
//    //exportPath = [NSString stringWithFormat:@"%@/%@.mp4",[NSHomeDirectory() stringByAppendingString:@"/tmp"],random];
//     exportPath = [NSString stringWithFormat:@"%@/Library/Caches/movie_%@.mp4",NSHomeDirectory(),random];
//    NSLog(@"exportPath=%@",exportPath);
//    exportSession.outputURL = [NSURL fileURLWithPath:exportPath];
//    exportSession.outputFileType = AVFileTypeMPEG4;
////    exportSession.canPerformMultiplePassesOverSourceMediaData = YES;
//    [exportSession exportAsynchronouslyWithCompletionHandler:^{
//        int exportStatus = exportSession.status;
//        switch (exportStatus) {
//            case AVAssetExportSessionStatusFailed:
//                NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
//                dispatch_async(dispatch_get_main_queue(), ^{
////                    [MBProgressHUD hideHUD];
////                    [MBProgressHUD showError:YZMsg(@"转码失败,请更换视频")];
//                });
//                break;
//            case AVAssetExportSessionStatusCancelled:
//                NSLog(@"Export canceled");
//                dispatch_async(dispatch_get_main_queue(), ^{
////                    [MBProgressHUD hideHUD];
////                    [MBProgressHUD showError:YZMsg(@"转码失败,请更换视频")];
//                });
//                break;
//            case AVAssetExportSessionStatusCompleted:
//                NSLog(@"转换成功");
//                dispatch_async(dispatch_get_main_queue(), ^{
////                    [MBProgressHUD hideHUD];
//                    TXRecordResult *recordResult = [TXRecordResult new];
//                    recordResult.coverImage = videobackImage;
//                    recordResult.videoPath  = exportPath;
//                    self.view.userInteractionEnabled = NO;
//                    [self pushresult:recordResult];
//                });
//                break;
//        }
//    }];
//    }
//    //如果压缩失败可不压缩直接上传   6.28
//    /*
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUD];
//        TXRecordResult *recordResult = [TXRecordResult new];
//        recordResult.coverImage = videobackImage;
//        recordResult.videoPath  = videlPathsss;
//        self.view.userInteractionEnabled = NO;
//        [self pushresult:recordResult];
//    });
//    */
    
}

@end

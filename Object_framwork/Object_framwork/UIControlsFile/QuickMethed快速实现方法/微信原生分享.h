//
//  微信原生分享.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/28.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.




//分享 单图:  10M以下


// ThumbImage : 图片大小   32K 以下

// 朋友圈 分享
NSData *imageData = [ NSData  dataWithContentsOfURL: url ];

NSData * sureData = [ UIImage compressOriginalImage:[UIImage imageWithData:imageData] toMaxDataSizeKBytes:1000.0] ;

WXImageObject *imageObject = [WXImageObject object];
imageObject.imageData = sureData ;

WXMediaMessage *message = [WXMediaMessage message];

message.mediaObject = imageObject;

SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
req.bText = NO;
req.message = message;
req.scene = WXSceneTimeline;

if(  [WXApi sendReq:req] ){
	
	successBlock() ;
}else{
	
	errorBlock() ;
	}


//好友分享

NSString *imageURL = [ ZKSeriverBaseURL getUrlPath:model.img_zhu]  ;

NSData *imageData = [NSData dataWithContentsOfURL: [ NSURL URLWithString:imageURL ] ];

NSData * sureData = [ UIImage compressOriginalImage:[UIImage imageWithData:imageData] toDataSizeKBytes:30*1024];

WXWebpageObject *webpageObject = [WXWebpageObject object];
webpageObject.webpageUrl = model.lianjie ;

WXMediaMessage *message = [WXMediaMessage message];
message.title = model.title ;
message.description = model.title ;
[message setThumbImage:[UIImage imageWithData:sureData]];

message.mediaObject = webpageObject;

SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init] ;
req.bText = NO ;
req.message = message ;
req.scene = WXSceneTimeline ;

if(  [WXApi sendReq:req]) {
	
	successBlock() ;
	
}else{
	
	errorBlock() ;
	}

//
//  ZKHttpTool.m
//  butlerUsedCar
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 zhengkun. All rights reserved.
//

#import "ZKHttpTool.h"
#import "LoginVC.h"



@interface ZKHttpTool ()

@property (nonatomic, strong) AFURLSessionManager *urlSessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) NSURLSessionConfiguration *urlSessionConfiguration;

@end

@implementation ZKHttpTool

+ (instancetype)shareInstance
{
    static ZKHttpTool *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        if (!instance) {
            instance = [[ZKHttpTool alloc] init];
        }
    });
    
    return instance;
}
#pragma mark  初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.httpSessionManager = [AFHTTPSessionManager manager];
        self.httpSessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.httpSessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.httpSessionManager.requestSerializer.timeoutInterval=15.0;//临时改成7秒
        [self.httpSessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSSet *typeSet=[NSSet setWithObjects:@"application/json",
                        @"text/json",
                        @"text/javascript",
                        @"text/html",
                        @"text/css",
                        @"text/plain",
                        @"image/jpeg",
                        @"image/png",
                        @"charset/UTF-8",nil];
        
        //
        self.httpSessionManager.responseSerializer.acceptableContentTypes =typeSet;
        //        self.httpSessionManager.securityPolicy.allowInvalidCertificates = YES;
        //        self.httpSessionManager.securityPolicy.validatesDomainName = NO;
        
        //        [self.httpSessionManager.requestSerializer setValue:@"text/html; charset=UTF-8; application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        /*
         Connection = "Keep-Alive";
         "Content-Length" = 2366;
         "Content-Type" = "text/html; charset=UTF-8";
         Date = "Thu, 31 Aug 2017 00:53:36 GMT";
         "Keep-Alive" = "timeout=5, max=100";
         Server = "Apache/2.4.23 (Win32) PHP/5.6.25";
         Status = "404 Not Found";
         "X-Powered-By" = "PHP/5.6.25";
         */
    }
    return self;
}


#pragma mark 方法实现

- (void)get:(NSString *)url params:(NSDictionary *)params withHUD:(BOOL)HUD  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    NSLog( @"url = %@" , url ) ;
	
    [self.httpSessionManager GET:url parameters:params progress:nil success:^( NSURLSessionDataTask * _Nonnull task , id  _Nullable responseObject) {
		
		NSLog(@"responseObject = %@" , responseObject ) ;
		
        if(success) {
            
            NSError *error=nil;
            NSString * ObjectString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            id Object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
	
            NSLog(@"responseObject = %@ / ObjectString = %@" , Object  , ObjectString ) ;
            
            if([Object[@"ret"] intValue]==200) {
                
                if ([Object[@"data"][@"code"] intValue] == 700) { //登陆状态失效，请重新登陆！
                    
                    [UserInfoManaget sharedInstance].model.isOpenLiveing = NO;
                    [[UserInfoManaget sharedInstance] save:[UserInfoManaget sharedInstance].model];
                    if (![[QuickCreatUI sharedInstance].topViewController isKindOfClass:[LoginVC class] ] ) {
                        
                        MyTopVCPush([LoginVC new]);
                    }
                   
                }else{
                    success(Object);
                }
            } else {
                
                failure(Object);
            }
			
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            BOOL reachable;
            reachable = [[Reachability reachabilityForInternetConnection] isReachable];
            if(!reachable) {
                [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请检查您的网络设置"];
            }else {
                [SVProgressHUD showErrorWithStatus:@"连接超时，请稍后再试..."];
            }
        }
        failure(error);
        NSLog(@"%@",error);
        
    }];
    
}


- (void)post:(NSString *)url params:(id)params withHUD:(BOOL)HUD  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
//    NSLog(@"%@\n%@",url,params);
    [self.httpSessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            NSError *error=nil;
            id Object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
			
            if([Object[@"code"] intValue]==200) { // 有数据成功
                success(Object);
            }else if([Object[@"code"] intValue] == 201) { // 无数据 数据成功
                success(Object);
            }else if([Object[@"code"] intValue] == 205) { // 无数据 数据成功
                failure(Object);
            }else {
                if(![Object[@"result"] isEqualToString:@""]&&[NSString isNotNULL:Object[@"result"]]) {
                    [SVProgressHUD showErrorWithStatus:Object[@"result"]];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"网络异常"];
                }
                failure(Object);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            BOOL reachable;
            reachable = [[Reachability reachabilityForInternetConnection] isReachable];
            if(!reachable) {
                [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请检查您的网络设置"];
            }else {
                [SVProgressHUD showErrorWithStatus:@"连接超时，请稍后再试..."];
            }
        }
        failure(error);
        NSLog(@"%@",error);
    }];
}


//请求数据任何不加提示
- (void)post:(NSString *)url params:(id)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
	[self.httpSessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if(success) {
			
			NSError *error=nil;
			
			id Object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
			
			if( [ Object[@"ret"] intValue] == 200 ) {
				
				success( Object[@"data"] ) ;
				
			} else {
				
				// NSLog(@"Object = %@" , Object) ;
				[ SVProgressHUD  showErrorWithStatus:Object[@"msg"] ] ;
			}
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		failure(error);
	}];
}


-(void)UpImgpost:(NSString *)url params:(UIImage *)image parameters:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);//image为要上传的图片(UIImage)

    [self.httpSessionManager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error=nil;
        id Object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if([Object[@"ret"] intValue]==200) {
            success(Object);
        }else {
            failure(Object);
        }
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


@end


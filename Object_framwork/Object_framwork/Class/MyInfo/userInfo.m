//
//  userInfo.m
//  Object_framwork
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "userInfo.h"
#import "ChangeNameVC.h"
#import "MyInfoModel.h"

@interface userInfo ()<UINavigationControllerDelegate , UIImagePickerControllerDelegate>

@property(strong , nonatomic) MyInfoModel * modelInfo ;

@end

@implementation userInfo{
    
    double top  ;
    UIImage  * img ;
    NSMutableArray * mutArray ;
    UIImageView * imgView ; //用户头像
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息" ;
    self.view.backgroundColor = MainGray;
    top = 0;
}

-(void)initSubviews{
    
    mutArray = @[].mutableCopy ;
    
    top += kNavigationBarHeight;
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    [self getViewWith:@"头像" andSubString:@"" andisImg:YES andIsClick:YES andTag:1];
    [self getViewWith:@"账号" andSubString:@"" andisImg:NO andIsClick:NO andTag:2];
    [self getViewWith:@"昵称" andSubString:@"" andisImg:NO andIsClick:YES andTag:3];
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    [self getViewWith:@"生日" andSubString:@"" andisImg:NO andIsClick:YES andTag:4];
    [self getViewWith:@"性别" andSubString:@"" andisImg:NO andIsClick:YES andTag:5];
    [self getViewWith:@"地区" andSubString:@"" andisImg:NO andIsClick:YES andTag:6];
    [self getViewWith:@"名片" andSubString:@"" andisImg:NO andIsClick:YES andTag:7];
    [self getViewWith:@"联系方式" andSubString:@"" andisImg:NO andIsClick:YES andTag:8];
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
//    [self getViewWith:@"上次登录时间" andSubString:@"20:20:20 20:20:20" andisImg:NO andIsClick:NO andTag:6];
//    [self getViewWith:@"注册时间" andSubString:@"20:20:20 20:20:20" andisImg:NO andIsClick:NO andTag:7];
    
    UILabel * tishiLabel = [ QuickCreatUI creatUILabelWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 30) andText:@"以上内容修改后将不能再次修改" andStringColor:[UIColor redColor] andFont:13] ;
    [tishiLabel sizeToFit];
    tishiLabel.centerX = self.view.centerX ;
    tishiLabel.top = top + lrPad ;
    tishiLabel.textAlignment = NSTextAlignmentCenter ;
    tishiLabel.width += 10 ;
    tishiLabel.height += 5 ;
    
    UIImageView * icon = [ QuickCreatUI creatUIImageViewWithSuperView:self.view andFrame:CGRectMake(0, 0, 15, 15) andImg:@"icon_tabbar_uikit"] ;
    icon.centerY = tishiLabel.centerY ;
    icon.right = tishiLabel.left - 5 ;
    
}

-(void)getViewWith:(NSString *)title andSubString:(NSString*)subString andisImg:(BOOL)isImge andIsClick:(BOOL)isClick andTag:(NSInteger)tag{
    
    UIView * backView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 44) color:[UIColor whiteColor]] ;
    backView.tag = tag ;
    [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:title andStringColor:twoBlaceFont andFont:14];
    
    if (isImge) {
        
        UIImageView * iamge = [ QuickCreatUI creatUIImageViewWithSuperView:backView andFrame:CGRectMake(0, 4, 36, 36) andImg:@"banner"] ;
        [iamge viewCornersWith:18.0];
        iamge.right = WIDTH - lrPad ;
        imgView = iamge ;
        
    }else{
        
        UILabel * tralingLabel = [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:subString andStringColor:oneBlaceFont andFont:14];
        tralingLabel.textAlignment = NSTextAlignmentRight;
        
        if (isClick) {
            
            UIImageView * icon = [QuickCreatUI creatUIImageViewWithSuperView:backView andFrame:CGRectMake(0, 0, 7, 12) andImg:@"tuikuan_gengduo"];
            icon.centerY = 22 ;
            icon.right = WIDTH - lrPad ;
            tralingLabel.right = icon.left - 10 ;
            
        }
        [mutArray addObject:tralingLabel];
    }
    
    if (isClick) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenu:)];
        [backView addGestureRecognizer:tap];
        
    }
    
    UIView * lineView = [QuickCreatUI creatUIViewWithSuperView:backView andFrame:CGRectMake(0, 0, WIDTH, 1) color:MainGray];
    lineView.bottom = backView.height ;
    
    top += 44 ;

}

/*
 * 点击菜单选项
 */
-(void)clickMenu:(UITapGestureRecognizer *)sender{
    
    UIView * view = sender.view;
    NSInteger tag = view.tag ;
    NSLog(@" tag = %ld",tag) ;
    if( tag == 1 ){ // 点击了 头像
        
        [self doUploadPicture];
        return;
    }
    
    if (tag == 5) { //点击了 性别
        
        UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"选择性别" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
         UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"男性" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             UILabel * label = self->mutArray[3] ;
             label.text = @"男性" ;
             [self upSexInfo:@"1"];
         }];
         [alertContro addAction:picAction];
         UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"女性" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             UILabel * label = self->mutArray[3] ;
             label.text = @"女性" ;
             [self upSexInfo:@"2"];
         }];
         [alertContro addAction:photoAction];
        UIAlertAction *baomi = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UILabel * label = self->mutArray[3] ;
            label.text = @"保密" ;
            [self upSexInfo:@"0"];
        }];
        [alertContro addAction:baomi];
         UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         }];
         [alertContro addAction:cancleAction];

         [self presentViewController:alertContro animated:YES completion:nil];
        
        return;
    }
    
    if( tag != 2 ){// 点击了修改昵称
    
        MyPushVC([[ChangeNameVC alloc] initWith:tag - 2]);
    }
}

-(void)upSexInfo:(NSString *)sex{
    
       NSDictionary *   para = @{
           @"user_nicename":[UserInfoManaget sharedInstance].infoModel.user_nicename,
           @"sex":sex,
           @"signature":[UserInfoManaget sharedInstance].infoModel.signature,
           @"birthday":[UserInfoManaget sharedInstance].infoModel.birthday,
           @"location":[UserInfoManaget sharedInstance].infoModel.location
        };
        
        NSDictionary * params = @{
               @"uid":[UserInfoManaget sharedInstance].model.id ,
               @"token":[UserInfoManaget sharedInstance].model.token ,
               @"fields":[para yy_modelToJSONString]
           };
           [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:UpdateFields] params:params withHUD:NO success:^(id json) {
               
               NSArray * dataArr = json[@"data"][@"info"];
               NSDictionary * dict = dataArr.firstObject ;
               [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];

           } failure:^(NSError *error) {


           }];
}

//选择封面
-(void)doUploadPicture{
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"选择上传方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectThumbWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertContro addAction:picAction];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectThumbWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertContro addAction:photoAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:cancleAction];

    [self presentViewController:alertContro animated:YES completion:nil];
}
- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = type;
    imagePickerController.allowsEditing = YES;
    if (type == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.showsCameraControls = YES;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"])
        {
            //先把图片转成NSData
            UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
            self->img = image;
            self->imgView.image = self->img ;
            [self upImage:self->img];
            NSLog(@"threen = %@",[NSThread currentThread]) ;
        NSLog(@"选择了 照片");
        }
    });
   
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.width < 42) {
                [viewController.view sendSubviewToBack:obj];
                *stop = YES;
            }
        }];
    }
}


-(void)upImage:(UIImage *)img{
    
    [[ZKHttpTool shareInstance] UpImgpost:[ZKSeriverBaseURL  getUrlType:UpdateAvatar] params:img parameters:@{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token
    } success:^(id json) {
       
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * data = dataArr.firstObject;
        
        [self->imgView sd_setImageWithURL:[NSURL URLWithString:data[@"avatar_thumb"]]];
        
        NSLog(@"json = %@", json) ;
        
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@" , error) ;
    }];
}


/*
 * 获取用户 - 信息
 */
-(void)getUserInfo{
    
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:GetBaseInfo] params:@{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
        @"version_ios":@"1",
    } withHUD:NO success:^(id json) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray * dataArr = json[@"data"][@"info"];
            NSDictionary * dict = dataArr.firstObject ;
            self.modelInfo = [MyInfoModel yy_modelWithJSON:dict ];
            [UserInfoManaget sharedInstance].infoModel = self.modelInfo ;
            [self->imgView sd_setImageWithURL:[NSURL URLWithString:self.modelInfo.avatar]];
            
            for (int i = 0; i< self->mutArray.count ; i++) {
                
                UILabel * label = self->mutArray[i] ;
                
                if (i == 0) {
                    label.text = self.modelInfo.id ;
                }else if (i == 1){
                    label.text = self.modelInfo.user_nicename ;
                }else if (i == 2){
                    label.text = self.modelInfo.birthday ;
                }else if (i == 3){
                    label.text = [self.modelInfo.sex isEqualToString: @"0"] ? [self.modelInfo.sex isEqualToString: @"1"] ? @"男" : @"女" : @"保密";
                }else if (i == 4){
                    label.text = self.modelInfo.location ;
                }else if (i == 5){
                    label.text = self.modelInfo.signature;
                }else if (i == 6){
                    label.text = self.modelInfo.contact;
                }
                
            }
            NSLog(@"user info threen = %@",[NSThread currentThread]) ;
        });
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    
    [self getUserInfo];
}


@end

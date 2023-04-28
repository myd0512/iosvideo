//
//  OpenLiveBroadVC.m
//  Object_framwork
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.
//

#import "OpenLiveBroadVC.h"
#import "LiveingVC.h"
#import "gameselected.h"
#import "coastselectview.h"
#import "startLiveClassVC.h"
#import "LiveingModel.h"




@interface OpenLiveBroadVC ()<gameselected,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(strong , nonatomic) NSMutableArray * titleMutArr ; // 右标题 - titleArr


@end

@implementation OpenLiveBroadVC{
    double top ;
    NSInteger gameType ;
    UILabel * gamenamelabel ;
    UIImageView * gameImg ;
    
    UITextField * textTitle ;
    UIImage * fmImg ; //  封面img
    UIImageView * fmImageView ; //  封面imgView
    
    UIScrollView *roomTypeView;//选择房间类型
       NSMutableArray *roomTypeBtnArray;//房间类型按钮
       NSString *roomType;//房间类型
       NSString *roomTypeValue;//房间价值
    
    coastselectview * coastview;//价格选择列表
    NSString *coastmoney;//收费价
    
    UIView * _preFrontView;
    NSString * liveClassID ; // 直播分类信息
    
}

- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}

-(BOOL)fd_interactivePopDisabled{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = MainGray;
    top = 0 ;
    gameType = 1 ;
}

-(void)initSubviews{

    
    [self layoutFirstView ];
    top += kNavigationBarHeight + 80;
    self.titleMutArr = @[].mutableCopy;
    roomType = @"0";
    roomTypeValue = @"";
    liveClassID = @"0";
    gameType = 1;
    
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    [self getViewWith:@"直播标题" andSubString:@"" andiSHaveTextInput:YES andIsClick:NO andTag:1];
//    [self getViewWith:@"地区选择" andSubString:@"未设置" andiSHaveTextInput:NO andIsClick:YES andTag:2];
    [self getViewWith:@"房间类型" andSubString:@"普通房间" andiSHaveTextInput:NO andIsClick:YES andTag:3];
//    [self getViewWith:@"直播性质" andSubString:@"绿色直播" andiSHaveTextInput:NO andIsClick:YES andTag:4];
    [self getViewWith:@"直播路线" andSubString:@"线路1(默认)" andiSHaveTextInput:NO andIsClick:YES andTag:5];
    [self getViewWith:@"直播质量" andSubString:@"标清(默认540p)" andiSHaveTextInput:NO andIsClick:YES andTag:6];
    [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 10) color:MainGray];
    top += 10 ;
    [self getViewWith:@"直播分类" andSubString:@"未选择" andiSHaveTextInput:NO andIsClick:YES andTag:7];
//    [self getViewWith:@"名片设置" andSubString:@"未设置" andiSHaveTextInput:NO andIsClick:YES andTag:8];
    [self getBottomView];
    _preFrontView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, HEIGHT, WIDTH, HEIGHT) color:[UIColor colorWithWhite:0.5 alpha:0.5]] ;
    
    
    // 设置 上一次开播的图片和标题
    UIImage * img = [self getImage];
    if (img) {
        fmImg = img ;
        fmImageView.image = img ;
    }
    
    NSString * openClassid = [[NSUserDefaults standardUserDefaults] objectForKey:@"openClassID"];
    NSString * openClassname = [[NSUserDefaults standardUserDefaults] objectForKey:@"openName"];
    if ( ![FWUtils isBlankString:openClassid ] && ![FWUtils isBlankString:openClassname ]) {
        self->liveClassID = minstr(openClassid);
        UILabel * label =  self.titleMutArr[3];
        label.text = minstr(openClassname);
    }
    
    NSString * openTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"opentitle"];
    if ( ![FWUtils isBlankString:openTitle ] ) {
        textTitle.text = openTitle ;
    }
    
}

/*
 * 布局 第一排
 */
-(void)layoutFirstView{
    
    UIView * topbackView = [QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, 0, WIDTH, 80 + kNavigationBarHeight) color: kWhiteColor] ;
    
    UIButton * backBtn = [QuickCreatUI creatUIButtonWithSuperView:topbackView andFrame:CGRectMake(0, kStatusBarHeight, 44, 44) andText:@"❌" andStringColor:[UIColor blackColor] andFont:15 andTarget:self SEL:@selector(clickbackBtn)];
    backBtn.right = WIDTH - 15 ;
    
    double itemW = WIDTH / 2 ;
    double itemH = 80 ;
    NSArray * titleArr = @[@"一分快三",@"封面设置"];
    NSArray * imgArr = @[@"oneFencai",@"ic_change_cover"];
    for (int i = 0; i < titleArr.count ; i++ ) {
        
        UIView * itemView = [QuickCreatUI creatUIViewWithSuperView:topbackView andFrame:CGRectMake(i*itemW, kNavigationBarHeight, itemW, itemH) color:kWhiteColor];
        
        UIImageView * imageView = [ QuickCreatUI creatUIImageViewWithSuperView:itemView andFrame:CGRectMake(0, 0, 50, 50) andImg:imgArr[i]];
        [imageView viewCornersWith:25];
        imageView.centerX = itemW / 2;
        UILabel * titleLabel = [ QuickCreatUI creatUILabelWithSuperView:itemView andFrame:CGRectMake(0, imageView.bottom, itemW, 30) andText:titleArr[i] andStringColor:oneBlaceFont andFont:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i == 0) {
            gamenamelabel = titleLabel ;
            gameImg = imageView ;
        }else if (i == 1) {
            fmImageView = imageView ;
        }
        
        [QuickCreatUI creatUIControlWithSuperView:itemView tag:i andTarget:self SEL:@selector(clickTopMenu:)];
        
    }
}

/*
 * 设置 点击菜单
 */
-(void)clickTopMenu:(UIControl *)control{
    
    NSLog( @"tag = %ld" , (long)control.tag) ;
    
    [self.view endEditing:YES];
    
    if( control.tag == 0 ){// 选择游戏
        
        gameselected * view = [[gameselected alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)] ;
        view.delegate = self ;
        [self.view addSubview:view] ;
    
      }
      else if( control.tag == 1 ){// 点击了 封面
          
          [self doUploadPicture];
      }
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
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        fmImg = image;
        fmImageView.image = image ;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
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


-(void)clickbackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 点击 - 选择游戏 种类
 */
-(void)gameselect:(NSInteger)gameselectaction andImag:(NSString *)imgString andTitle:(NSString *)name{
    
    gameType = gameselectaction ;
    gamenamelabel.text = name ;
    gameImg.image = [ UIImage imageNamed:imgString] ;

    NSLog(@"gameselectaction = %ld", (long)gameselectaction);
}

-(void)getViewWith:(NSString *)title andSubString:(NSString*)subString andiSHaveTextInput:(BOOL)isHaveTextInput andIsClick:(BOOL)isClick andTag:(NSInteger)tag{
    
    UIView * backView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top, WIDTH, 44) color:[UIColor whiteColor]] ;
    backView.tag = tag ;
    [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:title andStringColor:twoBlaceFont andFont:14];
    
    if (isHaveTextInput) {
        
        UITextField * textfield = [[ UITextField alloc] initWithFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, 44)];
        textfield.textAlignment = NSTextAlignmentRight;
        textfield.placeholder = @"请设置您的直播标题";
        textfield.font = [UIFont systemFontOfSize:15];
        [backView addSubview:textfield];
        textfield.right = WIDTH - lrPad ;
        textTitle = textfield;
        
    }else{
        
        UILabel * tralingLabel = [ QuickCreatUI creatUILabelWithSuperView:backView andFrame:CGRectMake(lrPad, 0, WIDTH - 2*lrPad, backView.height) andText:subString andStringColor:oneBlaceFont andFont:14];
        tralingLabel.textAlignment = NSTextAlignmentRight;
        
        if (tag == 4) {
            
            tralingLabel.textColor = kGreenColor ;
        }
        if ( tag == 5 || tag == 6 ) {
            
            tralingLabel.textColor = kGrayColor ;
        }
        
        UIImageView * icon = [QuickCreatUI creatUIImageViewWithSuperView:backView andFrame:CGRectMake(0, 0, 7, 12) andImg:@"tuikuan_gengduo"];
        icon.centerY = 22;
        icon.right = WIDTH - lrPad ;
        tralingLabel.right = icon.left - 10 ;
        [self.titleMutArr addObject:tralingLabel];
        
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
    
    [self.view endEditing:YES];
    
    NSLog(@" tag = %ld",(long)tag) ;
    
    if( tag == 3 ){// 点击了 房间类型
        [self dochangelivetype];
    }else if( tag == 4 ){// 点击了 直播性质
        
        UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"选择直播性质" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
           UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"绿色直播" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               UILabel * titleLabel = self.titleMutArr[1];
               titleLabel.text = @"绿色直播" ;
               titleLabel.textColor = kGreenColor ;
           }];
           [alertContro addAction:picAction];
           UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"成人直播" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
               UILabel * titleLabel = self.titleMutArr[1];
                            titleLabel.text = @"成人直播" ;
                            titleLabel.textColor = kRedColor ;
               
           }];
           [alertContro addAction:photoAction];
           UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           }];
           [alertContro addAction:cancleAction];

           [self presentViewController:alertContro animated:YES completion:nil];
      
    }else if( tag == 5 ){// 点击了 直播线路
        
    }else if( tag == 6 ){// 点击了 直播质量
        
    }else if( tag == 7 ){// 点击了 直播分类
        
        [self showAllClassView];
    }else if( tag == 8 ){// 点击了 名片设置
        
        
        
    }
}


-(void)dochangelivetype{

 
    if (!roomTypeView) {
        
        NSArray * titleArr = [ common  live_type ];
        NSMutableArray *roomTypeArr = [NSMutableArray array];
         
        for (NSArray * item in titleArr) {
            
            [roomTypeArr addObject:item.lastObject];
        }
//         [roomTypeArr addObject:@"普通"];
//
//         [roomTypeArr addObject:@"密码"];
//
//         [roomTypeArr addObject:@"门票"];
//
//         [roomTypeArr addObject:@"计时"];
        
        roomTypeView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEIGHT - HEIGHT*0.15 , WIDTH, HEIGHT*0.15)];
        roomTypeView.backgroundColor = RGB_COLOR(@"#000000", 0.7);
        roomTypeView.contentSize = CGSizeMake(WIDTH/4*roomTypeArr.count, 0);
        [_preFrontView addSubview:roomTypeView];
        CGFloat speace;
        if (roomTypeArr.count > 3) {
            speace = 0;
        }else{
            speace = (WIDTH-WIDTH/4*roomTypeArr.count)/2;
        }
        roomTypeBtnArray = [NSMutableArray array];
        for (int i = 0; i < roomTypeArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:0];
            btn.frame = CGRectMake(speace+i*WIDTH/4, 0, WIDTH/4, roomTypeView.height);
            [btn addTarget:self action:@selector(doRoomType:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%@",roomTypeArr[i]] forState:UIControlStateSelected];
            [btn setTitle:[NSString stringWithFormat:@"%@",roomTypeArr[i]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:normalColors forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"room_%@_nor",roomTypeArr[i]]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"room_%@_sel",roomTypeArr[i]]] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.imageEdgeInsets = UIEdgeInsetsMake(7.5, WIDTH/8-10, 22.5, 10);
            btn.titleEdgeInsets = UIEdgeInsetsMake(30, -22.5, 0, 0);

            if (i == 0) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            [roomTypeView addSubview:btn];
            [roomTypeBtnArray addObject:btn];
        }
        [UIView animateWithDuration:0.5 animations:^{
            roomTypeView.y = HEIGHT*0.85;
        }];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
            _preFrontView.top = 0 ;
    }];
    
}
- (void)doRoomType:(UIButton *)sender{
    NSLog(@"%@",sender.titleLabel.text);
    if ([sender.titleLabel.text isEqual:@"普通房间"]) {
        [self changeRoomBtnState:@"普通房间"];
        roomType = @"0";
        roomTypeValue = @"";
    }
    if ([sender.titleLabel.text isEqual:@"密码房间"]) {
        UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"请设置房间密码"    message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertContro addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {                textField.placeholder = @"请输入密码";
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertContro addAction:cancleAction];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *envirnmentNameTextField = alertContro.textFields.firstObject;
            if (envirnmentNameTextField.text == nil || envirnmentNameTextField.text == NULL || envirnmentNameTextField.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入正确的密码"];
                [self presentViewController:alertContro animated:YES completion:nil];
            }else{
                self->roomTypeValue = envirnmentNameTextField.text;
                self->roomType = @"1";
                [self changeRoomBtnState:@"密码房间"];
            }
        }];
        [alertContro addAction:sureAction];
        [self presentViewController:alertContro animated:YES completion:nil];
    }
    if ([sender.titleLabel.text isEqual:@"门票房间"]) {
        UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"请设置房间门票价格"    message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertContro addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {                textField.placeholder = @"请输入价格";
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertContro addAction:cancleAction];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *envirnmentNameTextField = alertContro.textFields.firstObject;
            if (envirnmentNameTextField.text == nil || envirnmentNameTextField.text == NULL || envirnmentNameTextField.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入正确的门票价格"];
                [self presentViewController:alertContro animated:YES completion:nil];
            }else{
                self->roomTypeValue = envirnmentNameTextField.text;
                self->roomType = @"2";
                [self changeRoomBtnState:@"门票房间"];
                [self changeRoomBtnState:[NSString stringWithFormat:@"门票房间(价格%@)",self->roomTypeValue]];
            }
        }];
        [alertContro addAction:sureAction];
        [self presentViewController:alertContro animated:YES completion:nil];

    }
    if ([sender.titleLabel.text isEqual:@"计时房间"]) {
            
            UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"设置收费金额(每10分钟)"    message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alertContro addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {                textField.placeholder = @"请输入价格/10分钟";
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }];
            
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertContro addAction:cancleAction];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *envirnmentNameTextField = alertContro.textFields.firstObject;
                if (envirnmentNameTextField.text == nil || envirnmentNameTextField.text == NULL || envirnmentNameTextField.text.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"设置收费金额(每10分钟)"];
                    [self presentViewController:alertContro animated:YES completion:nil];
                }else{
                    self->roomTypeValue = envirnmentNameTextField.text;
                    self->roomType = @"3";
                    [self changeRoomBtnState:[NSString stringWithFormat:@"计时房间(%@/10分钟)",self->roomTypeValue]];
                }
            }];
            [alertContro addAction:sureAction];
            [self presentViewController:alertContro animated:YES completion:nil];
            
    //        [self doupcoast];
        }
    
    [UIView animateWithDuration:0.2 animations:^{
            _preFrontView.top = HEIGHT ;
    }];
}

// 弹出收费弹窗
-(void)doupcoast{

    if (!coastview) {
        coastview = [[coastselectview alloc]initWithFrame:CGRectMake(0, -HEIGHT, WIDTH, HEIGHT) andsureblock:^(NSString *type) {
         
                roomType = @"3";
                roomTypeValue = type;
                [self changeRoomBtnState:@"计时房间"];
                [self hidecoastview];
            
//            else{
//                coastmoney = type;
//                [SVProgressHUD showWithStatus:@""];
//                //Live.changeLiveType
//                NSDictionary *subdic = @{
//                                         @"stream":urlStrtimestring,
//                                         @"type":@"3",
//                                         @"type_val":coastmoney
//                                         };
//                [YBToolClass postNetworkWithUrl:@"Live.changeLiveType" andParameter:subdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                    [MBProgressHUD hideHUD];
//
//                    if (code == 0) {
//
//                        [MBProgressHUD hideHUD];
//                        [MBProgressHUD showError:msg];
//                        [socketL changeLiveType:coastmoney];
//                        //收费金额
//                        [self hidecoastview];
//                    }
//
//                } fail:^{
//                    [SVProgressHUD dismiss];
//                }];
//            }
        } andcancleblock:^(NSString *type) {
            //取消
            [self hidecoastview];
        }];
        [self.view addSubview:coastview];
    }
    [UIView animateWithDuration:0.3 animations:^{
        coastview.frame = CGRectMake(0,0, WIDTH, HEIGHT);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1 animations:^{
            coastview.frame = CGRectMake(0,20,WIDTH, HEIGHT);
        }];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1 animations:^{
            coastview.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        }];
    });
    coastview.userInteractionEnabled = YES;
}

-(void)hidecoastview{
    [UIView animateWithDuration:0.3 animations:^{
        coastview.frame = CGRectMake(0, -HEIGHT, WIDTH, HEIGHT);
    }];
}

- (void)changeRoomBtnState:(NSString *)roomName{
    UILabel * titleLabel = self.titleMutArr[0] ;
    titleLabel.text = roomName ;
}

/*
 * 获取 底部按钮
 */
-(void)getBottomView{
    
    UIView * bottomView = [ QuickCreatUI creatUIViewWithSuperView:self.view andFrame:CGRectMake(0, top + 15, WIDTH - 100, 44) color:kWhiteColor] ;
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.colors = @[(__bridge id)RGB(249, 144, 58).CGColor,(__bridge id)RGB(252  , 79, 124).CGColor];

    //    位置x,y    自己根据需求进行设置   使其从不同位置进行渐变
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(bottomView.frame), CGRectGetHeight(bottomView.frame));
        [bottomView.layer addSublayer:gradientLayer];
    
    [bottomView viewCornersWith:22];
    
    bottomView.centerX = WIDTH / 2 ;
    
    UILabel * openLabel = [ QuickCreatUI creatUILabelWithSuperView:bottomView andFrame:bottomView.bounds andText:@"开始直播" andStringColor:kWhiteColor andFont:15  ];
    openLabel.textAlignment = NSTextAlignmentCenter;
    
//    UIView * lineView = [ QuickCreatUI creatUIViewWithSuperView:bottomView andFrame:CGRectMake(0, 0, 1.5, 36) color:kWhiteColor  ] ;
//    lineView.centerY = 22 ;
//    lineView.right = bottomView.width - 60 ;
//
//    UILabel * ylLabel = [ QuickCreatUI creatUILabelWithSuperView:bottomView andFrame:CGRectMake(0, 0, 60, 44) andText:@"预览" andStringColor:kWhiteColor andFont:14];
//    ylLabel.textAlignment = NSTextAlignmentCenter ;
//    ylLabel.left = lineView.right ;
    
    UILabel * tishiLabel = [ QuickCreatUI creatUILabelWithSuperView:self.view andFrame:CGRectMake(0, bottomView.bottom + 10, WIDTH, 20) andText:@"提示: 请关闭手机后台运行的程序,以保证直播流畅" andStringColor:twoBlaceFont andFont:13] ;
    tishiLabel.textAlignment = NSTextAlignmentCenter ;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickKaiBo:)];
    [bottomView addGestureRecognizer:tap];
    
//    UITapGestureRecognizer * tapyl = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicktapyl)];
//    [ylLabel addGestureRecognizer:tapyl];
    
}

/*
 * 开播
 */
-(void)clickKaiBo:(UITapGestureRecognizer *)sender{

    UIView * vi = sender.view ;
    
    [self.view endEditing:YES];
    vi.userInteractionEnabled = NO ;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           vi.userInteractionEnabled = YES;
       });
    
    if (textTitle.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善开播信息后,重新尝试"];
        return;
    }
    
    if ( !fmImg ) {
        fmImg = [UIImage imageNamed:@"defultAll.png"];
    }
    
    //弹出相机权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (!granted) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"权限受阻" message:@"请在设置中开启相机权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }];
    //弹出麦克风权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (!granted) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"权限受阻" message:@"请在设置中开启麦克风权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        }
    }];
    
    [SVProgressHUD showWithStatus:@"开播中~"];
    
    //开播前保存 - 开播的数据信息
    [[NSUserDefaults standardUserDefaults] setObject:minstr(textTitle.text) forKey:@"opentitle"];
    [self saveImage:fmImg];
    
    [[ZKHttpTool shareInstance] UpImgpost:[ZKSeriverBaseURL  getUrlType:CreateRoom] params:fmImg parameters:@{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token,
        @"user_nicename":[UserInfoManaget sharedInstance].model.user_nicename,
        @"avatar":[UserInfoManaget sharedInstance].model.avatar,
        @"title":textTitle.text,
        @"province":@"",
        @"city":@"",
        @"lng":@"",
        @"lat":@"",
        @"type":roomType,
        @"type_val":roomTypeValue,
        @"liveclassid":liveClassID,
        @"game_id":@(gameType),
    } success:^(id json) {

        [SVProgressHUD dismiss];
        NSLog(@"json = %@" , json) ;
        
        NSArray * dataArr = json[@"data"][@"info"];
        if (dataArr.count != 0) {
            
            LiveingModel * model = [LiveingModel yy_modelWithJSON:dataArr.firstObject];
            model.gameID = self->gameType ;
            model.gameName = self->gamenamelabel.text ;
            [UserInfoManaget sharedInstance].gameInfoModel = model;
            LiveingVC * VC =  [[LiveingVC alloc] initWithUrlString:model] ;
            VC.dictModel = dataArr.firstObject;
            MyPushVC(VC);
            
        }else{
            
            [ SVProgressHUD  showErrorWithStatus:json[@"data"][@"msg"] ] ;
        }

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"error = %@" , error) ;
    }];
}


//选择频道
- (void)showAllClassView{
    
    startLiveClassVC *vc = [[startLiveClassVC alloc]init];
    vc.classID = liveClassID;
    vc.block = ^(NSDictionary * _Nonnull dic) {
        
        self->liveClassID = minstr([dic valueForKey:@"id"]);
        UILabel * label =  self.titleMutArr[3];
        label.text = minstr([dic valueForKey:@"name"]);
        [[NSUserDefaults standardUserDefaults] setObject:minstr([dic valueForKey:@"id"]) forKey:@"openClassID"];
        [[NSUserDefaults standardUserDefaults] setObject:minstr([dic valueForKey:@"name"]) forKey:@"openName"];
    };
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
    
}



- (UIImage *)getImage {

    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"demo.png"]];
// 保存文件的名称
    UIImage*img = [UIImage imageWithContentsOfFile:filePath];
    
    return img;
    NSLog(@"=== %@", img);
}

- (void)saveImage:(UIImage*)image {

    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"demo.png"]];// 保存文件的名称

    BOOL result =[UIImagePNGRepresentation(image) writeToFile:filePath
                                                   atomically:YES];// 保存成功会返回YES
    
    if(result ==YES) {
        
        NSLog(@"保存成功");
    }
}

@end

//
//  myProfitVC.m
//  yunbaolive
//
//  Created by Boom on 2018/9/26.
//  Copyright © 2018年 cat. All rights reserved.
//

#import "myProfitVC.h"
#import "profitTypeVC.h"
@interface myProfitVC (){
    UILabel *allVotesL;
    UILabel *nowVotesL;
    UITextField *votesT;
    UILabel *moneyLabel;
    UILabel *typeLabel;
    double cash_rate;
    UIButton *inputBtn;
    UILabel *tipsLabel;
    NSDictionary *typeDic;
    UIImageView *seletTypeImgView;
}

@end

@implementation myProfitVC

- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}

-(void)navtion{
    UIView *navtion = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _window_width, 64 + kStatusBarHeight)];
    navtion.backgroundColor =kWhiteColor;
    UILabel *label = [[UILabel alloc]init];
    label.text = _titleStr;
    [label setFont:[UIFont systemFontOfSize:18]];
    label.textColor = kBlackColor;
    label.frame = CGRectMake(0, kStatusBarHeight,_window_width,84);
    label.textAlignment = NSTextAlignmentCenter;
    [navtion addSubview:label];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *bigBTN = [[UIButton alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, _window_width/2, 64)];
    [bigBTN addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
    [navtion addSubview:bigBTN];
    returnBtn.frame = CGRectMake(8,24 + kStatusBarHeight,40,40);
    returnBtn.imageEdgeInsets = UIEdgeInsetsMake(12.5, 0, 12.5, 25);
    [returnBtn setImage:[UIImage imageNamed:@"icon_arrow_leftsssa.png"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
    [navtion addSubview:returnBtn];
    UIButton *btnttttt = [UIButton buttonWithType:UIButtonTypeCustom];
    btnttttt.backgroundColor = [UIColor clearColor];
    [btnttttt addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
    btnttttt.frame = CGRectMake(0,0,100,64);
    [navtion addSubview:btnttttt];
    
    
//    UIButton *historyBtn = [UIButton buttonWithType:0];
//    historyBtn.frame = CGRectMake(_window_width-75, 24+kStatusBarHeight, 65, 40);
//    [historyBtn setTitle:@"提现记录" forState:0];
//    [historyBtn setTitleColor:[UIColor grayColor] forState:0];
//    historyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [historyBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [navtion addSubview:historyBtn];

    [[YBToolClass sharedInstance] lineViewWithFrame:CGRectMake(0, navtion.height-1, _window_width, 1) andColor:RGB(244, 245, 246) andView:navtion];
    [self.view addSubview:navtion];
}
- (void)addBtnClick:(UIButton *)sender{
//    YBWebViewController *web = [[YBWebViewController alloc]init];
//    web.urls = [NSString stringWithFormat:@"%@/index.php?g=Appapi&m=cash&a=index&uid=%@&token=%@",h5url,[],[Config getOwnToken]];
//    [self.navigationController pushViewController:web animated:YES];
}
-(void)doReturn{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(244, 245, 246);
    cash_rate = 0.7 ;
    [self navtion];
    [self creatUI];
    [self requestData];
}
- (void)requestData{
    
    [[ ZKHttpTool shareInstance ] get:[ZKSeriverBaseURL getUrlType:GetProfit] params:@{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
    } withHUD:NO success:^(id json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
        NSDictionary * dict = dataArr.firstObject ;
        
        //获取收益
        nowVotesL.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"votes"]];
        //            self.withdraw.text = [NSString stringWithFormat:@"%@",[[info firstObject] valueForKey:@"todaycash"]];
//        cash_rate = [minstr([dict valueForKey:@"cash_rate"]) doubleValue];
        NSString *tips = minstr([dict valueForKey:@"tips"]);
        CGFloat height = [[YBToolClass sharedInstance] heightOfString:tips andFont:[UIFont systemFontOfSize:11] andWidth:_window_width*0.7-30];
        tipsLabel.text = tips;
        tipsLabel.height = height;
        
    } failure:^(NSError *error) {
        
        
    }] ;
    
}
- (void)tapClick{
    [votesT resignFirstResponder];
}
- (void)creatUI{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    
    //黄色背景图
    UIImageView *backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_window_width*0.04, 64+kStatusBarHeight+10, _window_width*0.92, _window_width*0.92*24/69)];
    backImgView.image = [UIImage imageNamed:@"profitBg"];
    [self.view addSubview:backImgView];
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, backImgView.height/4*(i + 1), backImgView.width, backImgView.height/4)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        if (i== 0) {
            
            label.text = [NSString stringWithFormat:@"%@%@%@",@"可提取",moneyNameInfo,@"数"];
    
        }else{
            label.font = [UIFont boldSystemFontOfSize:22];
            label.text = @"0";
            nowVotesL = label;
        }
        [backImgView addSubview:label];
    }
    //输入提现金额的视图
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(backImgView.left, backImgView.bottom+10, backImgView.width, backImgView.height)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.cornerRadius = 5.0;
    textView.layer.masksToBounds = YES;
    [self.view addSubview:textView];
    NSArray *arr = @[[NSString stringWithFormat:@"%@%@%@",@"输入要提取的",moneyNameInfo,@"数"],@"可到账金额"];
    for (int i = 0; i<2; i++) {
        CGFloat labelW = [[YBToolClass sharedInstance] widthOfString:arr[i] andFont:[UIFont systemFontOfSize:15] andHeight:textView.height/2];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(textView.width*0.05, textView.height/2*i, labelW+20, textView.height/2)];
        label.textColor = RGB_COLOR(@"#333333", 1);
        label.font = [UIFont systemFontOfSize:15];
        label.text = arr[i];
        [textView addSubview:label];
        if (i == 0) {
            [[YBToolClass sharedInstance] lineViewWithFrame:CGRectMake(textView.width*0.05, textView.height/2-0.5, textView.width*0.9, 1) andColor:RGB(244, 245, 246) andView:textView];
            votesT = [[UITextField alloc]initWithFrame:CGRectMake(label.right, 0, textView.width*0.95-label.right, textView.height/2)];
            votesT.textColor = normalColors;
            votesT.font = [UIFont boldSystemFontOfSize:17];
            votesT.placeholder = @"0";
            votesT.keyboardType = UIKeyboardTypeNumberPad;
            [textView addSubview:votesT];
        }else{
            moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(label.right, label.top, textView.width*0.95-label.right, textView.height/2)];
            moneyLabel.textColor = [UIColor redColor];
            moneyLabel.font = [UIFont boldSystemFontOfSize:17];
            moneyLabel.text = @"¥0";
            [textView addSubview:moneyLabel];
        }
    }
    
    //选择提现账户
    
    UIView *typeView = [[UIView alloc]initWithFrame:CGRectMake(backImgView.left, textView.bottom+10, backImgView.width, 50)];
    typeView.backgroundColor = [UIColor whiteColor];
    typeView.layer.cornerRadius = 5.0;
    typeView.layer.masksToBounds = YES;
    [self.view addSubview:typeView];
    typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(textView.width*0.05, 0, typeView.width*0.95-40, 50)];
    typeLabel.textColor = RGB_COLOR(@"#333333", 1);
    typeLabel.font = [UIFont systemFontOfSize:15];
    typeLabel.text = @"请选择提现账户";
    [typeView addSubview:typeLabel];
    seletTypeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(typeLabel.left, 15, 20, 20)];
    seletTypeImgView.hidden = YES;
    [typeView addSubview:seletTypeImgView];
    
    UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(typeView.width-30, 18, 14, 14)];
    rightImgView.image = [UIImage imageNamed:@"person_right"];
    rightImgView.userInteractionEnabled = YES;
    [typeView addSubview:rightImgView];

    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(0, 0, typeView.width, typeView.height);
    [btn addTarget:self action:@selector(selectPayType) forControlEvents:UIControlEventTouchUpInside];
    [typeView addSubview:btn];
    
    inputBtn = [UIButton buttonWithType:0];
    inputBtn.frame = CGRectMake(_window_width*0.15, typeView.bottom + 30, _window_width*0.7, 30);
    [inputBtn setBackgroundColor:RGB_COLOR(@"#dcdcdc", 1)];
    [inputBtn setTitle:@"立即提现" forState:0];
    [inputBtn addTarget:self action:@selector(inputBtnClick) forControlEvents:UIControlEventTouchUpInside];
    inputBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    inputBtn.layer.cornerRadius = 15;
    inputBtn.layer.masksToBounds = YES;
    inputBtn.userInteractionEnabled = NO;
    [self.view addSubview:inputBtn];
    
    tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(inputBtn.left+15, inputBtn.bottom + 15, inputBtn.width-30, 100)];
    tipsLabel.font = [UIFont systemFontOfSize:11];
    tipsLabel.textColor = RGB_COLOR(@"#666666", 1);
    tipsLabel.numberOfLines = 0;
    [self.view addSubview:tipsLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeMoenyLabelValue) name:UITextFieldTextDidChangeNotification object:nil];

}
//选择z提现方式
- (void)selectPayType{
    profitTypeVC *vc = [[profitTypeVC alloc]init];
    if (typeDic) {
        vc.selectID = minstr([typeDic valueForKey:@"id"]);
    }else{
        vc.selectID = @"未选择提现方式";
    }
    vc.block = ^(NSDictionary * _Nonnull dic) {
        typeDic = dic;
        seletTypeImgView.hidden = NO;
        typeLabel.x = seletTypeImgView.right + 5;
        int type = [minstr([dic valueForKey:@"type"]) intValue];
        switch (type) {
            case 1:
                seletTypeImgView.image = [UIImage imageNamed:@"profit_alipay"];
                typeLabel.text = [NSString stringWithFormat:@"%@(%@)",minstr([dic valueForKey:@"account"]),minstr([dic valueForKey:@"name"])];
                break;
            case 2:
                seletTypeImgView.image = [UIImage imageNamed:@"profit_wx"];
                typeLabel.text = [NSString stringWithFormat:@"%@",minstr([dic valueForKey:@"account"])];

                break;
            case 3:
                seletTypeImgView.image = [UIImage imageNamed:@"profit_card"];
                typeLabel.text = [NSString stringWithFormat:@"%@(%@)",minstr([dic valueForKey:@"account"]),minstr([dic valueForKey:@"name"])];
                break;
                
            default:
                break;
        }

    };
    [self.navigationController pushViewController:vc animated:YES];
}
//提交申请
- (void)inputBtnClick{
    if(!typeDic){
        [SVProgressHUD showErrorWithStatus:@"请选择提现账号"];
        return;
    }
    
    NSDictionary * params = @{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
        @"accountid":minstr([typeDic valueForKey:@"id"]),@"cashvote":votesT.text  ,
    } ;
    
    NSLog(@"params = %@" , params  ) ;
   
    [[ ZKHttpTool shareInstance ] get:[ZKSeriverBaseURL getUrlType:SetCash] params:params withHUD:NO success:^(id json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
              
        if ([json[@"data"][@"code"] intValue] == 0) {

            votesT.text = @"";
            [SVProgressHUD showSuccessWithStatus:json[@"data"][@"msg"]];
            [self requestData];

        }else{
            [SVProgressHUD showErrorWithStatus:json[@"data"][@"msg"]];
        }
        
    } failure:^(NSError *error) {
        

    }] ;
    
}
- (void)ChangeMoenyLabelValue{
    moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[votesT.text longLongValue]*cash_rate];
    if ([[NSString stringWithFormat:@"%.2f",[votesT.text longLongValue]*cash_rate] integerValue] > 0) {
        inputBtn.userInteractionEnabled = YES;
        [inputBtn setBackgroundColor:normalColors];
    }else{
        inputBtn.userInteractionEnabled = NO;
        [inputBtn setBackgroundColor:RGB_COLOR(@"#dcdcdc", 1)];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

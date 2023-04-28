//
//  PayInfoView.m
//  Object_framwork
//
//  Created by 高通 on 2019/8/16.
//  Copyright © 2019 www.zzwanbei.com. All rights reserved.
//

#import "PayInfoView.h"
#import "SHPasswordTextView.h"

@interface PayInfoView ()


@property( strong , nonatomic ) UIView * tapOne ;

@property( strong , nonatomic ) UIView * tapTwo ;

@property( strong , nonatomic ) UIButton * aliPayBtn ; // 支付宝按钮

@property( strong , nonatomic ) UIButton * weiXinBtn ; //  微信按钮

@property( strong , nonatomic ) UIButton * yuEBtn ; //  微信按钮

@property (nonatomic, strong) SHPasswordTextView *passwordTextView;

@property(nonatomic,strong)UILabel *leftMoney ;

@property(nonatomic,strong)UILabel *rightMoney ;

@property(nonatomic,assign) NSInteger type ;




@end

@implementation PayInfoView

-(instancetype)initWithFrame:(CGRect)frame{
	
	if ( self = [super initWithFrame:frame] ) {
		
		[ self SetSubViews ] ;
	}
	return self ;
}


/**
 布局 - 子控件
 */
-(void)SetSubViews{
	
	self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5] ;
	
    self.type = 1 ;
    
	[self addSubview:self.tapOne] ;
	[self addSubview:self.tapTwo] ;
	
}


-(UIView *)tapOne{
	
	if ( _tapOne == nil ) {
		
		_tapOne = [ QuickCreatUI creatUIViewWithSuperView:self andFrame:CGRectMake( 0 , 0.3*HEIGHT , WIDTH , 0.7 * HEIGHT ) color:kWhiteColor ] ;
		[ _tapOne  ViewSetCornerWithCorners:UIRectCornerTopLeft|UIRectCornerTopRight andCornerSize:CGSizeMake(10.0 , 10.0) ] ;
		
		UIView * topView = [ QuickCreatUI creatUIViewWithSuperView:_tapOne andFrame:CGRectMake(0, 0, WIDTH, 50) color:kWhiteColor];
		
		UILabel * titleLabel = [ QuickCreatUI creatUILabelWithSuperView:topView andFrame:CGRectMake(0, 0, WIDTH, 50) andText:@"付款详情" andStringColor:UIColorGray1 andFont:15 ] ;
		titleLabel.textAlignment = NSTextAlignmentCenter ;
		
		UIButton * cancleBtn = [ QuickCreatUI creatUIButton_Image_WithSuperView:topView andFrame:CGRectMake(0, 0, 50, 50) image:@"cuowu" andTarget:self SEL:@selector(clickCancleBtn) ] ;
		cancleBtn.right = topView.width - 16 ;
		cancleBtn.centerY = topView.height / 2 ;
		
		UIView * lineView = [ QuickCreatUI creatUIViewWithSuperView:_tapOne andFrame:CGRectMake( 0 , topView.bottom , WIDTH , 1 )  color:MainGray ] ;
		
		UILabel * moneyLabel = [ QuickCreatUI creatUILabelWithSuperView:_tapOne andFrame:CGRectMake( 0 , lineView.bottom  , WIDTH , 60 ) andText:self.money andStringColor:kBlackColor andFont:18 ] ;
		moneyLabel.textAlignment = NSTextAlignmentCenter ;

        moneyLabel.font =  [ UIFont boldSystemFontOfSize:18]  ;
        self.leftMoney = moneyLabel ;
     
		
		UILabel * payTitleLabel = [ QuickCreatUI creatUILabelWithSuperView:_tapOne andFrame:CGRectMake(20, moneyLabel.bottom + 20, WIDTH - 40 , 35) andText:@"支付方式:" andStringColor:UIColorGray2 andFont:14 ] ;
		
		/**
		 支付宝  支付
		 */
		UIView * aliPayView = [QuickCreatUI creatUIViewWithSuperView:_tapOne andFrame:CGRectMake(0, payTitleLabel.bottom , _tapOne.width , 44 ) color:kWhiteColor ] ;

		UIImageView * aliIcon = [QuickCreatUI creatUIImageViewWithSuperView:aliPayView andFrame:CGRectMake(16, 0, 30, 30) andImg:@"aliPayIcon" ] ;
		aliIcon.centerY = 22 ;

		[QuickCreatUI creatUILabelWithSuperView:aliPayView andFrame:CGRectMake(aliIcon.right + 16, 0, aliPayView.width * 0.5, aliPayView.height ) andText:@"支付宝" andStringColor:UIColorGray1 andFont:15 ] ;

		UIButton * aliSeleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22) ];
        [ aliSeleBtn setImage:[UIImage imageNamed:@"money07"] forState:UIControlStateNormal ] ;
        [ aliSeleBtn setImage:[UIImage imageNamed:@"money10"] forState:UIControlStateSelected ] ;
		aliSeleBtn.right = aliPayView.right - 16 ;
		[aliPayView addSubview:aliSeleBtn ] ;
		aliSeleBtn.selected = YES ;
        aliSeleBtn.centerY = 22 ;
		self.aliPayBtn = aliSeleBtn ;
        self.type = 1 ;

		UIControl * control = [[ UIControl alloc] initWithFrame:CGRectMake( 0 , 0 , aliPayView.width , aliPayView.height ) ] ;
		[control addTarget:self action:@selector(clickAliPay) forControlEvents:UIControlEventTouchUpInside ];
		[aliPayView addSubview:control ];


		/**
		 微信 支付
		 */
		UIView * weiChatPayView = [QuickCreatUI creatUIViewWithSuperView:_tapOne andFrame:CGRectMake(0, aliPayView.bottom + 1, _tapOne.width , 44 ) color:kWhiteColor ] ;

		UIImageView * weiChatIcon = [QuickCreatUI creatUIImageViewWithSuperView:weiChatPayView andFrame:CGRectMake(16, 0, 30, 30) andImg:@"weChatPay" ] ;
		weiChatIcon.centerY = 22 ;

		[QuickCreatUI creatUILabelWithSuperView:weiChatPayView andFrame:CGRectMake(weiChatIcon.right + 16, 0, weiChatPayView.width * 0.5, weiChatPayView.height ) andText:@"微信" andStringColor:UIColorGray1 andFont:15 ] ;

		UIButton * weiChatSeleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22) ];
        [ weiChatSeleBtn setImage:[UIImage imageNamed:@"money07"] forState:UIControlStateNormal ] ;
        [ weiChatSeleBtn setImage:[UIImage imageNamed:@"money10"]  forState:UIControlStateSelected ] ;
		weiChatSeleBtn.right = weiChatPayView.right - 16 ;
		[weiChatPayView addSubview:weiChatSeleBtn ] ;
		self.weiXinBtn = weiChatSeleBtn ;
        weiChatSeleBtn.centerY = 22 ;
//        self.type = 2 ;

		UIControl * weiChatControl = [[ UIControl alloc] initWithFrame:CGRectMake( 0 , 0 , weiChatPayView.width , weiChatPayView.height ) ] ;
		[weiChatControl addTarget:self action:@selector(clickWeiChatPay) forControlEvents:UIControlEventTouchUpInside ];
		[weiChatPayView addSubview:weiChatControl ];
		
		
		
		/**
		 余额 支付
		 */
		UIView * yue = [QuickCreatUI creatUIViewWithSuperView:_tapOne andFrame:CGRectMake( 0 , weiChatPayView.bottom + 1 , _tapOne.width , 44 ) color:kWhiteColor ] ;
        self.yuEView = yue ;
		UIImageView * yueIcon = [QuickCreatUI creatUIImageViewWithSuperView:yue andFrame:CGRectMake(16, 0, 30, 30) andImg:@"yuezhifu" ] ;
		yueIcon.centerY = 22 ;
		
		[QuickCreatUI creatUILabelWithSuperView:yue andFrame:CGRectMake(yueIcon.right + 16, 0, yue.width * 0.5, yue.height ) andText:@"余额支付" andStringColor:UIColorGray1 andFont:15 ] ;
		
		UIButton * yueSeleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25) ];
		[ yueSeleBtn setImage:[UIImage imageNamed:@"money07"] forState:UIControlStateNormal ] ;
		[ yueSeleBtn setImage:[UIImage imageNamed:@"money10"]  forState:UIControlStateSelected ] ;
		yueSeleBtn.right = yue.right - 16 ;
        yueSeleBtn.centerY = 22 ;
		[yue addSubview:yueSeleBtn ] ;
		self.yuEBtn = yueSeleBtn ;
//        self.type = 3 ;
		
		UIControl * yueControl = [[ UIControl alloc] initWithFrame:CGRectMake( 0 , 0 , yue.width , yue.height ) ] ;
		[yueControl addTarget:self action:@selector(clickyuEBtnPay) forControlEvents:UIControlEventTouchUpInside ];
		[yue addSubview:yueControl ];
		
		
		UIButton * sureBtn = [ QuickCreatUI creatUIButtonWithSuperView:_tapOne andFrame:CGRectMake(30, 0, WIDTH - 60, 35) andText:@"确认付款" andStringColor:kWhiteColor andFont:14 andTarget:self SEL:@selector(clickSureBtn)] ;
		sureBtn.bottom = _tapOne.height - kStatusBarHeight - 7 ;
		[ sureBtn  viewCornersWith:8.0 ] ;
		sureBtn.backgroundColor = kRedColor ;
		
	}
	return _tapOne ;
}


-(void)setMoney:(NSString *)money{
    
    _money = money ;
    
    self.leftMoney.text = StringFormat( @"支付金额: ¥%@", money ) ;
    self.rightMoney.text = StringFormat( @"支付金额: ¥%@", money ) ;
    
}

/**
 确认 - 付款
 */
-(void)clickSureBtn{
	
	
    if ( self.type == 1 ) {
        
        [self.delegate clickSureBtnWithCode:@"" andType:self.type] ;
        [self dissMiss] ;
    }else if ( self.type == 2 ) {
        
        [self.delegate clickSureBtnWithCode:@"" andType:self.type] ;
        [self dissMiss] ;
    }else if ( self.type == 3 ) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.tapOne.left = -WIDTH ;
            self.tapTwo.left = 0 ;
            
        }completion:^(BOOL finished) {
            
            [self->_passwordTextView.textField becomeFirstResponder] ;
            
        }];
        
    }
    
	NSLog(@" 确认 - 付款 " ) ;
}



/**
 点击 - 取消按钮
 */
-(void)clickCancleBtn{
	
    [self dissMiss] ;
	
	NSLog(@" 提交 - 改变 ") ;
}



-(void)clickAliPay{  // 点击 - 支付宝
    
    self.aliPayBtn.selected = YES ;
	self.weiXinBtn.selected = NO ;
    self.yuEBtn.selected = NO ;
    
    self.type = 1 ;
    
	NSLog(@" 点击 - 支付宝 " ) ;
}


-(void)clickWeiChatPay{  // 点击 - 微信
	
    self.aliPayBtn.selected = NO ;
    self.weiXinBtn.selected = YES ;
    self.yuEBtn.selected = NO ;
    
    self.type = 2 ;
    
	NSLog(@" 点击 - 微信 " ) ;
}


-(void)clickyuEBtnPay{ // 点击 余额支付
	
    self.aliPayBtn.selected = NO ;
    self.weiXinBtn.selected = NO ;
    self.yuEBtn.selected = YES ;
    
    self.type = 3 ;
    
	NSLog(@" 点击 余额支付 " ) ;
}



-(UIView *)tapTwo{
	
	if ( _tapTwo == nil ) {
		
		_tapTwo=  [[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0.3*HEIGHT, WIDTH, 0.7*HEIGHT ) ];
		_tapTwo.backgroundColor = kWhiteColor ;
		
		[ _tapTwo  ViewSetCornerWithCorners:UIRectCornerTopLeft|UIRectCornerTopRight andCornerSize:CGSizeMake(10.0 , 10.0) ] ;
		
		UIView * topView = [ QuickCreatUI creatUIViewWithSuperView:_tapTwo andFrame:CGRectMake(0, 0, WIDTH, 50) color:kWhiteColor];
		
		UILabel * titleLabel = [ QuickCreatUI creatUILabelWithSuperView:topView andFrame:CGRectMake(0, 0, WIDTH, 50) andText:@"请输入支付密码" andStringColor:UIColorGray1 andFont:15 ] ;
		titleLabel.textAlignment = NSTextAlignmentCenter ;
		
		UIButton * cancleBtn = [ QuickCreatUI creatUIButton_Image_WithSuperView:topView andFrame:CGRectMake(16, 0, 50, 50) image:@"fanhui" andTarget:self SEL:@selector(clickBackBtn) ] ;
		cancleBtn.centerY = topView.height / 2 ;
		
		UIView * lineView = [ QuickCreatUI creatUIViewWithSuperView:_tapTwo andFrame:CGRectMake( 0 , topView.bottom , WIDTH , 1 )  color:MainGray ] ;
		
		UILabel * moneyLabel = [ QuickCreatUI creatUILabelWithSuperView:_tapTwo andFrame:CGRectMake( 0 , lineView.bottom  , WIDTH , 60 ) andText:self.money andStringColor:kBlackColor andFont:18 ] ;
		moneyLabel.textAlignment = NSTextAlignmentCenter ;
		moneyLabel.font = [ UIFont boldSystemFontOfSize:18] ;
		self.rightMoney = moneyLabel ;
		
		UILabel * tishiLabel = [ QuickCreatUI creatUILabelWithSuperView:_tapTwo andFrame:CGRectMake(20, moneyLabel.bottom + 20, WIDTH - 40 , 30) andText:@"注: 请输入支付密码" andStringColor:UIColorGray2 andFont:13 ] ;
		
		_passwordTextView = [[SHPasswordTextView alloc]initWithFrame:CGRectMake(30, tishiLabel.bottom + 10, WIDTH - 60, 50) count:6 margin:20 passwordFont:40 forType:SHPasswordTextTypeAnimation_line block:^(NSString * _Nonnull passwordStr) {
			
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self endEditing:YES] ;
                [self.delegate clickSureBtnWithCode:passwordStr andType:self.type] ;
                [self dissMiss] ;
                NSLog(@"shihu___passwordStr == %@",passwordStr);
                
            });
		}];

		_passwordTextView.passwordSecureEntry = YES;//安全密码
		[_tapTwo addSubview:_passwordTextView] ;
		
	}
	return _tapTwo ;
}


/**
 点击 - 返回按钮
 */
-(void)clickBackBtn{
	
    [self endEditing:YES] ;
	[UIView animateWithDuration:0.3 animations:^{
		
		self.tapOne.left = 0 ;
		self.tapTwo.left = WIDTH ;
		
	}];
	
	NSLog(@"点击 - 返回按钮" ) ;
}


-(void)dissMiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.top = HEIGHT ;
        
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview] ;
        
    }];
}

-(void)show {
    
    self.frame = CGRectMake(0, 0, WIDTH, HEIGHT) ;
    [[QuickCreatUI sharedInstance].topViewController.view addSubview:self ] ;
    
}

@end

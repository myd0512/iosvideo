//
//  profitTypeVC.m
//  yunbaolive
//
//  Created by Boom on 2018/10/11.
//  Copyright © 2018年 cat. All rights reserved.
//

#import "profitTypeVC.h"
#import "profitTypeCell.h"
#import "addTypeView.h"
@interface profitTypeVC ()<UITableViewDelegate,UITableViewDataSource,cellDelegate>{
    UITableView *typeTable;
    NSArray *typeArray;
    UILabel *nothingLabel;
    addTypeView *addView;
}

@end

@implementation profitTypeVC

- (BOOL)fd_prefersNavigationBarHidden{
    return YES;
}

-(void)navtion{
    UIView *navtion = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _window_width, 64 + kStatusBarHeight)];
    navtion.backgroundColor =kWhiteColor;
    UILabel *label = [[UILabel alloc]init];
    label.text = @"提现账户";
    [label setFont:[UIFont systemFontOfSize:18]];
    label.textColor = kBlackColor;
    label.frame = CGRectMake(0, kStatusBarHeight+24,_window_width,40);
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
    
    
    UIButton *addBtn = [UIButton buttonWithType:0];
    addBtn.frame = CGRectMake(_window_width-45, 24+kStatusBarHeight, 45, 45);
    [addBtn setTitle:@"添加" forState:0];
    [addBtn setTitleColor:normalColors forState:0];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navtion addSubview:addBtn];
    [[YBToolClass sharedInstance] lineViewWithFrame:CGRectMake(0, navtion.height-1, _window_width, 1) andColor:RGB(244, 245, 246) andView:navtion];
    [self.view addSubview:navtion];
}
-(void)doReturn{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addBtnClick:(UIButton *)sender{
    if (!addView) {
        addView = [[addTypeView alloc]init];
        [self.view addSubview:addView];
    }else{
        addView.hidden = NO;
    }
    __weak profitTypeVC *weakSelf = self;
    addView.block = ^{
        [weakSelf requestData];
        [addView removeFromSuperview];
        addView = nil;
    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self navtion];
    typeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+kStatusBarHeight, _window_width, _window_height-64-kStatusBarHeight) style:UITableViewStylePlain];
    typeTable.delegate = self;
    typeTable.dataSource = self;
    typeTable.separatorStyle = 0;
    [self.view addSubview:typeTable];
    
    nothingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, _window_width, 20)];
    nothingLabel.text = @"您当前还没有设置提现账户";
    nothingLabel.textAlignment = NSTextAlignmentCenter;
    nothingLabel.font = [UIFont systemFontOfSize:14];
    nothingLabel.textColor = RGB_COLOR(@"#333333", 1);
    nothingLabel.hidden = YES;
    [self.view addSubview:nothingLabel];
    self.view.backgroundColor = RGB_COLOR(@"#f4f5f6", 1);
    [self requestData];
}
- (void)requestData{
    
    [[ ZKHttpTool shareInstance ] get:[ZKSeriverBaseURL getUrlType:GetUserAccountList] params:@{
        @"uid":[UserInfoManaget sharedInstance].model.id ,
        @"token":[UserInfoManaget sharedInstance].model.token ,
    } withHUD:NO success:^(id json) {
        
        NSArray * dataArr = json[@"data"][@"info"];
       
        if ([json[@"data"][@"code"] intValue] == 0) {
            
            typeArray = dataArr;
            if (typeArray.count > 0) {
                nothingLabel.hidden = YES;
                typeTable.hidden = NO;
                [typeTable reloadData];
            }else{
                nothingLabel.hidden = NO;
                typeTable.hidden = YES;
            }
            
        }else{
           
        }
        
    } failure:^(NSError *error) {
        
        nothingLabel.hidden = NO;
        typeTable.hidden = YES;
    }] ;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return typeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    profitTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profitTypeCELL"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"profitTypeCell" owner:nil options:nil] lastObject];
    }
    cell.delegate = self;
    cell.indexRow = indexPath.row;
    NSDictionary *dic = typeArray[indexPath.row];
    if ([minstr([dic valueForKey:@"id"])isEqual:_selectID]) {
        cell.stateImgView.image = [UIImage imageNamed:@"profit_sel"];
    }else{
        cell.stateImgView.image = [UIImage imageNamed:@"profit_nor"];
    }
    int type = [minstr([dic valueForKey:@"type"]) intValue];
    switch (type) {
        case 1:
            cell.typeImgView.image = [UIImage imageNamed:@"profit_alipay"];
            cell.nameL.text = [NSString stringWithFormat:@"%@(%@)",minstr([dic valueForKey:@"account"]),minstr([dic valueForKey:@"name"])];
            break;
        case 2:
            cell.typeImgView.image = [UIImage imageNamed:@"profit_wx"];
            cell.nameL.text = [NSString stringWithFormat:@"%@",minstr([dic valueForKey:@"account"])];
            break;
        case 3:
            cell.typeImgView.image = [UIImage imageNamed:@"profit_card"];
            cell.nameL.text = [NSString stringWithFormat:@"%@(%@)",minstr([dic valueForKey:@"account"]),minstr([dic valueForKey:@"name"])];
            break;

        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = typeArray[indexPath.row];
    if (![minstr([dic valueForKey:@"id"])isEqual:_selectID]) {
        self.block(dic);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)delateIndex:(NSInteger)index{
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确定删除此提现账号？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:cancleAction];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *dic = typeArray[index];
        
        [[ ZKHttpTool shareInstance ] get:[ZKSeriverBaseURL getUrlType:DelUserAccount] params:@{
               @"uid":[UserInfoManaget sharedInstance].model.id ,
               @"token":[UserInfoManaget sharedInstance].model.token ,
               @"id":dic[@"id"]
           } withHUD:NO success:^(id json) {
               
               if ([json[@"data"][@"code"] intValue] == 0) {
                   [SVProgressHUD showSuccessWithStatus:json[@"data"][@"msg"]];
                   [self requestData];
               }else{
                   [SVProgressHUD showErrorWithStatus:json[@"data"][@"msg"]];
               }
              
           } failure:^(NSError *error) {
               
           }] ;
    }];
    [alertContro addAction:sureAction];
    [self presentViewController:alertContro animated:YES completion:nil];
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

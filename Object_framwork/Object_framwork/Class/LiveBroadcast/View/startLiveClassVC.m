//
//  startLiveClassVC.m
//  yunbaolive
//
//  Created by Boom on 2018/9/28.
//  Copyright © 2018年 cat. All rights reserved.
//

#import "startLiveClassVC.h"
#import "startLiveClassCell.h"
@interface startLiveClassVC ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *classTable;
    NSArray *classArray;
}

@end

@implementation startLiveClassVC
-(void)navtion{
    
 
    
    
    UIView *navtion = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64 + kStatusBarHeight)];
    navtion.backgroundColor = kWhiteColor;
    UILabel *label = [[UILabel alloc]init];
    label.text = @"选择直播频道";
    [label setFont:[UIFont systemFontOfSize:18]];
    label.textColor = oneBlaceFont;
    label.frame = CGRectMake(0, kStatusBarHeight,WIDTH,84);
    label.textAlignment = NSTextAlignmentCenter;
    [navtion addSubview:label];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *bigBTN = [[UIButton alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, WIDTH/2, 64)];
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
    [[YBToolClass sharedInstance] lineViewWithFrame:CGRectMake(0, navtion.height-1, WIDTH, 1) andColor:RGB(244, 245, 246) andView:navtion];
    [self.view addSubview:navtion];
}

/*
 * 获取分类≈信息
 */
-(void)getData{
    
    [[ZKHttpTool shareInstance] get:[ZKSeriverBaseURL getUrlType:GetLiveClass] params:@{
            @"uid":[UserInfoManaget sharedInstance].model.id ,
            @"token":[UserInfoManaget sharedInstance].model.token
        } withHUD:NO success:^(id json) {
            
        NSArray * dataArr = json[@"data"][@"info"];
        classArray = dataArr ;
        [classTable reloadData];
            
        } failure:^(NSError *error) {
            
            
        }];
    
}

-(void)doReturn{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    classArray = @[];
    
    [self navtion];
    classTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+kStatusBarHeight, WIDTH, HEIGHT-64-kStatusBarHeight) style:UITableViewStylePlain];
    classTable.delegate = self;
    classTable.dataSource = self;
    classTable.separatorStyle = 0;
    [self.view addSubview:classTable];
    [self getData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return classArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    startLiveClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"startLiveClassCELL"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"startLiveClassCell" owner:nil options:nil] lastObject];
    }
    NSDictionary *dic = classArray[indexPath.row];
    if ([minstr([dic valueForKey:@"id"])isEqual:_classID]) {
        cell.selectImfView.hidden = NO;
    }else{
        cell.selectImfView.hidden = YES;
    }
    [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:minstr([dic valueForKey:@"thumb"])] placeholderImage:[UIImage imageNamed:@"live_all"]];
    cell.nameLabel.text = minstr([dic valueForKey:@"name"]);
    cell.contentLabel.text = minstr([dic valueForKey:@"des"]);
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    view.backgroundColor = RGB_COLOR(@"#f4f5f6", 1);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, WIDTH-20, 40)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = RGB_COLOR(@"#646464", 1);
    label.numberOfLines = 2;
    label.text = @"注意选择适合自己的频道。直播过程中，若运营人员发现选择的频道和直播内容不相符的情况，会调整您的直播频道。";
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = classArray[indexPath.row];
    if (![minstr([dic valueForKey:@"id"])isEqual:_classID]) {
        self.block(dic);
        [self dismissViewControllerAnimated:YES completion:nil];
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

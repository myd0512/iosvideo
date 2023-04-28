//
//  隐藏导航.h
//  Object_framwork
//
//  Created by 高通 on 2018/12/12.
//  Copyright © 2018 www.zzwanbei.com. All rights reserved.



#pragma mark 生命周期方法
-(void)viewWillAppear:(BOOL)animated{
	
	[super viewWillAppear:animated];
	
	[self.navigationController setNavigationBarHidden:YES animated:NO];
	
}


-(void)viewWillDisappear:(BOOL)animated{
	
	[super viewWillDisappear:animated];
	
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	
}


-(void)viewWillLayoutSubviews{
	[super viewWillLayoutSubviews];
	
}




http://i.sporttery.cn/api/fb_match_info/get_team_rec_data?tid=107&md=2018-12-03&is_ha=all&limit=10&c_id=0&ptype[]=three_-1&f_callback=getTeamsDataInfo&_=1543801883970.  //  对战历史记录 主队


http://i.sporttery.cn/api/fb_match_info/get_team_rec_data?tid=99&md=2018-12-03&is_ha=all&limit=10&c_id=0&ptype[]=three_-1&f_callback=getAwayInfo&_=1543801883971   //  客队



http://i.sporttery.cn/api/fb_match_info/get_future_matches?tid=107&md=2018-12-03&limit=4&f_callback=getFutureMatchesInfo&_=1543801883971  //未来对战 107


http://i.sporttery.cn/api/fb_match_info/get_future_matches?tid=99&md=2018-12-03&limit=4&f_callback=getFutureMatchesInfoA&_=1543801883973 //  99


http://i.sporttery.cn/api/fb_match_info/get_result_his?limit=10&is_ha=all&limit=10&c_id=0&mid=114351&ptype[]=three_-1&f_callback=getResultHistoryInfo&_=1543801883975  //   历史信息






//// 半全场 数据
////  get 请求  参数  i_format: json        i_callback: getData    poolcode[]:  hafu    _ :  当前时间戳
http://i.sporttery.cn/odds_calculator/get_odds?i_format=json&i_callback=getData&poolcode[]=hafu&_=1544666820651


////  总进球数 get请求   i_format: json       i_callback: getData     poolcode[]: ttg     _ :  当前时间戳
http://i.sporttery.cn/odds_calculator/get_odds?i_format=json&i_callback=getData&poolcode[]=ttg&_=1544667817117


//   比分数据  get请求   i_format: json       i_callback: getData     poolcode[]: crs     _ :  当前时间戳
http://i.sporttery.cn/odds_calculator/get_odds?i_format=json&i_callback=getData&poolcode[]=crs&_=1544667830178


//
http://info.sporttery.cn/interface/interface_mixed.php?action=fb_list&pke=0.01349805854416064&_=1544668269588


// 获取 比赛列表
http://i.sporttery.cn/api/match_live_2/get_match_list?callback=?&_=1544684601567









////    比赛列表  - 近几天的比赛列表
http://i.sporttery.cn/api/fb_match_info/get_matches?f_callback=getMatchList&_=1544693199176


////     具体的  某场 比赛信息
http://i.sporttery.cn/api/fb_match_info/get_match_info?mid=114715&f_callback=getMatchInfo&_=1544693199185


////   小组 积分榜
http://i.sporttery.cn/api/fb_match_info/get_team_score?mid=114715&f_callback=getScoreBoardInfoall&order_type=all&_=1544693199397




////   队伍 - 射手信息
http://i.sporttery.cn/api/fb_match_info/get_scorer?mid=114715&f_callback=getScorerInfo&_=1544693199412


//// 队伍 - 伤停信息
http://i.sporttery.cn/api/fb_match_info/get_injury_suspension?mid=114715&f_callback=getInjurySuspensionInfo&_=1544693199414

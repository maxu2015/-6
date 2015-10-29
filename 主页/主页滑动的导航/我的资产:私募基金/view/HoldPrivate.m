//
//  HoldPrivate.m
//  CaiLiFang
//
//  Created by 08 on 15/5/13.
//  Copyright (c) 2015年 08. All rights reserved.
//
#import "holdViewCell.h"
#import "HoldPrivate.h"
#import "NetManager.h"
#import "userInfo.h"

@interface HoldPrivate ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation HoldPrivate
{
    NetManager *_netManager;
    NSMutableArray *_dataArray;
    NSDictionary *_gerenxinxiArray;
}
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self deleteTable];
    [self ifIdcard];
    return self;
}
- (void)deleteTable{
    self.delegate=self;
    self.dataSource=self;
    
}
- (void)createData {
    [ProgressHUD show:nil];
    _netManager =[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:@"%@%@",ChiYou,[_gerenxinxiArray objectForKey:@"IDCard"]];
    NSLog(@"=======%@",url);
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _dataArray=[NSMutableArray arrayWithArray:data];
        
        [self reloadData];
        [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
    } Tag:'cell'];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    holdViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"holdViewCell" owner:self options:0][0];
    }
    cell.backgroundColor=[UIColor clearColor];
    if (_dataArray.count>0) {
        NSInteger i=indexPath.row;
        NSDictionary *dic=_dataArray[i];
        
      
        cell.Shizhi.text=[dic objectForKey:@"ShiZhi"];
        cell.SName.text=[dic objectForKey:@"SName"];
        cell.Amountvol.text=[dic objectForKey:@"Amountvol"];
        cell.CostAmount.text=[dic objectForKey:@"CostAmount"];
        cell.Currnav.text=[dic objectForKey:@"Currnav"];
        cell.Opentime.text=[dic objectForKey:@"Opentime"];
        cell.Preeraning.text=[dic objectForKey:@"Rate"];
        NSString *navdata=[NSString stringWithFormat:@"(%@)",[dic objectForKey:@"Navdate"]];
        cell.Navdate.text=navdata;
    }
    
    return cell;
}
- (void)ifIdcard{
    
    _gerenxinxiArray=[[UserInfo shareManager] userInfoDic];
    
    
    
    if (_gerenxinxiArray.count>0) {
        NSString *IDCard = [_gerenxinxiArray objectForKey:@"IDCard"];
        if (IDCard&&IDCard.length==18) {
            //18为身份证
            [self createData];
        }
        else{
            
            
        }
    }
}

@end

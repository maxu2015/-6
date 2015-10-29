//
//  TransactionRecords.m
//  CaiLiFang
//
//  Created by 08 on 15/5/13.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "TransactionRecords.h"
#import "NetManager.h"
#import "TransactionRecordsCell.h"
#import "userInfo.h"
@interface TransactionRecords ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation TransactionRecords
{
        NetManager *_netManager;
        NSMutableArray *_dataArray;
        NSDictionary *_gerenxinxidict;
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
        NSString *url=[NSString stringWithFormat:@"%@%@",JYJL,[_gerenxinxidict objectForKey:@"IDCard"] ];
       
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
        TransactionRecordsCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"TransactionRecordsCell" owner:self options:0][0];
        }
        cell.backgroundColor=[UIColor clearColor];
        if (_dataArray.count>0) {
            NSInteger i=indexPath.row;
            NSDictionary *dic=_dataArray[i];
            cell.Dtransaction.text=[dic objectForKey:@"Dtransaction"];
            cell.Operation.text=[dic objectForKey:@"Operation"];
            cell.Startdate.text=[dic objectForKey:@"Startdate"];
            cell.Fnetmoney.text=[dic objectForKey:@"Fnetmoney"];
            cell.Amountvol.text=[dic objectForKey:@"Amountvol"];
            cell.UnitPrice.text=[dic objectForKey:@"UnitPrice"];
            cell.SName.text=[dic objectForKey:@"SName"];
        }
        
        return cell;
    }
- (void)ifIdcard{
    
    _gerenxinxidict=[[UserInfo shareManager] userInfoDic];
    
    
    
    if (_gerenxinxidict.count>0) {
        NSString *IDCard = [_gerenxinxidict objectForKey:@"IDCard"];
        if (IDCard&&IDCard.length==18) {
            //18为身份证
            [self createData];
        }
        else{
            
            
        }
    }
}

@end

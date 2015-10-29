//
//  KnockTicketManager.m
//  CaiLiFang
//
//  Created by 展恒 on 15/6/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//
#import "KnockTicketManager.h"
#import "NetManager.h"
#import "TableViewCell.h"
#import "IndexFuctionApi.h"
static KnockTicketManager * _intance;
@implementation KnockTicketManager {
    NetManager *_netmanager;
    NSMutableArray *_dataArrary;
}
+(instancetype)shareKnockTicket{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[KnockTicketManager alloc]init];
        }
    });

    return _intance;
}
- (void)createData:(loadBlock)LoadBlock{
    
    _netmanager=[NetManager shareNetManager];
    [_netmanager getRequestWithUrl:knockTicket Finsh:^(id data, NSInteger tag) {
        _dataArrary=[[NSMutableArray alloc]initWithArray:data];
        NSLog(@"data===%@",data);
        if (LoadBlock) {
            LoadBlock();
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'ktkt'];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArrary.count;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil][0];
    }
    
    [cell.ticketImage setImageWithURL:[NSURL URLWithString:[_dataArrary[indexPath.row] objectForKey:@"QuanPic"]]];
    return cell;

}
-(void)selectTicket:(selectTicketBlock)selectTicketBlock {
    if (selectTicketBlock) {
        _selectBlock=selectTicketBlock;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_selectBlock) {
        _selectBlock([_dataArrary[indexPath.row] objectForKey:@"QuanURL"]);
    }


}
@end

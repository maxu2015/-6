//
//  hole HoleCoupontableView.m
//  CaiLiFang
//
//  Created by 08 on 15/6/11.
//  Copyright (c) 2015年 08. All rights reserved.
//
#import "HoleCoupontableView.h"
#import "CouponCell.h"
@interface HoleCoupontableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation HoleCoupontableView

- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    [self setDataSource:self];
    [self setDelegate:self];
    return self;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    CouponCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"CouponCell" owner:self options:0][0];
    }
    cell.backgroundColor=[UIColor clearColor];
    if ([self.tableArray count]==0) {
        
    }

    
    cell.youxiaoqi.text=[NSString stringWithFormat:@"有效期:%@",[[self.tableArray objectAtIndex:indexPath.row]objectForKey:@"StartTermination"]];
    cell.jine.text=[NSString stringWithFormat:@"￥%@",[[self.tableArray objectAtIndex:indexPath.row]objectForKey:@"Amount"]];
    cell.DTCjene=[NSString stringWithFormat:@"%@",[[self.tableArray objectAtIndex:indexPath.row]objectForKey:@"Amount"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DianCaiTongController *diancaitong=[[DianCaiTongController alloc]init];
//    diancaitong.dtcID=[self.tableArray[indexPath.row] objectForKey:@"Id"];
//    diancaitong.youhuijuanjune=[NSString stringWithFormat:@"%@",[[self.tableArray objectAtIndex:indexPath.row]objectForKey:@"Amount"]];;
//    NSLog(@"%@",diancaitong.youhuijuanjune);
//    [APP_DELEGATE.rootNav pushViewController:diancaitong animated:YES];
}
@end

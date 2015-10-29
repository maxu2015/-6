//
//  yiyongyouhui.m
//  CaiLiFang
//
//  Created by 08 on 15/6/11.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "yiyongyouhui.h"
#import "yishiyongcell.h"

@implementation yiyongyouhui
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
    yishiyongcell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"yishiyongcell" owner:self options:0][0];
    }
    cell.backgroundColor=[UIColor clearColor];
    if ([self.tableArray count]==0) {
        
    }
    
    
    cell.youxiaoqi.text=[NSString stringWithFormat:@"有效期:%@",[[self.tableArray objectAtIndex:indexPath.row]objectForKey:@"StartTermination"]];
    cell.jine.text=[NSString stringWithFormat:@"￥%@",[[self.tableArray objectAtIndex:indexPath.row]objectForKey:@"Amount"]];
    return cell;
}


@end

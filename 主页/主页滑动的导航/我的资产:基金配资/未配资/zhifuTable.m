//
//  zhifuTable.m
//  CaiLiFang
//
//  Created by 08 on 15/6/1.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "zhifuTable.h"
#import "zhifuceLL.h"


@interface zhifuTable ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation zhifuTable

- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    [self delegateTable];
  self.tableFooterView= [[UIView alloc]init];
    self.array=[NSMutableArray arrayWithObjects:@"网上支付",@"线下支付", nil];
    return self;

}
- (void)delegateTable{
    self.delegate=self;
   
    self.dataSource=self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     ;
    return 50;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    zhifuceLL *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"zhifuceLL" owner:self options:0][0];
    }
    
  
    if (indexPath.row==0){
        self.selectedIndexPath=indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.backgroundColor=[UIColor clearColor];
    cell.wangshangzhifu.text=_array[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedIndexPath = indexPath;
    
    
}

@end

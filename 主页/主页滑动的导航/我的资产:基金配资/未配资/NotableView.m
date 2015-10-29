//
//  NotableView.m
//  CaiLiFang
//
//  Created by 08 on 15/5/29.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "NotableView.h"
#import "NotableViewCell.h"
#import "ZhunRuTiaoJianController.h"

#import "peiziViewController.h"
@interface NotableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation NotableView
{
    
      NSMutableArray *_dataArray;
    

}
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self deleteTable];
    _dataArray=[NSMutableArray arrayWithObjects:@"会员服务热线",@"会员准入条件",@"配资须知", nil];
    self.tableFooterView=[[UIView alloc]init];
    return self;
}
- (void)deleteTable{
    self.delegate=self;
    self.dataSource=self;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     NotableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"NotableViewCell" owner:self options:0][0];
    }
    cell.backgroundColor=[UIColor clearColor];
    if (_dataArray.count>0) {
        cell.huiyuanfuwu.text=_dataArray[indexPath.row];
        if (indexPath.row==0) {
            cell.iphone.text=@"010-56236258";
        }

    }
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"010-56236258" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
            alert.tag = 110;
            [alert show];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-56236258"]];
        }
            break;
        case 1:
        {
            ZhunRuTiaoJianController *zhunru=[[ZhunRuTiaoJianController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:zhunru animated:YES];
        }
        break;
        case 2:
        {
            peiziViewController *peizi=[[peiziViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:peizi animated:YES];
            
        }
            break;
        default:
            break;
    }
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 1;
//
//
//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==110) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-56236258"]];
        }
        
    }
    
}
@end

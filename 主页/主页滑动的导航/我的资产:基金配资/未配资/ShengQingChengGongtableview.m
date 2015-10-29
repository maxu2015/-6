//
//  ShengQingChengGongtableview.m
//  CaiLiFang
//
//  Created by 08 on 15/5/29.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ShengQingChengGongtableview.h"
#import "YuYueChengGongcell.h"
#import "ZhunRuTiaoJianController.h"
#import "peiziViewController.h"
@interface ShengQingChengGongtableview ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *youshiArray;
@property (nonatomic,strong)NSArray *dazi;
@property (nonatomic,strong)NSArray *shuoming;
@property (nonatomic,copy)NSArray *imageV;
@end
@implementation ShengQingChengGongtableview

{
    NSMutableArray *_youshiArray;
    NSMutableArray *_tableArray;

}
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self deleteTable];
    
    _youshiArray=[NSMutableArray arrayWithObjects:@"收益",@"速度",@"利息",@"门槛", nil];
    _dazi=[NSMutableArray arrayWithObjects:@"高",@"快",@"少",@"低" ,nil];
    _shuoming=[NSMutableArray arrayWithObjects:@"收益最大可放大四倍",@"即时申请,即时交易",@"月息仅0.48%%",@"1万元即可申请", nil];
    _imageV=[NSMutableArray arrayWithObjects:@"imag_fast",@"imag_high",@"imag_little",@"imag_low",nil ];
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
    return _youshiArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    YuYueChengGongcell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"YuYueChengGongcell" owner:self options:0][0];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.shouyi.text=_youshiArray[indexPath.row];
    if (indexPath.row==0) {
        cell.yanse.textColor=[UIColor colorWithRed:218/255.0 green:92/255.0 blue:42/255.0 alpha:1];
        cell.yanse.text=_dazi[indexPath.row];
    }else if(indexPath.row==1){
        cell.yanse.textColor=[UIColor redColor];
        cell.yanse.text=_dazi[indexPath.row];
    
    }
    else if(indexPath.row==2){
        cell.yanse.textColor=[UIColor blueColor];
        cell.yanse.text=_dazi[indexPath.row];
        
    }
    else if(indexPath.row==3){
        cell.yanse.textColor=[UIColor colorWithRed:252/255.0 green:170/255.0 blue:0 alpha:1];
        cell.yanse.text=_dazi[indexPath.row];
        
    }
    
    cell.jieshao.text=_shuoming[indexPath.row];
    
    cell.image.image=[self OriginImage: [UIImage imageNamed:_imageV[indexPath.row]]scaleToSize:CGSizeMake(20, 20)];
        return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.row) {
//        case 0:
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"010-56236258" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
//            alert.tag = 110;
//            [alert show];
//            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-56236258"]];
//        }
//            break;
//        case 1:
//        {
//            ZhunRuTiaoJianController *zhunru=[[ZhunRuTiaoJianController alloc]init];
//            [APP_DELEGATE.rootNav pushViewController:zhunru animated:YES];
//        }
//            break;
//        case 2:
//        {
//            peiziViewController *peizi=[[peiziViewController alloc]init];
//            [APP_DELEGATE.rootNav pushViewController:peizi animated:YES];
//            
//        }
//            break;
//        default:
//            break;
//    }
//    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    if (alertView.tag==110) {
//        if (buttonIndex==1) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-56236258"]];
//        }
//        
//    }
    
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


@end

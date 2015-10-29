//
//  ZHMREcommend_ViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "ZHMREcommend_ViewController.h"
#import "ZHMREcommend_CollectionViewCell.h"
#import "FundViewController.h"
#import "ProgressHUD.h"
#import "IndexFuctionApi.h"
#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]

@interface ZHMREcommend_ViewController ()
@end

@implementation ZHMREcommend_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    // 初始化
    self.dataSource = [NSMutableArray array];
    self.table.backgroundColor = COLOR_RGB(234, 235, 236);
    [self.table registerNib:[UINib nibWithNibName:@"ZHMREcommend_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZHMREc"];
    
    // 请求数据
    [self requestData];
}
-(void)createUI
{
    [ProgressHUD show:nil];
}
-(void)requestData
{
    _net= [NetManager shareNetManager];
    [_net dataGetRequestWithUrl:[NSString stringWithFormat:RECOMMEND, apptrade8484] Finsh:^(id data, NSInteger tag) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self.dataSource addObjectsFromArray:arr];
        [ProgressHUD dismiss];
        [self.table reloadData];
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
    } Tag:0];
}

// 页面将要消失时停止加载
-(void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}


#pragma mark UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"ZHMREc";
    ZHMREcommend_CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    cell.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, 130);
    NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.item];
    [cell showDataWith:dic];
    
    return cell;
}

// 设置 每个cell 的size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH - 20, 130);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FundViewController * fvc = [[FundViewController alloc] init];
    NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.item];
    fvc.fundCode = [dic objectForKey:@"FundCode"];
    fvc.fundName = [dic objectForKey:@"FundName"];
    
    [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];
}
- (IBAction)pressBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  HomeREcommendViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "HomeREcommendViewController.h"
#import "HomeREcommendTableViewCell.h"
#import "ZHMREcommend_ViewController.h"
#import "ZHRE_URLViewController.h"
#import "ProgressHUD.h"
#import "IndexFuctionApi.h"


#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define CELLHEIGHT 207.6

@interface HomeREcommendViewController ()
{
    ZHMREcommend_ViewController * recommd_con;
    ZHRE_URLViewController * recommd_url;
}


@end


@implementation HomeREcommendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createUI];
    // 初始化
    self.dataSource = [[NSMutableArray alloc] init];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 49 - 64) style:UITableViewStylePlain];
    table.backgroundColor = COLOR_RGB(234, 235, 236);
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
     // 设置table 的背景色
    //table.backgroundColor = [UIColor redColor];
    [self.view addSubview:table];
    
    [self requestData];

}
-(void)createUI
{
    // 加载显示
    [ProgressHUD show:nil];
}
-(void)requestData
{
    _net= [NetManager shareNetManager];
    [_net dataGetRequestWithUrl:TuiJiangBanner Finsh:^(id data, NSInteger tag) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self.dataSource addObjectsFromArray:arr];
        [ProgressHUD dismiss];
        [table reloadData];
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
    } Tag:0];
}

// 页面将要显示
-(void)viewWillAppear:(BOOL)animated
{
}


#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"recommend";
    HomeREcommendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeREcommendTableViewCell" owner:self options:nil] lastObject];
    }
    if (indexPath.row == 0) {
        cell.subImage.image = [UIImage imageNamed:@"tuijian3.png"];
    }
    else{
        NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.row -1];
        [cell showdataWith:dic];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    if (indexPath.row == 0) {
        if (recommd_con == nil) {
            recommd_con.title = @"展恒推荐";
            recommd_con = [[ZHMREcommend_ViewController alloc] init];
        }
        [APP_DELEGATE.rootNav pushViewController:recommd_con animated:YES];
    }
    else{
        if (recommd_url == nil) {
            recommd_url = [[ZHRE_URLViewController alloc] init];
        }
        recommd_con.title = @"展恒推荐";
        recommd_url.url = [[self.dataSource objectAtIndex:indexPath.row - 1] objectForKey:@"BannerURL"];
        [APP_DELEGATE.rootNav pushViewController:recommd_url animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHEIGHT;
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

//
//  NotificationNewsViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NotificationNewsViewController.h"
#import "NotificationInformationViewController.h"
#import "NotificationNewTableViewCell.h"

@interface NotificationNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation NotificationNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *ary = [defaults objectForKey:NOTIFICATIONNEWS];
//    NSLog(@"num = %d",ary.count);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//去掉推送的红点
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH,[UIScreen mainScreen].bounds.size.height-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self requestData];
}

-(void)requestData{
    [ProgressHUD show:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Service/DemoService.svc/GetJpushList?",LOCAL_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
             [ProgressHUD dismiss];
            return ;
        }
        _tableArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&connectionError];
        
        [_tableView reloadData];
         [ProgressHUD dismiss];
        
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *ary = [defaults objectForKey:NOTIFICATIONNEWS];
//    
//    NSLog(@"--------%@",ary);
    return _tableArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NotificationNewTableViewCell *cell =(NotificationNewTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
//    NSDictionary *DIC = [[_tableArr objectAtIndex:indexPath.row] copy];
//    NSString *titleStr = [DIC objectForKey:@"Title"];
//    CGSize bound = [self getSizeOfStr:titleStr font:[UIFont systemFontOfSize:14]];
    
//    cell.titleLB.frame = CGRectMake(20, 2, SCREEN_WIDTH-20, bound.height);
//    cell.timeLB.frame  = CGRectMake(SCREEN_WIDTH-120, bound.height+14, 120, 15);

//    return bound.height+15+15 ;
    return 77;
}


- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    //    CGSize size = [str sizeWithFont:font
    //                  constrainedToSize:CGSizeMake(280 , MAXFLOAT)];
    return rect.size;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    NotificationNewTableViewCell *cell = (NotificationNewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NotificationNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *DIC = [[_tableArr objectAtIndex:indexPath.row] copy];
    [cell reloadData:DIC];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"------------%@",_tableArr);
    
    NotificationInformationViewController *noti = [[NotificationInformationViewController alloc] initWithPushKey:[NSString stringWithFormat:@"%@",[[_tableArr objectAtIndex:indexPath.row] objectForKey:@"PushKey"]]];
    noti.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"---------%@",noti.pushKey);
    
    //NSLog(@"--------%@",_tableArr);
    [APP_DELEGATE.rootNav pushViewController:noti animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)returnBtnClick:(id)sender {
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
@end

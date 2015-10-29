//
//  CommentsViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CommentsViewController.h"
#import "ZidonAFNetWork.h"
#import "CommentsTableViewCell.h"
#import "MyItem.h"
#import "AddCommentsViewController.h"
#import "IndexFuctionApi.h"


@interface CommentsViewController ()<zidonDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@end


@implementation CommentsViewController

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
    _dataArray = [[NSMutableArray alloc]init];
    [self requestUrl];
}


//发送请求
-(void)requestUrl
{
    [ProgressHUD show:@"正在加载评论！"];
    ZidonAFNetWork *zidonGetComments = [ZidonAFNetWork sharedInstace];
    [zidonGetComments requestWithUrl:[NSString stringWithFormat:kGetCommentsUrl,LOCAL_URL,self.fundCode] withDelegate:self];
}


-(void)requestFinished:(NSArray *)parmeters
{
    [_dataArray removeAllObjects];
    for (NSDictionary *dic in parmeters) {
        MyItem *model = [[MyItem alloc]init];
        model.commentsUserName = dic[@"UserName"];
        model.commentsFundReview = dic[@"FundReview"];
        model.commentsSendTime = dic[@"SendTime"];
        [_dataArray addObject:model];
    }
    if (_dataArray.count == 0) {
        [ProgressHUD showError:@"暂无评论"];
    }else{
          [ProgressHUD dismiss];
    }
    [_commentsListTableView reloadData];
}


-(void)requestFailed:(NSError *)error
{
    
}


#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyItem *model = _dataArray[indexPath.row];
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGRect frame = [model.commentsFundReview boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return 10+21+10+frame.size.height+10+21+10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentsTableViewCell" owner:self options:nil] lastObject];
    }
    MyItem *model = _dataArray[indexPath.row];
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGRect frame = [model.commentsFundReview boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    cell.commentsTitleLabel.frame = CGRectMake(20, 10, 200, 21);
    cell.commentsCountsLabel.frame = CGRectMake(20, 41, frame.size.width, frame.size.height);
    cell.commentsTimeLabel.frame = CGRectMake(160, frame.size.height+41+10, 140, 21);
    
    if ([self validateMobile:model.commentsUserName]) {//手机号码
        cell.commentsTitleLabel.text = [NSString stringWithFormat:@"%@****%@",[model.commentsUserName substringWithRange:NSMakeRange(0, 3)],[model.commentsUserName substringWithRange:NSMakeRange(model.commentsUserName.length-4, 4)]];
    }
    else{
    cell.commentsTitleLabel.text = model.commentsUserName;
    }
    
    cell.commentsCountsLabel.text = model.commentsFundReview;
    cell.commentsTimeLabel.text = model.commentsSendTime;
    return cell;
}

//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}
//下个界面返回之后 重新发送请求
-(void)viewWillAppear:(BOOL)animated
{
    [self requestUrl];
}
- (IBAction)addComment:(id)sender {
    AddCommentsViewController *acvc = [[AddCommentsViewController alloc]init];
    acvc.fundName = self.fundName;
    acvc.fundCode = self.fundCode;
    [APP_DELEGATE.rootNav pushViewController:acvc animated:YES];
}
@end

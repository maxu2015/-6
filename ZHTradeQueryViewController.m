//
//  ZHTradeQueryViewController.m
//  基金转换
//
//  Created by 08 on 15/3/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTradeQueryViewController.h"
#import "AFNetworking.h"
#import "UIView+Frame.h"
#import "NSData+GBK_to_UTF_8.h"
#import "ZHTradeQueryInfo.h"
#import "ZHTradeQueryResultTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "ZHTradeQueryDetailViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface ZHTradeQueryViewController ()<UITableViewDataSource,UITableViewDelegate,ZHTradeQueryResultTableViewCellDelegate>
@property(nonatomic,strong)UIDatePicker*datePicker;




- (IBAction)queryClick;
- (IBAction)resetClick;

@end

@implementation ZHTradeQueryViewController {
    UserInfo *_user;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    self.title = @"申请查询";
    [self addDatePicker];
    [self resetDateInput];
    [self radiusButton];
    
}
-(void)requsetData
{
//    NSString*urlString = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/searchHisApp?id=%@&passwd=%@&begindate=%@&enddate=%@",ZHServerAddress,self.userAccount.userName,self.userAccount.password,self.beginDateField.text,self.endDateField.text];
    NSString *urlString =[NSString stringWithFormat:searchHisAppnew,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],self.beginDateField.text,self.endDateField.text];
   NSLog(@"%@",urlString);
//    NSDictionary*para = @{@"passwd":self.userAccount.password};
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
       
        NSString*str = [self dictoriesStringWith:(NSData*)responseObject];
        self.resultsArr = [ZHTradeQueryInfo arrayOfModelsFromData:[str dataUsingEncoding:NSUTF8StringEncoding] error:NULL];
        if (self.resultsArr.count == 0) {
            [MBProgressHUD showError:@"没有查询到记录"];
        } else {
            [self.queryResultTableView reloadData];
        }
//        NSLog(@"%@",self.resultsArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
//        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
    }];
}
-(NSString*)dictoriesStringWith:(NSData*)data
{
    
    NSData *newData = [data dataFromGBKToUTF8];
    //        NSLog(@"%@",data);
    NSString*str = [[NSString alloc]initWithData:newData encoding:NSUTF8StringEncoding];
    NSRange range1 = [str rangeOfString:@"<return>"];
    NSRange range2 = [str rangeOfString:@"</return>"];
    NSInteger loc = range1.length+range1.location;
    NSInteger len = range2.location -range2.length- range1.location +1;
    str = [str substringWithRange:NSMakeRange(loc, len)];
    return str;
}
-(NSString*)stringWithDate:(NSDate*)date
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSString*dateStr = [formatter stringFromDate:date];
    return dateStr;
}
-(void)addDatePicker
{
    UIScreen*screen = [UIScreen mainScreen];
    //添加时间选择器
    UIDatePicker*datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode =UIDatePickerModeDate;
//    datePicker.maximumDate = [NSDate date];
    self.datePicker = datePicker;
    datePicker.backgroundColor = [UIColor whiteColor];
    //添加完成View
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen.bounds.size.width, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    UIButton*doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.width = 50;
    doneBtn.height = 30;
    doneBtn.x = view.width - doneBtn.width;
//    NSLog(@"%f",);
    doneBtn.y = 0;
    [doneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(datePickClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:doneBtn];
    //将时间选择器和完成View作为输入框键盘
    self.beginDateField.inputAccessoryView = view;
    self.beginDateField.inputView = datePicker;
    
    self.endDateField.inputView = datePicker;
    self.endDateField.inputAccessoryView = view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)datePickClick
{
    //选择时间
        NSString*dateString = [self stringWithDate:self.datePicker.date];
    if ([self.beginDateField isFirstResponder]) {
        self.beginDateField.text = dateString;
    } else if ([self.endDateField isFirstResponder]) {
        self.endDateField.text = dateString;
    }
    
    
    
    
    [self.view endEditing:YES];
}
-(void)resetDateInput
{
    NSCalendar*calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents*comps = [[NSDateComponents alloc]init];
    [comps setMonth:-1];
    NSDate* dateBefore30Days = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSString*dateBefore30 = [self stringWithDate:dateBefore30Days];
     self.beginDateField.text = dateBefore30;
    NSString*date = [self stringWithDate:[NSDate date]];
   
    self.endDateField.text = date;
}
- (IBAction)queryClick {
    [self requsetData];
}

- (IBAction)resetClick {
    [self resetDateInput];

}
#pragma mark - 懒加载
-(NSMutableArray *)resultsArr
{
    if (_resultsArr == nil) {
        _resultsArr = [NSMutableArray array];
    }
    return _resultsArr;
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHTradeQueryResultTableViewCell*cell = [ZHTradeQueryResultTableViewCell tradeQueryResultTableViewCellWith:tableView];
    ZHTradeQueryInfo*tradeQueryInfo = self.resultsArr[indexPath.row];
    cell.tradeQueryInfo = tradeQueryInfo;
    cell.delegate = self;
    return cell;
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - ZHTradeQueryResultTableViewCellDelegate
-(void)tradeQueryResultTableViewCellDidClickDetailButton:(ZHTradeQueryResultTableViewCell *)cell
{
    ZHTradeQueryDetailViewController*detailVC = [[ZHTradeQueryDetailViewController alloc]init];
    detailVC.tradeQueryInfo = cell.tradeQueryInfo;
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end

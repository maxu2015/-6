//
//  DealNotesViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/9/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "DealNotesViewController.h"
#import "PrivateNotesCellTableViewCell.h"
#import "NetManager.h"
#import "userInfo.h"
@interface DealNotesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableNotes;
@property (weak, nonatomic) IBOutlet UILabel *alertTit;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@end

@implementation DealNotesViewController {
    NSArray *_dataArray;
    NetManager *_netManager;
    UserInfo *_user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableNotes.delegate=self;
    _tableNotes.dataSource=self;
    _netManager=[NetManager shareNetManager];
    _user=[UserInfo shareManager];
    _tableNotes.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableNotes.bounces=NO;
    [self createData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
};
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 131;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateNotesCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"PrivateNotesCellTableViewCell" owner:self options:nil][0];
    }
    NSDictionary *dic=_dataArray[indexPath.row];
    cell.state.text=[NSString stringWithFormat:@"(%@)",[dic objectForKey:@"Operation"]];
    cell.Startdate.text=[dic objectForKey:@"Startdate"];
    cell.Fnetmoney.text=[dic objectForKey:@"Fnetmoney"];
    cell.Amountvol.text=[dic objectForKey:@"Amountvol"];
    cell.UnitPrice.text=[dic objectForKey:@"UnitPrice"];
    cell.fundName.text=[dic objectForKey:@"SName"];

    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)createData {
    [ProgressHUD show:nil];
    _netManager =[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:@"%@%@",JYJL,[[_user userInfoDic] objectForKey:@"IDCard"] ];
    
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _dataArray=[NSArray arrayWithArray:data];
        if (_dataArray.count==0) {
            _alertTit.alpha=1;
            _logo.alpha=1;
            _tableNotes.alpha=0;
        }
        NSLog(@"sadasd===%@",_dataArray);
        [_tableNotes reloadData];
        [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        _alertTit.alpha=1;
        _logo.alpha=1;
        _tableNotes.alpha=0;
        [ProgressHUD dismiss];
    } Tag:'cell'];
}
@end

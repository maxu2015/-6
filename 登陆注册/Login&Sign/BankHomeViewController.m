//
//  BankHomeViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-7-24.
//  Copyright (c) 2015年  展恒. All rights reserved.
//


//选择支行
typedef enum TABLETYPE {
seacher=1010,
    list=1011

}TABLETYPE;
#import "BankHomeViewController.h"
#import "Header.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "IndexFuctionApi.h"
@interface BankHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField *_field;
    UIButton *_searchBtn;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_searchArr;
}
@end

@implementation BankHomeViewController{

    TABLETYPE _tableTy;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableTy=list;
    _field.delegate=self;
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择银行";
    _field.returnKeyType=UIReturnKeySearch;
    
    _field = [[UITextField alloc]initWithFrame:CGRectMake(10, 74, WIDTH-60, 40)];
    _field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_field];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _searchBtn.frame = CGRectMake(WIDTH-40, 74, 40, 40);
    _searchBtn.backgroundColor = [UIColor redColor];
    [_searchBtn setTintColor:[UIColor whiteColor]];
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchBtn];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, WIDTH, HEIGHT-74)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //_dataArr = [NSArray arrayWithObjects:@"支行1",@"支行2", nil];
    _dataArr = [[NSMutableArray alloc]init];
    NetManager *manager = [NetManager shareNetManager];
    [manager dataGetRequestWithUrl:[NSString stringWithFormat:querybankCode,apptrade8000,[self.cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.channelid] Finsh:^(id data, NSInteger tag) {
        NSArray *item = [NSData baseItemWith:data];
        for (NSDictionary *dict in item) {
            [_dataArr addObject:dict[@"paravalue"]];
        }
        [_tableView reloadData];
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_tableTy==list) {
        return [_dataArr count];
    }else {
        return [_searchArr count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (_tableTy==list) {
        cell.textLabel.text = [_dataArr objectAtIndex:indexPath.row];
    }else {
        cell.textLabel.text = [_searchArr objectAtIndex:indexPath.row];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *Str;
    if (_tableTy==list) {
        Str =_dataArr[indexPath.row];
    }else {
    Str =_searchArr[indexPath.row];
    }
 
    self.bankHomeBlock(Str);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBtn{
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF CONTAINS %@",_field.text];
    _searchArr=[NSMutableArray arrayWithArray: [_dataArr filteredArrayUsingPredicate:pred]];
//    for (NSString *bankHome in _dataArr) {
//        if ([_field.text ]) {
//            
//        }
//    }
    _tableTy=seacher;
    [_tableView reloadData];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchBtn];
    [_field resignFirstResponder];
    return YES;
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

//
//  ProductManagerViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "ProductManagerViewController.h"
#import "HCMangerTableViewCell.h"

@interface ProductManagerViewController ()<HCMangerTableViewCellDelegate>

@end

@implementation ProductManagerViewController

#pragma mark------预约

-(void)clickEdit:(HCMangerTableViewCell *)cell{
   
}

-(id)initWithfundCode:(NSString *)fundCode{
    self = [super init];
    if (self) {
        self.proCode = fundCode;
    }
    return self ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self GetProductCode];
}
//基金经理信息code
-(void)GetProductCode{

    [ProgressHUD show:nil];
    
    NSString *url = [NSString stringWithFormat:FundGetProductCode, apptrade8484,_proCode];
    
    NSLog(@"======%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
        // [ProgressHUD dismiss];
        
        if (!connectionError) {
            _ProductCodeArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (_ProductCodeArray.count>0&&[_ProductCodeArray isKindOfClass:[NSArray class]]) {//产品code请求成
                [self GetFundManager:_ProductCodeArray];
            }
        }
        
    }];
}
//基金经理信息
-(void)GetFundManager:(NSArray *)codeArray{
    NSDictionary *dic = [codeArray objectAtIndex:0];
    NSString *percode = [dic objectForKey:@"FundMGCode"];
    NSString *url = [NSString stringWithFormat:FundGetFundManager, apptrade8484,percode];
    
    //NSLog(@"======%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
        // [ProgressHUD dismiss];
        
        if (!connectionError) {
         NSArray  *manArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
           // NSLog(<#NSString *format, ...#>)
            if (manArray.count>0&&[manArray isKindOfClass:[NSArray class]]) {//
               
                [_managerInfoView reloadContentData:manArray];
                NSString *Summary = [[manArray objectAtIndex:0] objectForKey:@"Summary"];//经理描述
                CGSize  dessize = [self getSizeOfStr:Summary font:[UIFont systemFontOfSize:11]];
                _jingliDesLB.text = Summary ;
                _jingliDesLB.frame = CGRectMake(15, 120, 290, dessize.height);
            
                _desLB1.frame = CGRectMake(15, 120+dessize.height, 200, 30);
                _proScrollView.frame = CGRectMake(0, 150+dessize.height, SCREEN_WIDTH, 28*4);
                if (150+dessize.height+28*4>568-64-35) {
                    _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,50+ 150+dessize.height+28*4);
                }
                
            }
        }
        
        [self GetCurrentProduct:_ProductCodeArray];
    }];

}
//得到当前产品
-(void)GetCurrentProduct:(NSArray *)proarray{

    NSDictionary *dic = [proarray objectAtIndex:0];
    NSString *percode = [dic objectForKey:@"FundMGCode"];
    NSString *url = [NSString stringWithFormat:FundGetCurrentProduct, apptrade8484, percode];
    
    NSLog(@"======%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
        // [ProgressHUD dismiss];
        
        [ProgressHUD dismiss];
        if (!connectionError) {
            _currentProArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (_currentProArray.count>0&&[_currentProArray isKindOfClass:[NSArray class]]) {//
                [_productTableView reloadData];
            }
        }
        
    }];
    
}
- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(290 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size;
}
-(UILabel *)creatLB{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = COLOR_RGB(73, 73, 73);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES ;
    return label;
}
-(void)setUI{
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35)];
    if (SCREEN_HEIGHT<568) {
        _ScrollView.contentSize  = CGSizeMake(SCREEN_WIDTH, 568-64-35+50);
    }
    else{
    
     _ScrollView.contentSize  = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-35+50);
    }
    //_ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    //_ScrollView.userInteractionEnabled = NO ;
    _ScrollView.backgroundColor = [UIColor whiteColor];
    _ScrollView.bounces = NO;
    _ScrollView.showsHorizontalScrollIndicator = NO;
    _ScrollView.showsVerticalScrollIndicator   = NO;
    [self.view addSubview:_ScrollView] ;
    //
    
    _managerInfoView = [[ManagerView1 alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 90)];
    //[_managerInfoView reloadContentData];
    [_ScrollView addSubview:_managerInfoView] ;
    
    //
    UILabel *desLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 200, 30)];
    desLB.text = @"经理概况";
    desLB.font = [UIFont systemFontOfSize:13];
    desLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:desLB];
    
    _jingliDesLB = [self creatLB];
    _jingliDesLB.textAlignment = NSTextAlignmentLeft ;
    _jingliDesLB.frame = CGRectMake(15, 120, SCREEN_WIDTH-30, 65);
    _jingliDesLB.numberOfLines = 0 ;
    //_jingliDesLB.text = @"英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，英国伯明翰大学毕业，";
    [_ScrollView addSubview:_jingliDesLB];
    //
    
    _desLB1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 185, 200, 30)];
    _desLB1.text = @"当前产品系列";
    _desLB1.font = [UIFont systemFontOfSize:13];
    _desLB1.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:_desLB1];
    //
    
    _proScrollView = [[UIScrollView alloc] init];
    _proScrollView.contentSize = CGSizeMake(70*7, 28*4);
    _proScrollView.showsHorizontalScrollIndicator = NO;
    _proScrollView.showsVerticalScrollIndicator = NO;
    _proScrollView.bounces = NO;
    [_ScrollView addSubview:_proScrollView];
    _productTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 70*7, 28*4)];
    _productTableView.bounces = NO;
    _productTableView.delegate = self;
    _productTableView.dataSource = self;
    //_productTableView.contentSize = CGSizeMake(65*7, 80);
    [_proScrollView addSubview:_productTableView];
    
}

#pragma mark--------uitableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_currentProArray count] ;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString  *CELLID = @"CELLID";
    HCMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[HCMangerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    NSDictionary *dic = [[_currentProArray objectAtIndex:indexPath.row] copy];
    [cell reloadData:dic];
    cell.delegate = self;
    return cell ;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 28;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28 ;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65*7, 28)];
    backView.backgroundColor = COLOR_RGB(154, 154, 154);
    
   UILabel *_fundNameLB = [self creatLB];
   UILabel *_jingliNameLB = [self creatLB];
    UILabel *_jingzhiTimeLB = [self creatLB];
    UILabel *_todayLB = [self creatLB];
    UILabel *_oneYearLB = [self creatLB];
    UILabel *_chengliTimeLB = [self creatLB];
    UILabel *_caozuoLB = [self creatLB];
    
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"基金简称",@"基金经理",@"最新净值/日期",@"今年来收益率",@"近一年收益率",@"成立日期",@"操作", nil];
    NSArray *UIarray = [[NSArray alloc] initWithObjects:_fundNameLB,_jingliNameLB,_jingzhiTimeLB,_todayLB,_oneYearLB,_chengliTimeLB,_caozuoLB, nil];
    float  uiwith = 482.0/7.0 ; //宽度
    
    for (int i =0; i<7; i++) {
        float posX = 1+ (uiwith+1)*i;
        // float posY =  0 ;
        UILabel *myLbael = [UIarray objectAtIndex:i];
        myLbael.text = [titleArr objectAtIndex:i];
        myLbael.frame = CGRectMake(posX, 1, uiwith, 26);
        [backView addSubview:myLbael];
    }
    
    return backView ;
    
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

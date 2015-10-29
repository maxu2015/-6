 //
//  BankCardViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-7-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//


//绑定银行卡
#import "BankCardViewController.h"
#import "Header.h"
#import "BankChooseViewController.h"
#import "InfoSureViewController.h"
#import "BankHomeViewController.h"
@interface BankCardViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITextField *_CardField;
    UIPickerView *_pickerView;
    NSDictionary *_dic;
    NSArray *_ProvinceArray;
    NSArray *_CityArray;
    UIView *_view;
    UIView *_view1;
    NSString *_ProStr;
    NSString *_CityStr;
    NSDictionary *_dictionary;
}
@end

@implementation BankCardViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = COLOR_RGB(236, 235, 240);
    self.title = @"绑定银行卡";
    
    NSArray *array = [NSArray arrayWithObjects:@"   银行",@"   省市",@"   开户行", nil];
    for (int i=0; i<4; i++) {
        if (i<3) {
            
            if (i==1) {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 94+i*50, 100, 50)];
                label.text = array[i];
                label.tag = 100+i;
                label.backgroundColor = [UIColor whiteColor];
                
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 94+i*50, WIDTH-100-50, 50)];
                label1.tag = 104;
                label1.backgroundColor = [UIColor whiteColor];
                
                [self.view addSubview:label];
                [self.view addSubview:label1];
                
            }else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 94+i*50, WIDTH-50, 50)];
            label.backgroundColor = [UIColor whiteColor];
            label.tag = 100+i;
            label.text = array[i];
            [self.view addSubview:label];
            
            
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(WIDTH-50, 94+i*50, 50, 50);
            btn.tag = 1000+i;
            [btn setBackgroundImage:[UIImage imageNamed:@"rightImage"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 244, 90, 50)];
            label.backgroundColor = [UIColor whiteColor];
            label.text = @"   卡号";
            [self.view addSubview:label];
            
            _CardField = [[UITextField alloc]initWithFrame:CGRectMake(90, 244, WIDTH-90, 50)];
            _CardField.tag = 103;
            _CardField.backgroundColor = [UIColor whiteColor];
            _CardField.borderStyle = UITextBorderStyleNone;
            _CardField.placeholder = @"请输入银行卡卡号";
            [self.view addSubview:_CardField];
        }
    }
    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 140+i*50, WIDTH-20, 1)];
        view.backgroundColor = COLOR_RGB(236, 235, 240);
        [self.view addSubview:view];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 294, WIDTH-40, 50)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"我们已将一笔小额资金打入你的银行卡，用以验证你的银行卡，请注意查收";
    [self.view addSubview:label];
    
    UIButton *SureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    SureBtn.frame = CGRectMake(10, 344, WIDTH-20, 45);
    SureBtn.layer.masksToBounds = YES;
    SureBtn.layer.cornerRadius = 5;
    [SureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [SureBtn setBackgroundColor:[UIColor redColor]];
    [SureBtn setTintColor:[UIColor whiteColor]];
    SureBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [SureBtn addTarget:self action:@selector(SureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SureBtn];
    
    [self CreatePickerView];
    _view1.hidden = YES;
    _view.hidden = YES;
}

-(void)SureClick{
    
//    InfoSureViewController *ifvc = [[InfoSureViewController alloc]init];
//    [self.navigationController pushViewController:ifvc animated:YES];
//    return;
    
    UILabel *BankLabel = (UILabel *)[self.view viewWithTag:100];
    UILabel *ProLabel = (UILabel *)[self.view viewWithTag:101];
    UILabel *CityLabel = (UILabel *)[self.view viewWithTag:104];
    UILabel *HomeLabel = (UILabel *)[self.view viewWithTag:102];
    if (BankLabel.text.length>0) {
        if (ProLabel.text.length>0) {
            if (CityLabel.text.length>0) {
                if (_CardField.text.length>0) {
                    NSLog(@"dsfsadfjf===%@",HomeLabel.text);
                    NSString *strUrl = [HomeLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                    if (![[strUrl substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"开户行"]) {
                        
                    
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          BankLabel.text,@"bank",
                                          ProLabel.text,@"province",
                                          CityLabel.text,@"city",
                                          HomeLabel.text,@"homebank",
                                          _CardField.text,@"bankcard",
                                          _dictionary[@"channelid"],@"channelid",
                                          _dictionary[@"paycenterid"],@"paycenterid",nil];
#pragma mark-debug nil
                    [dict writeToFile:[NSString stringWithFormat:@"%@/Documents/bank.plist",NSHomeDirectory()] atomically:YES];
                    
                    
                    InfoSureViewController *ifvc = [[InfoSureViewController alloc]init];
                        [self.navigationController pushViewController:ifvc animated:YES];}else{
                        [self alertShow:@"请选择开户行"];
                        }
                    
                }else {
                [self alertShow:@"请填写银行账号"];
                }
               

            }else{
                [self alertShow:@"请选择城市"];
            
            }
        }else{
        [self alertShow:@"请选择省"];
        }
    }else{
    [self alertShow:@"请选择银行"];
    
    }
    
}
- (void)alertShow:(NSString *)msg {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
  

}
-(void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1000:{
            BankChooseViewController *BCVC = [[BankChooseViewController alloc]init];
            BCVC.bankBlock = ^(NSDictionary *dictionary){
                UILabel *label = (UILabel *)[self.view viewWithTag:100];
                _dictionary = dictionary;
                label.text = dictionary[@"channelname"];
                
            };
            [self.navigationController pushViewController:BCVC animated:YES];
        }
            break;
        case 1001:{
            _view1.hidden = NO;
            _view.hidden = NO;
            
        }
            break;
        case 1002:{
            BankHomeViewController *bhvc = [[BankHomeViewController alloc]init];
            UILabel *CityLabel = (UILabel *)[self.view viewWithTag:104];
            bhvc.channelid = _dictionary[@"channelid"];
            bhvc.cityName = CityLabel.text;
            NSLog(@"%@====clnm====%@",bhvc.channelid,bhvc.cityName);
#pragma mark -debug
            bhvc.bankHomeBlock = ^(NSString *Str){
                UILabel *label = (UILabel *)[self.view viewWithTag:102];
                label.font = [UIFont systemFontOfSize:15];
                label.numberOfLines = 0;
                label.text = Str;
            };
            [self.navigationController pushViewController:bhvc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)CreatePickerView{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _view.backgroundColor = COLOR_RGBA(115, 115, 117, 0.7);
    [self.view addSubview:_view];
    
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(10, HEIGHT-300, WIDTH-20, 300)];
    _view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view1];
    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(20, 50, WIDTH-60, 200)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    [_view1 addSubview:_pickerView];
    
    
    UILabel *labelChoose = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    labelChoose.text = @"选择所在省市";
    [_view1 addSubview:labelChoose];
    
    UIButton *btnCancle = [UIButton buttonWithType:UIButtonTypeSystem];
    btnCancle.frame = CGRectMake(WIDTH-60, 0, 40, 40);
    [btnCancle setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancle setTintColor:[UIColor blackColor]];
    [btnCancle addTarget:self action:@selector(btnCancle) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:btnCancle];
    
    UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSure.frame = CGRectMake(0, 200, WIDTH-20, 50);
    [btnSure setTitle:@"确认" forState:UIControlStateNormal];
    btnSure.backgroundColor = [UIColor redColor];
    [btnSure setTintColor:[UIColor whiteColor]];
    btnSure.titleLabel.font = [UIFont systemFontOfSize:22];
    [btnSure addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:btnSure];
    
    _dic = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"proAndCityinfo" ofType:@"plist"]];
    NSLog(@"_dic====%@",_dic);
    
    _ProvinceArray = [_dic allKeys];
    NSLog(@"_provinceArr===%@",_ProvinceArray);
    
    NSInteger seleteProIndex = [_pickerView selectedRowInComponent:0];
    NSString *seletePro = [_ProvinceArray objectAtIndex:seleteProIndex];
    _CityArray =[_dic objectForKey:seletePro];
    NSLog(@"_cityArr===%@",_CityArray);
    
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [_ProvinceArray count];
    } else {
        return [_CityArray count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [_ProvinceArray objectAtIndex:row];
    } else {
        return [_CityArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *seletedProvince = [_ProvinceArray objectAtIndex:row];
        _CityArray = [_dic objectForKey:seletedProvince];
        
        //重点！更新第二个轮子的数据
        [_pickerView reloadComponent:1];
        
        NSInteger selectedCityIndex = [_pickerView selectedRowInComponent:1];
        NSString *seletedCity = [_CityArray objectAtIndex:selectedCityIndex];
        
        _ProStr = seletedProvince;
        _CityStr = seletedCity;
        
    }
    else {
        NSInteger selectedProvinceIndex = [_pickerView selectedRowInComponent:0];
        NSString *seletedProvince = [_ProvinceArray objectAtIndex:selectedProvinceIndex];
        
        NSString *seletedCity = [_CityArray objectAtIndex:row];
        _ProStr = seletedProvince;
        _CityStr = seletedCity;
    }
}

-(void)btnCancle{
    _view.hidden = YES;
    _view1.hidden = YES;
    
}

-(void)btnSure{
    UILabel *label = (UILabel *)[self.view viewWithTag:101];
    UILabel *label1 = (UILabel *)[self.view viewWithTag:104];
    label.text = _ProStr;
    label1.text = _CityStr;
    _view.hidden = YES;
    _view1.hidden = YES;
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

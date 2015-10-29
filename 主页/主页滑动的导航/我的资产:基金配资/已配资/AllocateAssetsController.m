//
//  AllocateAssetsController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/28.
//  Copyright (c) 2015年 08. All rights reserved.
//
#import "AllocateAssetsController.h"
#import "CDPPickerView.h"
#import "peiziwanchengViewController.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"

@interface AllocateAssetsController ()<CDPPickerViewDelegate>
@property (nonatomic,strong)UILabel *label;

@property (nonatomic,strong) CDPPickerView *pickerView;
@property (nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)UIView *benjinView;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,copy)NSString *touzijinea;
@property (nonatomic,copy)NSString *jiaonacg;
@property (nonatomic,strong)NetManager *netManager;
@property (nonatomic,copy)NSString *tijiaostr;
@property (nonatomic,copy)NSString *peizicg;
@property (nonatomic,copy)NSString *bili;
@property (nonatomic,copy)NSString *qixianriqi;
@property (weak, nonatomic) IBOutlet UIView *viewscr;
@property (nonatomic,strong)NSDictionary *shenfenArray;
@property (nonatomic,copy)NSString *IDCard;

@end
@implementation AllocateAssetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize=self.viewscr.frame.size;
    
    
    
    //4 不显示滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO; //水平滚动条
    //self.scrollView.showsVerticalScrollIndicator = NO; //垂直滚动条
    
    //5 弹簧效果
    self.scrollView.bounces = YES;
    
    [self biaoshi];
    [self peizijine];
    [self gangganbili];
    [self qixian];
   
}
- (void)biaoshi{
    //最高五万
    UILabel *benjin=[[UILabel alloc]initWithFrame:CGRectMake(10, 115, SCREEN_WIDTH, 10)];
    benjin.textColor=[UIColor grayColor];
    benjin.font=[UIFont systemFontOfSize:13];
    benjin.text=@"本金最高5万";
    [_viewscr addSubview:benjin];
    //最高三倍
    UILabel *sanbei=[[UILabel alloc]initWithFrame:CGRectMake(10, 185, SCREEN_WIDTH, 10)];
    sanbei.textColor=[UIColor grayColor];
    sanbei.font=[UIFont systemFontOfSize:13];
    sanbei.text=@"最高三倍";
    [_viewscr addSubview:sanbei];

}
- (void)peizijine{

    _benjinView=[[UIView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 40)];
    _benjinView.backgroundColor=[UIColor whiteColor];
    [_viewscr addSubview:_benjinView];
    _label=[[UILabel alloc]initWithFrame:CGRectMake(8, 14, 114, 21)];
    _label.text=@"投资本金";
    [_benjinView addSubview:_label];
    _touzibenjin=[[UILabel alloc]initWithFrame:CGRectMake(193, 12, 70, 21)];
    _touzibenjin.text=@"10000";
    _jiaonacg=@"10000元";
    _touzijinea=@"10000";
    [_benjinView addSubview:_touzibenjin];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 36, 12, 26, 25)];
    image.image=[UIImage imageNamed:@"xuanquqi.png"];
    [_benjinView addSubview:image];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(100, 8, 218, 30)];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:1];
    [_benjinView addSubview:button];


}
- (void)gangganbili{

   UIView *gangganV =[[UIView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 40)];
    gangganV.backgroundColor=[UIColor whiteColor];
    [_viewscr addSubview:gangganV];
    UILabel *ganggai=[[UILabel alloc]initWithFrame:CGRectMake(8, 14, 114, 21)];
    ganggai.text=@"杠杆比例";
    [gangganV addSubview:ganggai];
    _gangganbililabel=[[UILabel alloc]initWithFrame:CGRectMake(193, 12, 70, 21)];
    _gangganbililabel.text=@"1:1";
    _peizicg=@"10000元";
    _bili=@"1:1";
    [gangganV addSubview:_gangganbililabel];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 36, 12, 26, 25)];
    image.image=[UIImage imageNamed:@"xuanquqi.png"];
    [gangganV addSubview:image];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(100, 8, 218, 30)];
    [button addTarget:self action:@selector(ganggantiaozhuan) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:2];
    [gangganV addSubview:button];

}
- (void)qixian{
    
    UIView *qixianV =[[UIView alloc]initWithFrame:CGRectMake(0, 205, SCREEN_WIDTH, 40)];
    qixianV.backgroundColor=[UIColor whiteColor];
    [_viewscr addSubview:qixianV];
    UILabel *qixian=[[UILabel alloc]initWithFrame:CGRectMake(8, 14, 114, 21)];
    qixian.text=@"期限";
    [qixianV addSubview:qixian];
    _qixianlabel=[[UILabel alloc]initWithFrame:CGRectMake(193, 12, 70, 21)];
    _qixianlabel.text=@"91";
    _qixianriqi=@"91";
    [qixianV addSubview:_qixianlabel];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 36, 12, 26, 25)];
    image.image=[UIImage imageNamed:@"xuanquqi.png"];
    [qixianV addSubview:image];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(100, 8, 218, 30)];
    [button addTarget:self action:@selector(qixiantiaozhuan) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:3];
    [qixianV addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)CDPPickerViewDidClickConfirm:(NSString *)confirmString{
    
   
    if([confirmString isEqualToString:@"10000"]||[confirmString isEqualToString:@"20000"]||[confirmString isEqualToString:@"30000"]||[confirmString isEqualToString:@"40000"]||[confirmString isEqualToString:@"50000"]){
            _touzibenjin.text=confirmString;
        _touzijinea=confirmString;
       _jiaonacg=[NSString stringWithFormat:@"%@元",confirmString];
       
    }else if([confirmString isEqualToString:@"1:1"]||[confirmString isEqualToString:@"1:2"]||[confirmString isEqualToString:@"1:3"]){
    
        _gangganbililabel.text=confirmString;
        
        if ([confirmString isEqualToString:@"1:1"]) {
            int benjin=[_touzijinea intValue]*1;
            _bili=confirmString;
           _peizicg=[NSString stringWithFormat:@"%d元",benjin];
            
            
        }else if([confirmString isEqualToString:@"1:2"]){
        _bili=confirmString;
            int benjin=[_touzijinea intValue]*2;
            
            _peizicg=[NSString stringWithFormat:@"%d元",benjin];
           
        
        }
        else if([confirmString isEqualToString:@"1:3"]){
            _bili=confirmString;
            int benjin=[_touzijinea intValue]*3;
            
            _peizicg=[NSString stringWithFormat:@"%d元",benjin];
            
            
        }

    }else if ([confirmString isEqualToString:@"91"]||[confirmString isEqualToString:@"181"]){
        if ([confirmString isEqualToString:@"91"]) {
            _qixianlabel.text=confirmString;
            _qixianriqi=confirmString;
        }else if([confirmString isEqualToString:@"181"]){
        
            _qixianlabel.text=confirmString;
            _qixianriqi=confirmString;
        }
        
    }
    
}

-(void)click{
    
    NSArray *arr=[[NSArray alloc] initWithObjects:@"10000",@"20000",@"30000",@"40000",@"50000",nil];
    _pickerView =[[CDPPickerView sharedInstance]initWithDataArr:arr selectTitle:nil rowHeight:30 delegate:self delegateView:self.view];
            [_pickerView pushPicker];
}
- (void)ganggantiaozhuan{
    NSArray *arr=[[NSArray alloc] initWithObjects:@"1:1",@"1:2",@"1:3",nil];
    _pickerView =[[CDPPickerView sharedInstance]initWithDataArr:arr selectTitle:nil rowHeight:30 delegate:self delegateView:self.view];        [_pickerView pushPicker];


}
- (void)qixiantiaozhuan{
    NSArray *arr=[[NSArray alloc] initWithObjects:@"91",@"181",nil];
   _pickerView =[[CDPPickerView sharedInstance]initWithDataArr:arr selectTitle:nil rowHeight:30 delegate:self delegateView:self.view];
    [_pickerView pushPicker];
}
- (IBAction)woyaopeizi:(UIButton *)sender {
    
    [self tijiaoyitiaopeizi];
   
    
}
- (void)tijiaoyitiaopeizi{
    [ProgressHUD show:nil];
    _shenfenArray=[[UserInfo shareManager] userInfoDic];
    self.IDCard = [_shenfenArray objectForKey:@"IDCard"];
    _netManager =[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:api,self.IDCard,_touzijinea,_bili,_qixianriqi];
    
    [_netManager dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        
        NSString *utf8str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        NSRange range1 = [utf8str rangeOfString:@"<return>"];
                NSRange range2 = [utf8str rangeOfString:@"</return>"];
        NSInteger loc = range1.length+range1.location;
        
        NSInteger len = range2.location -range2.length- range1.location +1;
        
        NSString *str = [utf8str substringWithRange:NSMakeRange(loc, len)];
        
        if ([str isEqualToString:@"true"]) {
            peiziwanchengViewController *peizi=[[peiziwanchengViewController alloc]init];
            NSLog(@"------%@",_peizicg);
            peizi.peizijinee=_peizicg;
            peizi.jiaonabenjin=_jiaonacg;
            [self.navigationController pushViewController:peizi animated:YES];
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD dismiss];
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"配资失败" message:@"请重新提交" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
            
        }

        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'0'];
    


}
@end

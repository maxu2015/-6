//
//  FundRedemOneViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-19.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//



#import "FundRedemOneViewController.h"
#import "FundRedemThrViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"

/***  shz  ***/
#import "JudgeFormate.h"


@interface FundRedemOneViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UILabel *fundNameLB   ; //基金名称
@property(nonatomic,strong)UILabel *fundFenELB   ;//持有份额
@property(nonatomic,strong)UILabel *fundFreezeLB ;//冻结份额
@property(nonatomic,strong)UILabel *fundOkFenELB ;//可用份额
@property(nonatomic,strong)UITextField *fundRedeemTF ;//赎回份额
@property(nonatomic,strong)UILabel *fundPromptMessLB;//赎回份额提示信息
@property(nonatomic,strong)UILabel *fundFenEBigLB ;//份额大写
@property(nonatomic,strong)UITextField *fundRedeemMarkerTF;//巨额赎回标志
@property(nonatomic,strong)NSMutableArray *titleArr;//保存控件的数组

@property(nonatomic,strong)UIView *pickBackView    ;//
@property(nonatomic,strong)UIPickerView *pickView  ;//
@property(nonatomic,strong)NSArray      *pickArray;

@property(nonatomic,strong)NSString     *shuHuiTag  ;//赎回标志

@end

@implementation FundRedemOneViewController {
    UserInfo *_user;
    NetManager *_net;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    _net=[NetManager shareNetManager];
    [self startLayerUI] ;
    
}

-(void)startLayerUI{

    _shuHuiTag = @"取消" ; //赎回标志默认是取消
    //控件数组的创建
    _fundNameLB      = [[UILabel alloc] init];
    _fundFenELB      = [[UILabel alloc] init];
    _fundFreezeLB    = [[UILabel alloc] init];
    _fundOkFenELB    = [[UILabel alloc] init] ;
    _fundRedeemTF    = [[UITextField alloc] init];
    _fundRedeemTF.delegate = self ;
    _fundRedeemTF.tag      = 1 ;
    _fundRedeemTF.returnKeyType = UIReturnKeyDone ;
    _fundPromptMessLB = [[UILabel alloc] init];
    _fundFenEBigLB    = [[UILabel alloc] init];
    _fundRedeemMarkerTF = [[UITextField alloc] init];
    _fundRedeemMarkerTF.layer.borderColor = [[UIColor blackColor] CGColor];
    _fundRedeemMarkerTF.layer.borderWidth = .5 ;
    _fundRedeemMarkerTF.tag = 2;
    _fundRedeemMarkerTF.delegate = self;
    _fundRedeemMarkerTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _titleArr = [[NSMutableArray alloc] initWithObjects:_fundNameLB,_fundFenELB,_fundFreezeLB,_fundOkFenELB,_fundRedeemTF,_fundPromptMessLB,_fundFenEBigLB,_fundRedeemMarkerTF, nil];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:_scrollView];
    
    //常见pickView
    
    UILabel *redeemLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 15)];
    redeemLB.text = @"赎回信息" ;
    redeemLB.textColor = [UIColor grayColor] ; 
    [_scrollView addSubview:redeemLB];
    
    UIView *redemLine =[[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    redemLine.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:redemLine];
    
    UIView *redemLine1 =[[UIView alloc] initWithFrame:CGRectMake(0, 430, SCREEN_WIDTH, 1)];
    redemLine1.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:redemLine1];
    
    //点击确认按钮
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBtn.frame = CGRectMake(70, 445, SCREEN_WIDTH-140, 35);
    [subBtn setBackgroundImage:[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [subBtn setTitle:@"确定" forState:UIControlStateNormal];
    subBtn.layer.cornerRadius = 4 ;
    subBtn.clipsToBounds      = YES ;
    [subBtn addTarget:self action:@selector(clickSubBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:subBtn] ;
    if (SCREEN_HEIGHT<64+445+35) {
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 64+445+35);
    }
    //
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"基金名称:",@"持有份额:",@"冻结份额:",@"可用份额:",@"赎回份额:",@"份额大写:",@"巨额赎回标志:", nil];
    
    float posY = 0.0 ;
    for (int i  = 0; i<7; i++) {
        UILabel *titleLabe = [[UILabel alloc] init];
        titleLabe.text = [titleArr objectAtIndex:i];
        titleLabe.font = [UIFont systemFontOfSize:12];
        if (i==6) {
            titleLabe.frame = CGRectMake(10, 10, 80, 20);
        }
        else{
        
        titleLabe.frame = CGRectMake(10, 10, 55, 20);
        }
        //
        
        
        
        
        
        float posX = 0.0 ;
        
        float viewWidth = 0.0 ;
        if (i==4) {
            
            viewWidth = 60   ;
        }
        else{
            viewWidth = 40.0 ;
           
        }
        
        if (i==5) {
            posY = posY + 70 ;
        }
        else{
            posY = posY + 50 ;
        
        }
        
        
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(posX, posY, SCREEN_WIDTH, viewWidth)];
        backView.backgroundColor = [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
        [_scrollView addSubview:backView];
        //添加标题
        [backView addSubview:titleLabe];
        //添加控件
        if (i<4) {
            UILabel *label = [_titleArr objectAtIndex:i];
            label.frame = CGRectMake(65, 10, SCREEN_WIDTH-75, 20);
            label.font = [UIFont systemFontOfSize:12];
            [backView addSubview:label];
        }
        else if (i==4){
            UITextField *tf = [_titleArr objectAtIndex:i];
            tf.frame = CGRectMake(65, 0, 150, 30);
            tf.layer.borderWidth = 1 ;
            tf.layer.borderColor = [[UIColor grayColor] CGColor];
            tf.layer.cornerRadius = 4 ;
            [backView addSubview:tf];
            
            UILabel *label = [_titleArr objectAtIndex:i+1];
            label.font = [UIFont systemFontOfSize:12];
            label.frame = CGRectMake(10, 40, SCREEN_WIDTH-20, 20);
            label.textColor = [UIColor redColor];
            [backView addSubview:label];
        }
        else if (i==5){
            
            UILabel *label = [_titleArr objectAtIndex:i+1];
            label.frame = CGRectMake(65, 10, SCREEN_WIDTH-75, 20);
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor redColor];
            [backView addSubview:label];
        }
        else if (i==6){
            UITextField *TF = [_titleArr objectAtIndex:i+1];
            TF.frame = CGRectMake(100, 5, 65, 30);

            TF.text = @"取消" ;
            [backView addSubview:TF];
        }
    }

    
    NSString *condition = [_fundDic objectForKey:@"fundcode"];
    NSString *nameStr = [_fundDic objectForKey:@"fundname"];
    NSString *fenEStr = [_fundDic objectForKey:@"fundvolbalance"];//持有份额
    NSString *freezeFenEstr = [_fundDic objectForKey:@"trdfrozen"];//冻结份额
    NSString *okFenE    =  [_fundDic objectForKey:@"availablevol"];//可用份额
    
    
    _fundFenEMax = okFenE ; //可用份额最大值
    NSArray *dataArr = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"[%@]%@",condition,nameStr],fenEStr,freezeFenEstr,okFenE ,okFenE, nil];
    [self reloadDataArr:dataArr];
    
    [ProgressHUD show:nil];
#pragma mark -debug

    [NSString stringWithFormat: FUNDREDM ,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],condition];
    NSString *url=[NSString stringWithFormat:DINGTOU,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],condition,@"0",@"0"];
    [self requestDataURL:url];
    NSLog(@"siagdsa===%@",url);
}
- (void)requstHttp:(NSString *)url tag:(NSInteger)tag {
 [_net dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
     
 } fail:^(id errorMsg, NSInteger tag) {
     
 } Tag:tag];
}
#pragma mark------数据请求结束

-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];

}

-(void)requestDataEnd{
  [ProgressHUD dismiss];
    NSLog(@"--嘻嘻嘻-----%@",self.dic);
    if ([self.dic count]==0) {
        return;
    }
  
    _fundFenEMin = [[self.dic objectAtIndex:0] objectForKey:@"per_min_24"];
    
    NSString *fenERange = [NSString stringWithFormat:@"本金赎回范围（%.2f份~%.2f份）",[_fundFenEMin floatValue],[_fundFenEMax floatValue]];
    
    _fundPromptMessLB.text = fenERange ;
    
}
#pragma mark----clickSubBtn

-(void)clickSubBtn
{
    
    if ([JudgeFormate validaeNumberGreater:_fundRedeemTF.text] == YES) {
        
    if ([_fundRedeemTF.text floatValue]<[_fundFenEMin floatValue]&&[_fundRedeemTF.text floatValue]==[_fundFenEMax floatValue]) {

        [self redeemNext];
        return ;
    }
    if ([_fundFenEMax floatValue]<[_fundFenEMin floatValue]&&[_fundRedeemTF.text floatValue]<[_fundFenEMax floatValue]) {
        
                NSString *mess = [NSString stringWithFormat:@"交易金额错误，请全部赎回"];
        
                [self showToastWithMessage:mess showTime:1];
        return ;
    }

    
    if ([_fundRedeemTF.text floatValue]<[_fundFenEMin floatValue]) {
        
        NSString *mess = [NSString stringWithFormat:@"交易金额错误，应大于%.2f份",[_fundFenEMin floatValue]];
        
        [self showToastWithMessage:mess showTime:1];
        return ;
    }
    
    if ([_fundRedeemTF.text floatValue]>[_fundFenEMax floatValue]) {
        
        NSString *mess = [NSString stringWithFormat:@"交易金额错误，应小于%.2f份",[_fundFenEMax floatValue]];
        
        [self showToastWithMessage:mess showTime:1];
        return;
    }
    [self redeemNext];
    } else{
        NSString * mess = [NSString stringWithFormat:@"您输入的赎回份额有误"];
        [self showToastWithMessage:mess showTime:1];
    }
    

}



- (void)redeemNext {
    FundRedemThrViewController *thr = [[FundRedemThrViewController alloc] init];
    
    thr.fundDic = [self.fundDic copy] ;
    thr.redeemFenE = _fundRedeemTF.text ;//赎回份额
    thr.identityCard = self.identityCard ;
    thr.passWord     = self.passWord ;
    thr.daXieFenE    = _fundFenEBigLB.text ;//大写
    thr.redeenMark   = _fundRedeemMarkerTF.text   ;
    thr.transactionaccountid=self.transactionaccountid;
    [APP_DELEGATE.rootNav pushViewController:thr animated:YES];

}
#pragma mark--------加载数据

-(void)reloadDataArr:(NSArray *)titleArr {

    for (int i=0; i<7; i++) {
        
        if (i<4) {
            UILabel *label = [_titleArr objectAtIndex:i];
            label.text = [titleArr objectAtIndex:i];
            
        }
        else if (i==4){
            UITextField *tf = [_titleArr objectAtIndex:i];
            tf.text =[titleArr objectAtIndex:i];
            

        }
        else if (i==5){
            
            //以后有数据了别忘了转换
            NSString *str = [titleArr objectAtIndex:4];;
            NSString *textStr ;
            NSArray *textArr = [str componentsSeparatedByString:@"."];
            if (textArr.count==1) {
                textStr = [JudgeFormate convert:[textArr objectAtIndex:0]];
                
            }
            if (textArr.count==2) {
                
                NSString *str1 = [JudgeFormate convert:[textArr objectAtIndex:0]];
                NSString *str2 = [JudgeFormate convert1:[textArr objectAtIndex:1]];
                
                textStr = [NSString stringWithFormat:@"%@点%@",str1,str2];
            }
            
            textStr = [NSString stringWithFormat:@"%@(份)",textStr];
            UILabel *label = [_titleArr objectAtIndex:i+1];
            label.text = textStr;
                    }
        else if (i==6){
            UITextField *btn = [_titleArr objectAtIndex:i+1];
            btn.text = @"取消" ;
        }
    }


}


#pragma mark------pickview

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1 ;

}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return [_pickArray count];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [_pickArray objectAtIndex:row];

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    NSLog(@"-------%@",[_pickArray objectAtIndex:row]);
    _shuHuiTag = [_pickArray objectAtIndex:row] ;
    _fundRedeemMarkerTF.text = [_pickArray objectAtIndex:row] ;
}
#pragma mark-------uitextfielddelegate

- (IBAction)returnButtonClick:(id)sender{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    if ([newtxt floatValue]<[_fundFenEMin floatValue]&&[_fundRedeemTF.text floatValue]==[_fundFenEMax floatValue]) {
                _fundPromptMessLB.text = [NSString stringWithFormat:@"交易金额少于最少份额，请全部赎回"];
        return YES ;
    }
    if ([_fundFenEMax floatValue]<[_fundFenEMin floatValue]&&[newtxt floatValue]<[_fundFenEMax floatValue]) {
        
        _fundPromptMessLB.text = [NSString stringWithFormat:@"交易金额错误，请全部赎回"];
     return YES;
    }

    if ([newtxt floatValue]<[_fundFenEMin floatValue]&&[_fundFenEMin floatValue]<[_fundFenEMax floatValue]) {
        
        _fundPromptMessLB.text = [NSString stringWithFormat:@"交易金额错误，应大于%.2f份",[_fundFenEMin floatValue]];
        return YES;
    }
    
    if ([newtxt floatValue]>[_fundFenEMax floatValue]) {
        _fundPromptMessLB.text = [NSString stringWithFormat:@"交易金额错误，应小于%.2f份",[_fundFenEMax floatValue]];
        return NO;
    }
    
    NSString *fenERange = [NSString stringWithFormat:@"本金赎回范围（%.2f份~%.2f份）",[_fundFenEMin floatValue],[_fundFenEMax floatValue]];
    
    _fundPromptMessLB.text = fenERange ;
    
    
    //以后有数据了别忘了转换
    NSString *str = newtxt;;
    NSString *textStr ;
    NSArray *textArr = [str componentsSeparatedByString:@"."];
    if (textArr.count==1) {
        textStr = [JudgeFormate convert:[textArr objectAtIndex:0]];
        
    }
    if (textArr.count==2) {
        
        NSString *str1 = [JudgeFormate convert:[textArr objectAtIndex:0]];
        NSString *str2 = [JudgeFormate convert1:[textArr objectAtIndex:1]];
        
        textStr = [NSString stringWithFormat:@"%@点%@",str1,str2];
    }
    
    textStr = [NSString stringWithFormat:@"%@(份)",textStr];
    
    _fundFenEBigLB.text = textStr;
    
    return YES ;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{


    if (textField.tag==2) {
        
        if (!_pickBackView) {
            _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162+30)];
            _pickBackView.alpha = 0 ;
            _pickBackView.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:_pickBackView];
            _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 162)];
            [_pickBackView addSubview:_pickView];
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            backView.backgroundColor = [UIColor whiteColor];
            [_pickBackView addSubview:backView];
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(SCREEN_WIDTH-50, 0, 40, 30);
            [but setTitle:@"完成" forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
            [_pickBackView addSubview:but];
            _pickArray = [[NSArray alloc] initWithObjects:@"取消",@"顺延", nil];
            
            _pickView.delegate = self ;
            _pickView.dataSource = self ;
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView animateWithDuration:.5 animations:^{
            
            _pickBackView.frame = CGRectMake(0, SCREEN_HEIGHT-192, SCREEN_WIDTH, 162+30);
            _pickBackView.alpha = 1 ;
        } completion:^(BOOL finished) {
            
        }];
        [UIView commitAnimations];
        
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [_fundRedeemTF resignFirstResponder];
    return YES;
}

-(void)clickOkBtn{

    [_fundRedeemMarkerTF resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:.5 animations:^{
        
        _pickBackView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162+30);
        _pickBackView.alpha = 0 ;
    } completion:^(BOOL finished) {
        
    }];
    [UIView commitAnimations];

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

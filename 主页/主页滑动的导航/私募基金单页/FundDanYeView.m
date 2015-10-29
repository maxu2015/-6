//
//  FundDanYeView.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "FundDanYeView.h"
#import "NSDate+HCString.h"
@implementation FundDanYeView


-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [COLOR_RGB(51, 187, 238) CGColor];
        self.layer.borderWidth = 1 ;
        
        _fundName = [self creatLB];
        _fundName.font = [UIFont systemFontOfSize:13];
        _fundName.textColor = COLOR_RGB(47, 47, 47);
        _fundName.frame = CGRectMake(13, 5, 137, 15);
        [self addSubview:_fundName];
        
        _fundCode = [self creatLB];
        _fundCode.frame = CGRectMake(13, 22, 137, 15);
        [self addSubview:_fundCode];
        
        _jingzhiLB = [self creatLB];
        _jingzhiLB.frame =CGRectMake(150, 8, 48, 15);
        [self addSubview:_jingzhiLB];
        
        _jingzhiValueAndTimeLB = [self creatLB];
        _jingzhiValueAndTimeLB.frame = CGRectMake(150+48,8 , 310-198, 15);
        _jingzhiValueAndTimeLB.font = [UIFont systemFontOfSize:10];
        [self addSubview:_jingzhiValueAndTimeLB];
        
        _typeLB = [self creatLB];
        _timeLB = [self creatLB];
        _celueLB = [self creatLB];
        _jingliNameLB = [self creatLB];
        _yearLB = [self creatLB];
       // _yearLB.textColor = [UIColor redColor];
        _comLB = [self creatLB];
        _startBuyLB = [self creatLB];
        _OpenDateLB = [self creatLB];
        _TrusteeLB = [self creatLB];
        _BondBrokerLB = [self creatLB];
        _AdminFeeLB = [self creatLB];
        _TrusteeFeeLB = [self creatLB];
        _BuyFeeLB   = [self creatLB];
        _yejiBaoChouLB = [self creatLB];
        _CloseDateLB = [self creatLB];
        _WarningLineLB = [self creatLB];
        _StopLossLineLB = [self creatLB];
        _RebackFeeLB = [self creatLB];
        _RebackFeeLB.numberOfLines = 0 ;
        
        
        
        NSArray *uiarray = [[NSArray alloc] initWithObjects:_typeLB,_timeLB,_celueLB,_jingliNameLB,_yearLB,_comLB,_startBuyLB,_OpenDateLB,_TrusteeLB,_BondBrokerLB,_AdminFeeLB,_TrusteeFeeLB,_BuyFeeLB,_yejiBaoChouLB,_CloseDateLB,_WarningLineLB,_StopLossLineLB,_RebackFeeLB, nil];
        //13,42
        for (int i=0; i<18; i++) {
            float posx = 13+(i%2)*137;
            float posy = 42+(i/2)*18;
            UILabel *mylabel = [uiarray objectAtIndex:i];
            if (i%2==0) {
                mylabel.frame = CGRectMake(posx, posy, 137, 15);
            }
            else{
            mylabel.frame = CGRectMake(posx, posy, 310-posx, 15);
            }
            
            if (i==17) {
                _RebackFeeLB.frame = CGRectMake(posx, posy, 310-posx, 30);
            }
            [self addSubview:mylabel];
        }
    }
    return self;
}




-(UILabel *)creatLB{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = COLOR_RGB(73, 73, 73);
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES ;
    //[self addSubview:label];
    return label;
}

-(void)reloadContentData:(NSDictionary *)dic{

    NSLog(@"======%@",dic);
    _fundName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FundName"]];
    _fundCode.text = [NSString stringWithFormat:@"(%@)",[dic objectForKey:@"FundCode"]];
    _jingzhiLB.text = [NSString stringWithFormat:@"%@",@"最新净值:"];
    _jingzhiValueAndTimeLB.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"UnitEquity"],[dic objectForKey:@"DealDate"]];
    
    _typeLB.text = [NSString stringWithFormat:@"类型：%@",[dic objectForKey:@"Types"]];
    //
    
    NSString *Dates = [dic objectForKey:@"Dates"];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:Dates];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    Dates = [NSDate returnDate:fromDate];
    
    _timeLB.text = [NSString stringWithFormat:@"成立时间：%@",Dates];
    
    _celueLB.text = [NSString stringWithFormat:@"投资策略：%@",[dic objectForKey:@"Pan"]];
    
    _jingliNameLB.text = [NSString stringWithFormat:@"基金经理：%@",[dic objectForKey:@"Name"]];
    //
    NSString *yearStr=  [NSString stringWithFormat:@"近一年以来：%@",[dic objectForKey:@"OneYearYield"]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:yearStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, yearStr.length-6)];
    //
    _yearLB.attributedText = str ;  //[NSString stringWithFormat:@"近一年以来：%@",[dic objectForKey:@"OneYearYield"]];
    _comLB.text = [NSString stringWithFormat:@"基金公司：%@",[dic objectForKey:@"CompName"]];
    _startBuyLB.text = [NSString stringWithFormat:@"认购起点：%@万",[dic objectForKey:@"Money"]];
    _OpenDateLB.text = [NSString stringWithFormat:@"开放日：%@",[dic objectForKey:@"OpenDate"]];
    _TrusteeLB.text = [NSString stringWithFormat:@"基金托管人：%@",[dic objectForKey:@"Trustee"]];
    _BondBrokerLB.text = [NSString stringWithFormat:@"证券经纪人：%@",[dic objectForKey:@"BondBroker"]];
    _AdminFeeLB.text = [NSString stringWithFormat:@"管理费：%@",[dic objectForKey:@"AdminFee"]];
    _TrusteeFeeLB.text = [NSString stringWithFormat:@"托管费：%@",[dic objectForKey:@"TrusteeFee"]];
    _BuyFeeLB.text = [NSString stringWithFormat:@"认购费：%@",[dic objectForKey:@"BuyFee"]];
    //业绩报酬暂时没有
    _yejiBaoChouLB.text = [NSString stringWithFormat:@"业绩报酬：%@",[dic objectForKey:@"RewordFee"]];
    _CloseDateLB.text = [NSString stringWithFormat:@"封闭期：%@",[dic objectForKey:@"CloseDate"]];
    _WarningLineLB.text = [NSString stringWithFormat:@"预警线：%@",[dic objectForKey:@"WarningLine"]];
    _StopLossLineLB.text = [NSString stringWithFormat:@"止损线：%@",[dic objectForKey:@"StopLossLine"]];
    _RebackFeeLB.text = [NSString stringWithFormat:@"赎回费率：%@",[dic objectForKey:@"RebackFee"]];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

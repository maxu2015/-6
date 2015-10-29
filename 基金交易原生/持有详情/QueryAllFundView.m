//
//  QueryAllFundView.m
//  CaiLiFang
//
//  Created by  展恒 on 14-12-18.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#define TEXT_GRAY_QUERY  [UIColor colorWithRed:168.0/255 green:168.0/255 blue:168.0/255 alpha:1]  //灰色字体

#define VIEW_BACK_QUERY  [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]   //灰色背景
#import "QueryAllFundView.h"

@implementation QueryAllFundView

-(id)initWithFrame:(CGRect)frame{

    self =    [super initWithFrame:frame];
    if (self) {
        

        
        
        
        _FundTotalNumber = [[UILabel alloc] init];
        _fundTotalMoney = [[UILabel alloc] init];
        _fundTotalProfit = [[UILabel alloc] init];
        _fundTotalProfitRate = [[UILabel alloc] init];

        _labelArray = @[_fundTotalProfit,_fundTotalMoney,_fundTotalProfitRate,_FundTotalNumber];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
        backView.backgroundColor = [[UIColor alloc] initWithRed:252.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        [self addSubview:backView];
        
        UIImageView *moneyImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        moneyImg.image = [UIImage imageNamed:@"浮动收益.png"];
        [self addSubview:moneyImg];
        
        
       
        
        
//        UIButton *moneyImg1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        moneyImg1.frame = CGRectMake(SCREEN_WIDTH-30, 10, 20, 20);
//        [moneyImg1 setBackgroundImage:[UIImage imageNamed:@"温馨提示.png"] forState:UIControlStateNormal];
//        [moneyImg1 addTarget:self action:@selector(SingleTap:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:moneyImg1];
        
        UILabel *fuDongLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 20)];
        fuDongLB.text = @"总浮动盈亏（元）";
        fuDongLB.font = [UIFont boldSystemFontOfSize:16];
        //fuDongLB.textColor = [UIColor whiteColor];
        [self addSubview:fuDongLB];
        
        _fundTotalProfit.frame = CGRectMake(15, 45, 100, 42);
        _fundTotalProfit.textColor = [UIColor redColor];
        _fundTotalProfit.text = @"0.00";
        _fundTotalProfit.font = [UIFont boldSystemFontOfSize:35];
        [self addSubview:_fundTotalProfit];
        //总市值
        
        UILabel *shiZhiLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 150, 20)];
        shiZhiLB.text = @"总市值（元）";
        shiZhiLB.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:shiZhiLB];
        
       _fundTotalMoney.frame = CGRectMake(15, 160, 300, 25);
        _fundTotalMoney.font = [UIFont boldSystemFontOfSize:25];
        _fundTotalMoney.adjustsFontSizeToFitWidth=YES;
        _fundTotalMoney.textColor = [UIColor redColor];
        _fundTotalMoney.text = @"0.00" ;
        [self addSubview:_fundTotalMoney];
        
//        总收益
//        UILabel *shouYiLB = [[UILabel alloc] initWithFrame:CGRectMake(30, 190, 150, 20)];
//        shouYiLB.text = @"总收益率";
//        shouYiLB.font = [UIFont boldSystemFontOfSize:15];
//        [self addSubview:shouYiLB];
        
        _fundTotalProfitRate.frame = CGRectMake(125, 45+17, 200, 25);
        _fundTotalProfitRate.font = [UIFont boldSystemFontOfSize:20];
        _fundTotalProfitRate.textColor = [UIColor redColor];
        _fundTotalProfitRate.text = @"0.00%" ;
        [self addSubview:_fundTotalProfitRate];
        
        _FundTotalNumber.frame  = CGRectMake(15, 190, 150, 25);
        _FundTotalNumber.font = [UIFont boldSystemFontOfSize:15];
        //_FundTotalNumber.text = @"持有详情（0支）";
        [self addSubview:_FundTotalNumber];
        
    
        
    }
    
    return self ;
}

-(void)SingleTap:(UIButton*)recognizer
{
    if (_delegate&&([_delegate respondsToSelector:@selector(clickWenHao)])) {
        [_delegate clickWenHao] ; 
    }
    
    
    //处理单击操作
}

-(void)loadData:(NSArray *)queryDataArray{

    //NSMutableArray *textArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<queryDataArray.count; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%@",[queryDataArray objectAtIndex:i]];
        
//        if (i==0) {
//            str = [NSString stringWithFormat:@"%@ (%@)",[queryDataArray objectAtIndex:i],[queryDataArray objectAtIndex:i+2]];
//        }
//        else{
//        str = [NSString stringWithFormat:@"%@",[queryDataArray objectAtIndex:i]];
//        }
        
        
        
        
        UILabel *label =(UILabel *) [_labelArray objectAtIndex:i];
        label.text = str ;
        
        if (i==0) {
            
            
            if ([str floatValue]<0) {
                
                _fundTotalProfit.textColor = [UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
                _fundTotalProfitRate.textColor = [UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
                
                
            }
            _fundTotalProfit.frame  = CGRectMake(_fundTotalProfit.frame.origin.x, _fundTotalProfit.frame.origin.y, _fundTotalProfit.intrinsicContentSize.width, 42);
            _fundTotalProfitRate.frame = CGRectMake(5+_fundTotalProfit.frame.origin.x+_fundTotalProfit.frame.size.width, _fundTotalProfit.frame.origin.y+17, 200, 25);
        }
        
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
}
*/

@end

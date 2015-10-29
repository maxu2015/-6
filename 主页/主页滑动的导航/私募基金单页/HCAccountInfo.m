//
//  HCAccountInfo.m
//  CaiLiFang
//
//  Created by  展恒 on 15-5-11.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "HCAccountInfo.h"

@implementation HCAccountInfo


-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
       self.backgroundColor = COLOR_RGB(154, 154, 154);
        
        _accountNameLB = [self creatLB];
        _accountBankLB = [self creatLB];
        _accountNumLB = [self creatLB];
        _paymentLB = [self creatLB];
        NSArray *contArray = [[NSArray alloc] initWithObjects:_accountNameLB,_accountBankLB,_accountNumLB,_paymentLB, nil];
        
        NSArray *titleArray = [[NSArray alloc] initWithObjects:@"账户名",@"开户银行",@"账号",@"大额支付系统行号", nil];
        for (int i = 0; i<4; i++) {
            
            
            //float uiwith = 272.0/5.0 ;
            float uiHeight = 75.0/4.0 ;
            
            UILabel *titleLabel = [self creatLB];
            titleLabel.frame = CGRectMake(1, 1+(uiHeight+1)*i, 84, uiHeight);
            titleLabel.text = [titleArray objectAtIndex:i];
            [self addSubview:titleLabel];
            
            UILabel *contentLB = [contArray objectAtIndex:i];
            contentLB.frame= CGRectMake(86, 1+(uiHeight+1)*i, 275-87, uiHeight);
            [self addSubview:contentLB];
            
        }
        
    }

    return self ; 
}


-(UILabel *)creatLB{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor =COLOR_RGB(73, 73, 73);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES ;
    return label;
}

-(void)reloadContentData:(NSDictionary *)dic{

_accountNameLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RemitName"]];
    _accountBankLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RemitBank"]];
    _accountNumLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RemitAccount"]];
    _paymentLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"LargePayAcount"]];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

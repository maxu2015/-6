//
//  HCFundInfoView.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "HCFundInfoView.h"

@implementation HCFundInfoView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_RGB(154, 154, 154);
        _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
        _zhangArray = [[NSMutableArray alloc] initWithCapacity:0];
        _hushengArray = [[NSMutableArray alloc] initWithCapacity:0];
        _xiangDuiArray = [[NSMutableArray alloc] initWithCapacity:0];
        float uiwith = 269.0/5.0 ;
        float uiHeight = 75.0/4.0 ;
        for (int i =0; i<4; i++) {
            for (int j=0; j<5; j++) {
                
                float posX = 1+(uiwith +1)*j;
                float posY = 1+(uiHeight +1)*i ;
                UILabel *mylabel = [self creatLB];
                mylabel.frame = CGRectMake(posX, posY, uiwith, uiHeight);
                [self addSubview:mylabel];
                if (i==0) {
                    [_titleArray addObject:mylabel];
                }
                if (i==1) {
                    [_zhangArray addObject:mylabel];
                }
                if (i==2) {
                    [_hushengArray addObject:mylabel];
                }
                if (i==3) {
                    [_xiangDuiArray addObject:mylabel];
                }
            }
        }
    }
    return self;
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


-(void)reloadTitle:(NSArray *)arra{
    
    if (arra.count<1) {
        return;
    }
    
    NSDictionary *dataDic = [arra objectAtIndex:0];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"近一个月",@"近三个月",@"近六个月",@"近一年", nil];
    UILabel *zhanglB = [_zhangArray objectAtIndex:0];
    UILabel *huLB = [_hushengArray objectAtIndex:0];
    UILabel *xdLB = [_xiangDuiArray objectAtIndex:0];
    zhanglB.text = @"涨跌幅";
    huLB.text    = @"沪深300";
    xdLB.text    = @"相对收益";
    for (int i=0; i<5; i++) {//title
        UILabel *mylabel = [_titleArray objectAtIndex:i];
        if (i>0) {
            mylabel.text = [array objectAtIndex:i-1];
        }
    }

    //涨跌幅
   
    
    for (int i=0; i<5; i++) {//title
        UILabel *mylabel = [_zhangArray objectAtIndex:i];
        UILabel *mylabel2 = [_hushengArray objectAtIndex:i];
        UILabel *mylabel3 = [_xiangDuiArray objectAtIndex:i];
        
        
        if (i==1) {
            mylabel.text = [dataDic objectForKey:@"OneMonthYield"];
            mylabel2.text = [dataDic objectForKey:@"HSOneMonthYield"];
            mylabel3.text = [dataDic objectForKey:@"XyOneMonthYield"];
        }
        if (i==2) {
            mylabel.text = [dataDic objectForKey:@"ThreeMonthYield"];
            mylabel2.text = [dataDic objectForKey:@"HSThreeMonthYield"];
            mylabel3.text = [dataDic objectForKey:@"XyThreeMonthYield"];
        }
        if (i==3) {
            mylabel.text = [dataDic objectForKey:@"SixMonthYield"];
            mylabel2.text = [dataDic objectForKey:@"HSSixMonthYield"];
            mylabel3.text = [dataDic objectForKey:@"XySixMonthYield"];
        }
        if (i==4) {
            mylabel.text = [dataDic objectForKey:@"OneYearYield"];
            mylabel2.text = [dataDic objectForKey:@"HSOneYearYield"];
            mylabel3.text = [dataDic objectForKey:@"XyOneYearYield"];
        }
        
        if (i>0) {
            mylabel.textColor = [UIColor redColor];
            mylabel2.textColor = [UIColor redColor];
            mylabel3.textColor = [UIColor redColor];
            
            if ([mylabel.text floatValue]<0) {
                mylabel.textColor = [UIColor greenColor];
            }
            if ([mylabel2.text floatValue]<0) {
                mylabel2.textColor = [UIColor greenColor];
            }
            if ([mylabel3.text floatValue]<0) {
                mylabel3.textColor = [UIColor greenColor];
            }
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

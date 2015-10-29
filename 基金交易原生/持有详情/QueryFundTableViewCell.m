//
//  QueryFundTableViewCell.m
//  CaiLiFang
//
//  Created by  展恒 on 14-12-22.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "QueryFundTableViewCell.h"

@implementation QueryFundTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.daiMa = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 44, 20)];
        self.daiMa.font = [UIFont systemFontOfSize:10];
        self.daiMa.textAlignment = NSTextAlignmentCenter;
        
        self.mingCheng = [[UILabel alloc] initWithFrame:CGRectMake(44, 5, 111, 20)];
        self.mingCheng.font = [UIFont systemFontOfSize:10];
        self.mingCheng.textAlignment = NSTextAlignmentCenter;
        
        self.ShiZhi = [[UILabel alloc] initWithFrame:CGRectMake(155, 5, 55, 20)];
        self.ShiZhi.font = [UIFont systemFontOfSize:10];
        self.ShiZhi.textAlignment = NSTextAlignmentCenter;
        
        self.yingKui = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 55, 20)];
        self.yingKui.font = [UIFont systemFontOfSize:10];
        self.yingKui.textAlignment = NSTextAlignmentCenter;
        
        self.shouYiLv = [[UILabel alloc] initWithFrame:CGRectMake(265, 5, 55, 20)];
        self.shouYiLv.font = [UIFont systemFontOfSize:10];
        self.shouYiLv.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_daiMa];
        [self addSubview:_mingCheng];
        [self addSubview:_ShiZhi];
        [self addSubview:_yingKui];
        [self addSubview:_shouYiLv];
        
        
    }
    return self;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)loadData:(NSDictionary *)dic{

    
    
    //NSLog(@"======%@=======%@",dic,[dic class]);
    if (dic) {
        
        NSString *costmoney = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"buymount"] floatValue]];//成本
        
        NSString *shizhimoney = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"mktvalue"] floatValue]];
        
        NSString *yingKui = [NSString stringWithFormat:@"%.2f", [[dic objectForKey:@"floatprofit"] floatValue]];//盈亏
        
        float num = [[dic objectForKey:@"addincomerate"] floatValue]*100;
        NSString *shouYiLv = [NSString stringWithFormat:@"%.2f",num];//收益率
        NSLog(@"---->>%@",shouYiLv);
        self.daiMa.text = [dic objectForKey:@"fundcode"];
        self.mingCheng.text = [dic objectForKey:@"fundname"];
        
        if ([shizhimoney floatValue]==0) {
           
            self.yingKui.text = @"0.00" ;
            self.shouYiLv.text = [NSString stringWithFormat:@"%@\%%",@"0.00"];
        }
        else{
            self.yingKui.text = yingKui ;
            self.shouYiLv.text = [NSString stringWithFormat:@"%@\%%",shouYiLv];
        
        }
        self.ShiZhi.text = shizhimoney;
        
        
        if ([_yingKui.text floatValue]>0) {
            _yingKui.textColor = [UIColor redColor];
            _shouYiLv.textColor = [UIColor redColor];
        }
        else if([_yingKui.text floatValue]<0){
            
            _yingKui.textColor = [UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
            _shouYiLv.textColor = [UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
        }
        else {
            _yingKui.textColor = [UIColor blackColor];
            _shouYiLv.textColor = [UIColor blackColor];
        }
        
       // self.yingKui.text =
    }



}

//-(void)setYingKui:(UILabel *)yingKui{
//
//    
//    NSLog(@"-------%@",yingKui.text);
//    
//    
//
//
//}
@end

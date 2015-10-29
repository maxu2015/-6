//
//  HCFundInfoTableViewCell.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "HCFundInfoTableViewCell.h"
#import "NSDate+HCString.h"
@implementation HCFundInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = COLOR_RGB(154, 154, 154);
        _timeLB = [self creatLB];
        _signeLB = [self creatLB];
        _totalLB = [self creatLB];
        _rateLB = [self creatLB] ;
        _rateLB.textColor = [UIColor redColor];
        NSArray *UIarray = [[NSArray alloc] initWithObjects:_timeLB,_signeLB,_totalLB,_rateLB, nil];
        float  uiwith = 275.0/4.0 ; //宽度
        
        for (int i =0; i<4; i++) {
            float posX = 1+ (uiwith+1)*i;
            float posY =  0 ;
            UILabel *myLbael = [UIarray objectAtIndex:i];
            myLbael.frame = CGRectMake(posX, posY, uiwith, 19);
            [self addSubview:myLbael];
        }
    }
    return self;
}
-(void)reloadDic:(NSDictionary *)dic{
    
   
    NSString *DealDate = [dic objectForKey:@"DealDate"];
        NSDateFormatter *format=[[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *fromdate=[format dateFromString:DealDate];
        NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
        NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
        NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
        DealDate = [NSDate returnDate:fromDate];
    
    //
    _timeLB.text = DealDate ; //[dic objectForKey:@"DealDate"];
    _signeLB.text = [dic objectForKey:@"UnitEquity"];
    _totalLB.text = [dic objectForKey:@"TotalEquity"];
    _rateLB.text = [dic objectForKey:@"DayBenefit"];

    if ([_rateLB.text floatValue]<0) {
        _rateLB.textColor = [UIColor greenColor];
    }
    else{
     _rateLB.textColor = [UIColor redColor];
    }
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

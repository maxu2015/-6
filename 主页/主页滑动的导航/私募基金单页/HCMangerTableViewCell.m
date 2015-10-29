//
//  HCMangerTableViewCell.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "HCMangerTableViewCell.h"

@implementation HCMangerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //self.frame = CGRectMake(0, 0, 65*7, 20);
        self.backgroundColor = COLOR_RGB(154, 154, 154);
        _fundNameLB = [self creatLB];
        _jingliNameLB = [self creatLB];
        _jingzhiTimeLB = [self creatLB];
        _todayLB = [self creatLB];
        _todayLB.textColor = [UIColor redColor];
        _oneYearLB = [self creatLB];
        _oneYearLB.textColor = [UIColor redColor];
        _chengliTimeLB = [self creatLB];
        _caozuoLB = [self creatLB];
        _caozuoLB.text = @"--";
        
        NSArray *UIarray = [[NSArray alloc] initWithObjects:_fundNameLB,_jingliNameLB,_jingzhiTimeLB,_todayLB,_oneYearLB,_chengliTimeLB,_caozuoLB, nil];
        float  uiwith = 482.0/7.0 ; //宽度
        
        for (int i =0; i<7; i++) {
            float posX = 1+ (uiwith+1)*i;
            float posY =  0 ;
            UILabel *myLbael = [UIarray objectAtIndex:i];
            myLbael.frame = CGRectMake(posX, posY, uiwith, 27);
            [self addSubview:myLbael];
        }
        
        _caozuoBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        _caozuoBTN.frame = CGRectMake(70*6+14,4, 42, 20);
        [_caozuoBTN setTitle:@"预约" forState:UIControlStateNormal];
        [_caozuoBTN setBackgroundImage:[UIImage imageNamed:@"增加编辑"] forState:UIControlStateNormal];
        [_caozuoBTN addTarget:self action:@selector(clickEditBtn) forControlEvents:UIControlEventTouchUpInside];
        //[self addSubview:_caozuoBTN];
    }
    return self;
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
-(void)clickEditBtn{

    if (_delegate&&[_delegate respondsToSelector:@selector(clickEdit:)]) {
        [_delegate clickEdit:self];
    }
}
-(void)reloadData:(NSDictionary *)dic {

   // NSLog(@"=======%@",dic);
    _cellDIC = dic;
    _fundNameLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FundName"]];
    _jingliNameLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Manager"]];
    _jingzhiTimeLB.text = [dic objectForKey:@"DealDate"];
    _todayLB.text = [dic objectForKey:@"ThisYearYield"];
    _oneYearLB.text = [dic objectForKey:@"OneYearYield"];
    _chengliTimeLB.text = [dic objectForKey:@"Est_date"];
    
    if ([_todayLB.text floatValue] < 0) {
        _todayLB.textColor = [UIColor greenColor];
    }
    if ([_oneYearLB.text floatValue] < 0) {
        _oneYearLB.textColor = [UIColor greenColor];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

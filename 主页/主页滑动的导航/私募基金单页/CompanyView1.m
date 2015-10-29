//
//  CompanyView1.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "CompanyView1.h"

@implementation CompanyView1


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [COLOR_RGB(51, 187, 238) CGColor];
        self.layer.borderWidth = 1 ;
        
        _comNameLB = [self creatLB];
        _comNameLB.frame = CGRectMake(13,7, 310-13, 15);
        _comNameLB.font = [UIFont systemFontOfSize:13];
        _comNameLB.textColor = COLOR_RGB(51, 187, 238);
        [self addSubview:_comNameLB];
        //
        _placeLB = [self creatLB];
        _mainPersonLB = [self creatLB];
        _moneyLB = [self creatLB];
        _timeLB = [self creatLB];
        _personNumLB = [self creatLB];
        _fundCodeLB = [self creatLB];
        
        NSArray *uiarray = [[NSArray alloc] initWithObjects:_placeLB,_mainPersonLB,_moneyLB,_timeLB,_personNumLB,_fundCodeLB, nil];
        for (int i = 0; i<6; i++) {
            float posY = 32+17*(i/2);
            float posX =13+108*(i%2);
            UILabel *mylabel = [uiarray objectAtIndex:i];
            [self addSubview:mylabel];
            if (i%2==0) {
                mylabel.frame = CGRectMake(posX, posY, 108, 17);
            }
            else{
                mylabel.frame = CGRectMake(posX, posY, 310-108-13, 17);
            }
        }
        
    }
    return self;
}
-(void)reloadContentData:(NSArray *)dic{
    
    NSDictionary *mydic = [dic objectAtIndex:0];
    if ([mydic isKindOfClass:[NSDictionary class]]) {
        
        
        _comNameLB.text = [mydic objectForKey:@"CompName_Full"];
        _placeLB.text = [NSString stringWithFormat:@"所在地：%@",[mydic objectForKey:@"IssuePlace"]];
        _mainPersonLB.text = [NSString stringWithFormat:@"核心人物：%@",[mydic objectForKey:@"KeyPeople"]];
        _moneyLB.text = [NSString stringWithFormat:@"注册资本：%@万",[mydic objectForKey:@"Reg_Capital"]];
        _timeLB.text = [NSString stringWithFormat:@"成立日期：%@",[mydic objectForKey:@"ThisYearYield"]];
        _personNumLB.text = [NSString stringWithFormat:@"人员规模：%@",[mydic objectForKey:@"SumPerson"]];
        _fundCodeLB.text = [NSString stringWithFormat:@"私募备案号：%@",[mydic objectForKey:@"CompRecord"]];
    }
    


}
-(UILabel *)creatLB{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = COLOR_RGB(73, 73, 73);
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES ;
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  FunBuyOneTableViewCell.m
//  jiami2
//
//  Created by  展恒 on 15-1-7.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FunBuyOneTableViewCell.h"

@implementation FunBuyOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _redeemBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        _redeemBTN.frame = CGRectMake(SCREEN_WIDTH - 45 - 5, 7.5, 40, 25);
        _redeemBTN.layer.cornerRadius = 4 ;
        _redeemBTN.clipsToBounds = YES ;
        _redeemBTN.titleLabel.font = [UIFont systemFontOfSize:12];
        [_redeemBTN setTitle:@"申购" forState:UIControlStateNormal];
        //_redeemBTN.backgroundColor = [UIColor redColor];
        [_redeemBTN addTarget:self action:@selector(clickRedeem) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_redeemBTN] ;
        
        self.fundCodeLB = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 44 + 5, 40)];
        self.fundCodeLB.textColor = [UIColor grayColor];
        self.fundCodeLB.numberOfLines = 0 ;
        self.fundCodeLB.font      = [UIFont systemFontOfSize:11];
        self.fundCodeLB.textAlignment = NSTextAlignmentLeft;
        
        self.fundStateLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45 - 5 - 55 - 10 - 45, 0, 55, 40)];
        // self.fundStateLB.textColor = [UIColor grayColor];
        self.fundStateLB.font      = [UIFont systemFontOfSize:11];
        self.fundStateLB.numberOfLines = 0 ;
        self.fundStateLB.textAlignment = NSTextAlignmentCenter;
        
        _shiZhiLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45 - 5 - 55 - 10, 0, 55, 40)];
        _shiZhiLB.numberOfLines = 2 ;
        _shiZhiLB.textAlignment = NSTextAlignmentCenter ;
        _shiZhiLB.font = [UIFont systemFontOfSize:11];
        
    
        CGFloat widt = self.fundStateLB.frame.origin.x - self.fundCodeLB.frame.origin.x - self.fundCodeLB.frame.size.width;
        
        
        self.fundNameLB = [[UILabel alloc] initWithFrame:CGRectMake(44 + 10 + 5, 0, widt, 40)];
        // self.fundNameLB.textColor = [UIColor grayColor];
        self.fundNameLB.font      = [UIFont systemFontOfSize:11];
        self.fundNameLB.numberOfLines = 0 ;
        self.fundNameLB.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_shiZhiLB];
        [self addSubview:self.fundCodeLB];
        [self addSubview:self.fundNameLB];
        [self addSubview:self.fundStateLB];
        
    }
    
    return self ;
    
    
}

-(void)clickRedeem{
    
    if (!_redeemBTN.selected) {
        return;
    }
    if (_delegate&&[_delegate respondsToSelector:@selector(clickBuyButton:)]) {
        [_delegate clickBuyButton:self];
    }
}
-(void)loadData:(NSDictionary *)dic{
    
    if (dic) {
        NSString *status = [dic objectForKey:@"status"];
        if (([status floatValue]==0)||([status floatValue]==1)||([status floatValue]==6)||([status floatValue]==7)||([status floatValue]==8)) {
            
            [_redeemBTN setBackgroundImage:[UIImage imageNamed:@"redeemOK.png"] forState:UIControlStateNormal];
            if ([status floatValue]==1) {
                [_redeemBTN setTitle:@"认购" forState:UIControlStateNormal];
            }
            else{
            [_redeemBTN setTitle:@"申购" forState:UIControlStateNormal];
            }
            _redeemBTN.selected = YES;
        }
        else{
            
            [_redeemBTN setBackgroundImage:[UIImage imageNamed:@"redeemCancel.png"] forState:UIControlStateNormal];
            [_redeemBTN setTitle:@"申购" forState:UIControlStateNormal];
            _redeemBTN.selected = NO;
        }
        
        NSString *fundTYPE = [dic objectForKey:@"fundtype"];
        self.fundCodeLB.text = [dic objectForKey:@"fundcode"];
        self.fundNameLB.text = [dic objectForKey:@"fundname"];
        self.fundStateLB.text = [self refrisklevel:fundTYPE] ;
        self.shiZhiLB.text = [dic objectForKey:@"nav"];
    }
    
    
}

-(NSString *)refrisklevel:(NSString *)risklevel{
    
    NSString *userlevel = @"";
    if ([risklevel isEqualToString:@"0"]) {
        userlevel = @"股票型";
    }
    if ([risklevel isEqualToString:@"1"]) {
        userlevel = @"债券型";
    }
    if ([risklevel isEqualToString:@"2"]) {
        userlevel = @"货币型";
    }
    if ([risklevel isEqualToString:@"3"]) {
        userlevel = @"混合型";
    }
    if ([risklevel isEqualToString:@"4"]) {
        userlevel = @"专户基金";
    }
    if ([risklevel isEqualToString:@"5"]) {
        userlevel = @"指数型";
    }
    if ([risklevel isEqualToString:@"6"]) {
        userlevel = @"QDII型";
    }
    
    return userlevel ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

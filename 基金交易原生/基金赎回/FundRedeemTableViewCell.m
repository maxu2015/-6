//
//  FundRedeemTableViewCell.m
//  jiami2
//
//  Created by  展恒 on 15-1-19.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundRedeemTableViewCell.h"

@implementation FundRedeemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _redeemBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        _redeemBTN.frame = CGRectMake(160 + 2*(SCREEN_WIDTH - 160) / 3, 7.5, /*(SCREEN_WIDTH - 160) / 3*/40, 25);
        _redeemBTN.layer.cornerRadius = 4 ;
        _redeemBTN.clipsToBounds = YES;
        [_redeemBTN setTitle:@"赎回" forState:UIControlStateNormal];
        _redeemBTN.titleLabel.font = [UIFont systemFontOfSize:12];
        //_redeemBTN.backgroundColor = [UIColor redColor];
        [_redeemBTN addTarget:self action:@selector(clickRedeem) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_redeemBTN] ;
        
        _daiMaLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 40)];
        _daiMaLB.font = [UIFont systemFontOfSize:11];
        _daiMaLB.numberOfLines = 2 ; 
        _daiMaLB.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_daiMaLB];
        
        _nameLB = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 111, 40)];
        _nameLB.font = [UIFont systemFontOfSize:11];
        _nameLB.numberOfLines = 2 ;
        _nameLB.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_nameLB];
        
        _fenELB = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, (SCREEN_WIDTH - 160) / 3, 40)];
        _fenELB.numberOfLines = 2 ;
        _fenELB.textAlignment = NSTextAlignmentCenter ;
        _fenELB.font = [UIFont systemFontOfSize:11];
        [self addSubview:_fenELB];
        
        _shiZhiLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + (SCREEN_WIDTH - 160) / 3, 0, (SCREEN_WIDTH - 160) / 3, 40)];
        _shiZhiLB.numberOfLines = 2 ;
        _shiZhiLB.textAlignment = NSTextAlignmentCenter ;
        _shiZhiLB.font = [UIFont systemFontOfSize:11];
        [self addSubview:_shiZhiLB];
    }
    return self ;
}

-(void)reloadDataDic:(NSDictionary *)dic{

    NSString *status = [dic objectForKey:@"status"];
    
    NSString *okFenE    =  [dic objectForKey:@"availablevol"];//可用份额
    if ((([status floatValue]==0)||([status floatValue]==5)||([status floatValue]==7)||([status floatValue]==8))&&([okFenE floatValue]!=0)) {
        
        [_redeemBTN setBackgroundImage:[UIImage imageNamed:@"redeemOK.png"] forState:UIControlStateNormal];
        _redeemBTN.selected = YES;
    }
    else{
    
    [_redeemBTN setBackgroundImage:[UIImage imageNamed:@"redeemCancel.png"] forState:UIControlStateNormal];
        _redeemBTN.selected = NO;
    }
    
    _daiMaLB.text = [dic objectForKey:@"fundcode"] ;
    
    _nameLB.text  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fundname"] ];;
    
    
    _fenELB.text  = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundvolbalance"] floatValue]]; 
    _shiZhiLB.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundmarketvalue"] floatValue]]; ;

}

-(void)clickRedeem{

    
    if (!_redeemBTN.selected) {
        return;
    }
    if (_delegate&&[_delegate respondsToSelector:@selector(clickRedeemFund:)]) {
        [_delegate clickRedeemFund:self];
    }

}
@end

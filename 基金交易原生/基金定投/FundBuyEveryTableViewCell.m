//
//  FundBuyEveryTableViewCell.m
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundBuyEveryTableViewCell.h"

@implementation FundBuyEveryTableViewCell

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
        _redeemBTN.frame = CGRectMake(160 + 2*(SCREEN_WIDTH - 160) / 3, 7.5, 40, 25); // 45
        _redeemBTN.layer.cornerRadius = 4 ;
        _redeemBTN.clipsToBounds = YES ;
        _redeemBTN.titleLabel.font = [UIFont systemFontOfSize:12];
        [_redeemBTN setTitle:@"定投" forState:UIControlStateNormal];
        //_redeemBTN.backgroundColor = [UIColor redColor];
        [_redeemBTN setBackgroundImage:[UIImage imageNamed:@"redeemOK.png"] forState:UIControlStateNormal];
        [_redeemBTN addTarget:self action:@selector(clickRedeem) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_redeemBTN] ;
        
        _daiMaLB = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 44, 40)];
        _daiMaLB.font = [UIFont systemFontOfSize:11];
        _daiMaLB.numberOfLines = 2 ;
        _daiMaLB.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_daiMaLB];
        
        _nameLB = [[UILabel alloc] initWithFrame:CGRectMake(48, 0, 111, 40)];
        _nameLB.font = [UIFont systemFontOfSize:11];
        _nameLB.numberOfLines = 2 ;
        _nameLB.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_nameLB];
        
        _StypeLB = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, (SCREEN_WIDTH - 160) / 3, 40)];
        _StypeLB.numberOfLines = 2 ;
        _StypeLB.textAlignment = NSTextAlignmentCenter ;
        _StypeLB.font = [UIFont systemFontOfSize:11];
        [self addSubview:_StypeLB];
        
        _jingZhiLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + (SCREEN_WIDTH - 160) / 3, 0, (SCREEN_WIDTH - 160) / 3, 40)];
        _jingZhiLB.numberOfLines = 2 ;
        _jingZhiLB.textAlignment = NSTextAlignmentCenter ;
        _jingZhiLB.font = [UIFont systemFontOfSize:11];
        [self addSubview:_jingZhiLB];
    }
    return self ;
}

-(void)reloadDataDic:(NSDictionary *)dic{
    
    if (dic) {
        NSString *status = [dic objectForKey:@"status"];
        if (([status floatValue]==0)||([status floatValue]==5)||([status floatValue]==6)||([status floatValue]==7)||([status floatValue]==8)) {
            
            [_redeemBTN setBackgroundImage:[UIImage imageNamed:@"redeemOK.png"] forState:UIControlStateNormal];
            _redeemBTN.selected = YES;
        }
        else{
            
            [_redeemBTN setBackgroundImage:[UIImage imageNamed:@"redeemCancel.png"] forState:UIControlStateNormal];
            _redeemBTN.selected = NO;
        }
    }
    
    
    NSString *fundtype =[NSString stringWithFormat:@"%@",[dic objectForKey:@"fundtype"]];
    switch ([fundtype intValue]) {
        case 0:
        {
        _StypeLB.text = @"股票型"  ;
        }
            break;
        case 1:
        {
           _StypeLB.text = @"债券型"  ;
        }
            break;
        case 2:
        {
           _StypeLB.text = @"货币型"  ;
        }
            break;
        case 3:
        {
           _StypeLB.text = @"混合型"  ;
        }
            break;
        case 4:
        {
            _StypeLB.text = @"专户基金"  ;
        }
            break;
        case 5:
        {
            _StypeLB.text = @"指数型"  ;
        }
            break;
        case 6:
        {
          _StypeLB.text = @"QDII型"  ;
        }
            break;
       
            
        default:
            break;
    }
    
    _daiMaLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fundcode"]];
    _nameLB.text  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fundname"]];
    
    _jingZhiLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nav"]] ;
    
}

-(void)clickRedeem{
    
    if (!_redeemBTN.selected) {
        return;
    }
    
    if (_delegate&&[_delegate respondsToSelector:@selector(clickEveryBuyButton:)]) {
        [_delegate clickEveryBuyButton:self];
    }
    
}

@end

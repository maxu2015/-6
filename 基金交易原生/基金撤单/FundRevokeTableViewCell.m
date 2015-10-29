//
//  FundRevokeTableViewCell.m
//  jiami2
//
//  Created by  展恒 on 15-1-29.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundRevokeTableViewCell.h"

@implementation FundRevokeTableViewCell

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
        
        _RevokeBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        _RevokeBTN.frame = CGRectMake(SCREEN_WIDTH - 50, 7.5, 40, 25);
        _RevokeBTN.layer.cornerRadius = 4 ;
        _RevokeBTN.titleLabel.font = [UIFont systemFontOfSize:12];
        _RevokeBTN.clipsToBounds = YES ;
        [_RevokeBTN setTitle:@"撤单" forState:UIControlStateNormal];
        //_RevokeBTN.backgroundColor = [UIColor redColor];
        [_RevokeBTN addTarget:self action:@selector(clickRevoke) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_RevokeBTN] ;
        

        _nameLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 111, 40)];
        _nameLB.font = [UIFont systemFontOfSize:11];
        _nameLB.numberOfLines = 2 ;
        _nameLB.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_nameLB];
        
        
        _YeWuLB = [[UILabel alloc] initWithFrame:CGRectMake(111, 0, 30, 40)];
        _YeWuLB.font = [UIFont systemFontOfSize:11];
        _YeWuLB.numberOfLines = 2 ;
        _YeWuLB.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_YeWuLB];
        
        _WeiTuoLB = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, (SCREEN_WIDTH - 160) / 3, 40)];
        _WeiTuoLB.numberOfLines = 2 ;
        _WeiTuoLB.textAlignment = NSTextAlignmentCenter ;
        _WeiTuoLB.font = [UIFont systemFontOfSize:11];
        [self addSubview:_WeiTuoLB];
        
        _RiQiLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + (SCREEN_WIDTH - 160) / 3, 0, (SCREEN_WIDTH - 160) / 3, 40)];
        _RiQiLB.numberOfLines = 2 ;
        _RiQiLB.textAlignment = NSTextAlignmentCenter ;
        _RiQiLB.font = [UIFont systemFontOfSize:11];
        [self addSubview:_RiQiLB];
    }
    return self ;
}

-(void)reloadDataDic:(NSDictionary *)dic{
    
    NSString *status = [dic objectForKey:@"status"];
    
    if (![status isEqualToString:@"05"]) {
        
        [_RevokeBTN setBackgroundImage:[UIImage imageNamed:@"redeemOK.png"] forState:UIControlStateNormal];
        _RevokeBTN.selected = YES ;
    }
    else{
    
        [_RevokeBTN setBackgroundImage:[UIImage imageNamed:@"redeemCancel.png"] forState:UIControlStateNormal];
        _RevokeBTN.selected = NO ;
        
        
//        [_RevokeBTN setBackgroundImage:[UIImage imageNamed:@"redeemOK.png"] forState:UIControlStateNormal];
//        _RevokeBTN.selected = YES ;
    }
    
    NSString *fundNameStr = [dic objectForKey:@"fundname"];
    NSString *businesscodeStr = @"" ;
    NSString *businesscode = [dic objectForKey:@"businesscode"];
    
    switch ([businesscode integerValue]) {
        case 20:
        {
            businesscodeStr = @"认购";
        }
            break;
        case 22:
        {
            businesscodeStr = @"申购";
        }
            break;
        case 24:
        {
            businesscodeStr = @"赎回";
        }
            break;
        case 26:
        {
            businesscodeStr = @"托管";
        }
            break;
        case 29:
        {
            businesscodeStr = @"分红";
        }
            break;
        case 36:
        {
            businesscodeStr = @"转换";
        }
            break;
        case 39:
        {
            businesscodeStr = @"定投";
        }
            break;
        case 59:
        {
            businesscodeStr = @"定投开通";
        }
            break;
        case 60:
        {
            businesscodeStr = @"定投撤销";
        }
            break;
        default:
            break;
    }
    NSString *applicationamountStr = [dic objectForKey:@"applicationamount"];
    
    if ([applicationamountStr floatValue]==0) {
        applicationamountStr = @"--";
    }
    
    NSString *operdateStr = [dic objectForKey:@"operdate"];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@/%@",[operdateStr substringWithRange:NSMakeRange(0, 4)],[operdateStr substringWithRange:NSMakeRange(4, 2)],[operdateStr substringWithRange:NSMakeRange(6, 2)]];
    
    _YeWuLB.text = businesscodeStr ;
    _nameLB.text  = fundNameStr;
    _WeiTuoLB.text  = applicationamountStr ;
    _RiQiLB.text = dateStr ;
    
}

-(void)clickRevoke{

    
    if (!_RevokeBTN.selected) {
        return;
    }
    if (_delegate&&[_delegate respondsToSelector:@selector(clickRevokeFund:)]) {
        [_delegate clickRevokeFund:self];
    }


}
@end

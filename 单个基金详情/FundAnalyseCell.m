//
//  FundAnalyseCell.m
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundAnalyseCell.h"

@implementation FundAnalyseCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadData
{
    _label1.text=_dataDict[@"ESymbol"];
    _label2.text=_dataDict[@"Sholding2"];
    _label3.text=_dataDict[@"Sholding6"];
    _label4.text=[NSString stringWithFormat:@"%@%s",_dataDict[@"Sholding7"],"%"];
}

@end

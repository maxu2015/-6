//
//  HistoryCell.m
//  CaiLiFang
//
//  Created by mac on 14-8-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

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
    _label1.text=_dataDict[@"DealDate"];
    _label2.text=_dataDict[@"UnitEquity"];
    _label3.text=[NSString stringWithFormat:@"%@",_dataDict[@"TotalEquity"]];
    _label4.text=[NSString stringWithFormat:@"%@%s",_dataDict[@"DayBenefit"],"%"];
    if ([_label4.text hasPrefix:@"-"]) {
        _label4.textColor=[UIColor colorWithRed:0.13f green:0.52f blue:0.00f alpha:1.00f];
    }
    else
        _label4.textColor=[UIColor colorWithRed:0.89f green:0.05f blue:0.00f alpha:1.00f];
}


@end

//
//  HistorySCell.m
//  CaiLiFang
//
//  Created by mac on 14-9-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "HistorySCell.h"

@implementation HistorySCell

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
}


@end

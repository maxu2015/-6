//
//  TransactionRecordsCell.m
//  CaiLiFang
//
//  Created by 08 on 15/5/13.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "TransactionRecordsCell.h"
#import "DrawHoldView.h"
@implementation TransactionRecordsCell

- (void)awakeFromNib {
    DrawHoldView *draw=[[DrawHoldView alloc]initWithFrame:CGRectMake(0, 0, 320, 198)];
    draw.backgroundColor=[UIColor clearColor];
    [self addSubview:draw];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

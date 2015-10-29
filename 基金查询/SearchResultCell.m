//
//  SearchResultCell.m
//  CaiLiFang
//
//  Created by mac on 14-8-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

//-(id)init
//{
//    if (self= [super init]) {
//        _dataDict=[[NSDictionary alloc]init];
//    }
//    return  self;
//}

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
    _label1.text=_dataDict[@"FundCode"];
    _label2.text=_dataDict[@"FundName"];
    _label3.text=_dataDict[@"FundType"];
}

@end

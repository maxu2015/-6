//
//  NewCateCell.m
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NewCateCell.h"

@implementation NewCateCell

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
    _titleLabel.text=_model.Title;
    
    NSArray *array=[_model.AddDate componentsSeparatedByString:@" "];
    if (array.count) {
        _addDateLabel.text=array[0];
    }
    else{
        _addDateLabel.text=_model.AddDate;
    }
}

@end

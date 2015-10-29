//
//  GSHasTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "GSHasTableViewCell.h"

@implementation GSHasTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)loadDataWith:(GSHasModel *)model{

    self.SName.text = model.SName;
    self.Fnetmoney.text = model.Fnetmoney;
    self.Smodel.text = model.Smodel;
    self.Startdate.text = model.Startdate;
    self.DEstimateEnd.text = model.DEstimateEnd;
}


@end

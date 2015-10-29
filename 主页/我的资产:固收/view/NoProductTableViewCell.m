//
//  NoProductTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "NoProductTableViewCell.h"

@implementation NoProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDataWith:(NPModel *)model{
    self.sname.text = model.sname;
    self.smodel.text = model.smodel;
    self.term.text = [NSString stringWithFormat:@"%@%@", model.term, @"天"];
    self.sdlowlimit.text = [NSString stringWithFormat:@"%@%@", model.sdlowlimit, @"万"];
}



@end

//
//  HotFundTableViewCell.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "HotFundTableViewCell.h"

@implementation HotFundTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buyFund:(id)sender {
    if (self.buyBlick) {
        self.buyBlick(_index);
    }
    
}

@end

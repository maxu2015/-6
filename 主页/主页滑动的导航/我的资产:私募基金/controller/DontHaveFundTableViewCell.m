//
//  DontHaveFundTableViewCell.m
//  CaiLiFang
//
//  Created by 展恒 on 15/9/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "DontHaveFundTableViewCell.h"

@implementation DontHaveFundTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)chackDeal:(id)sender {
    if (self.detail) {
        self.detail();
    }
}
- (IBAction)makeAnappointment:(id)sender {
    if (self.appointment) {
        self.appointment();
    }
}

@end

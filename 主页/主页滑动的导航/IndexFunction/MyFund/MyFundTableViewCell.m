//
//  MyFundTableViewCell.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MyFundTableViewCell.h"

@implementation MyFundTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UIView *vback=[self viewWithTag:201];
    UIView *vNum=[self viewWithTag:202];
    [vback.layer setBorderWidth:0.5];
    [vback.layer setBorderColor:[UIColor grayColor].CGColor];
    [vNum.layer setBorderWidth:0.5];
    [vNum.layer setBorderColor:[UIColor grayColor].CGColor];
}
- (IBAction)appointment:(id)sender {
    if (self.appointmentBlock) {
        self.appointmentBlock(_index);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

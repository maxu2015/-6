//
//  FundRevoTwoTableViewCell.m
//  jiami2
//
//  Created by  展恒 on 15-1-29.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//
#define IS_IOS_7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? YES : NO)

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height - ((IS_IOS_7) ? 0 : 20))

#import "FundRevoTwoTableViewCell.h"

@implementation FundRevoTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headLB = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 90, 24)];
        _headLB.font = [UIFont systemFontOfSize:12];
        [self addSubview:_headLB];
        
        _headTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH, 24)];
        _headTitleLB.font = [UIFont systemFontOfSize:12];
        _headTitleLB.textColor = [UIColor redColor];
        [self addSubview:_headTitleLB];
    }
    return self;
}
@end

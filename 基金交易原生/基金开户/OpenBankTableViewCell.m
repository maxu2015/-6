//
//  OpenBankTableViewCell.m
//  CaiLiFang
//
//  Created by  展恒 on 15-3-24.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "OpenBankTableViewCell.h"

@implementation OpenBankTableViewCell

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
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 97, 20)];
        [self addSubview:_headImageView];
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(120, 12, SCREEN_WIDTH-120, 20)];
        self.contentLB.font = [UIFont systemFontOfSize:16];
        [self addSubview:_contentLB];
    }
    return self ;

}
@end

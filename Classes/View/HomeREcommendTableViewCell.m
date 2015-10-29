//
//  HomeREcommendTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/23.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HomeREcommendTableViewCell.h"
@implementation HomeREcommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showdataWith:(NSDictionary *)dic
{
    NSString * BannerPic = [dic objectForKey:@"BannerPic"];
    NSMutableString * ban = [BannerPic mutableCopy];
    [ban deleteCharactersInRange:NSMakeRange(0, 1)];
    NSString * Imagestr = [NSString stringWithFormat:@"http://www.myfund.com%@", ban];
    NSURL * url = [NSURL URLWithString:Imagestr];
    NSData * data = [NSData dataWithContentsOfURL:url];
    self.subImage.image = [UIImage imageWithData:data];
}

@end

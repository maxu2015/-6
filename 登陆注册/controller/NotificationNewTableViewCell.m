//
//  NotificationNewTableViewCell.m
//  CaiLiFang
//
//  Created by  展恒 on 15-1-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "NotificationNewTableViewCell.h"

@implementation NotificationNewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(11, 4, SCREEN_WIDTH-22, 48)];
        _titleLB.font = [UIFont systemFontOfSize:15];
        _titleLB.textAlignment = NSTextAlignmentLeft;
        _titleLB.numberOfLines = 0 ;
        [self addSubview:_titleLB];
        
//        _smallLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 22, SCREEN_WIDTH-140, 20)];
//        _smallLB.font = [UIFont systemFontOfSize:12];
//        _smallLB.textColor = [UIColor lightGrayColor];
//        _smallLB.textAlignment = NSTextAlignmentLeft ;
        //[self addSubview:_smallLB] ;
        
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 60, 116, 18)];
        _timeLB.font = [UIFont systemFontOfSize:13];
        _timeLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLB];
    }
    return self ; 


}

-(void)reloadData:(NSDictionary *)dic{

    _smallLB.text = dic[@"SmallTitle"];
    _timeLB.text = [dic[@"AddDate"] componentsSeparatedByString:@" "][0];
    _titleLB.text = dic[@"Title"];
    _PushKey      = dic[@"PushKey"];
    

    
//    CGSize bound = [self getSizeOfStr:_titleLB.text font:[UIFont systemFontOfSize:14]];
//    
//    _titleLB.frame = CGRectMake(20, 2, SCREEN_WIDTH-20, bound.height);
//    _timeLB.frame  = CGRectMake(SCREEN_WIDTH-120, bound.height+14, 120, 15);

}



- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    //    CGSize size = [str sizeWithFont:font
    //                  constrainedToSize:CGSizeMake(280 , MAXFLOAT)];
    return rect.size;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

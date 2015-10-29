//
//  SeacherBackView.m
//  CaiLiFang
//
//  Created by 展恒 on 15/6/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "SeacherBackView.h"

@implementation SeacherBackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"SeacherBackView" owner:self options:0][0];
        self.frame=frame;
    }
    return self;
}
- (void)awakeFromNib {
    self.backgroundColor=[UIColor colorWithRed:232/255 green:232/255 blue:232/255 alpha:0.5];
    _seacherTV.alpha=0;
    _seacherHeader.alpha=0;

}
- (void)seacherViewHide {
    _seacherTV.alpha=0;
    _seacherHeader.alpha=0;
}
- (void)seacherViewShow {
    _seacherTV.alpha=1;
    _seacherHeader.alpha=1;
}
@end

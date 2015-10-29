//
//  UserDealView.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/20.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "UserDealView.h"

@implementation UserDealView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"UserDealView" owner:self options:0][0];
        self.frame=frame;
    }
    
    return self;
}
@end

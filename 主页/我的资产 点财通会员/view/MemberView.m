//
//  MemberView.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/14.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MemberView.h"
#import "IndexFuctionApi.h"
@implementation MemberView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"MemberView" owner:self options:0][0];
        self.frame=frame;
    }
    return self;
}
- (id)init {
    if (self=[super init]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"MemberView" owner:self options:0][0];

    }
    return self;
}
@end

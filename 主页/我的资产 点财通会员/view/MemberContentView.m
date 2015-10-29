//
//  MemberContentView.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/14.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MemberContentView.h"

@implementation MemberContentView {
    UIView *containerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        containerView = [[UINib nibWithNibName:@"MemberContentView" bundle:nil] instantiateWithOwner:self options:nil][0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        [self setBord];
    }
    return self;
}
- (void)setBord{
    for (int i=0; i<4; i++) {
        [[containerView viewWithTag:i+100].layer setBorderWidth:0.4];
        [[containerView viewWithTag:i+100].layer setBorderColor:[UIColor grayColor].CGColor];
    

    }
    _firstLabel=(UILabel*)[containerView viewWithTag:100];
    _secendLabel=(UILabel*)[containerView viewWithTag:101];
    _thirdLabel=(UILabel*)[containerView viewWithTag:102];
    _fourLabel=(UILabel*)[containerView viewWithTag:103];
    _revokeLable=(UIButton*)[containerView viewWithTag:104];
    [_revokeLable.layer setCornerRadius:5];
    [_revokeLable addTarget:self action:@selector(revoke) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)revoke{
    if (self.revokeBlock) {
        self.revokeBlock(_index);
    }

}
- (void)setContentTitle:(NSArray *)titleArray {
    for (int i=0; i<4; i++) {
        UILabel *v=(UILabel *)[containerView viewWithTag:i+100];
        v.text=titleArray[i];
    }

}
@end

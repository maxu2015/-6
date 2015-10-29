//
//  HCLabel.m
//  Test
//
//  Created by  展恒 on 14-10-27.
//  Copyright (c) 2014年 zhanheng. All rights reserved.
//

#import "HCLabel.h"

@implementation HCLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithframe:(CGRect)frame withtext:(NSString *)text withFont:(UIFont *)textFont withBreakLine:(BOOL)autoBreakLine{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.text = text ;
        self.font = textFont ;
        if (autoBreakLine) {//label是否自适应字体的多少
            CGSize size = CGSizeMake(frame.size.width, MAXFLOAT);
            NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName,nil];
            CGSize  actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
            self.bounds = CGRectMake(0, 0, actualsize.width, actualsize.height) ;
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

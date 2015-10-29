//
//  ProgressView.m
//  Process
//
//  Created by  展恒 on 14-11-28.
//  Copyright (c) 2014年 zhanheng. All rights reserved.
//

#define ProViewX  (self.frame.size.width/2)
#define ProViewY   (self.frame.size.height/2)
#import "ProgressView.h"

@interface ProgressView ()

@property(nonatomic,strong)UILabel *progreTextLabel ;
@end
@implementation ProgressView

-(id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame]  ;
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        _lineWidth = 1.5 ;
        _Progress = 0 ;
        
        _progreTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ProViewX, 20)];
        _progreTextLabel.center = CGPointMake(ProViewX, ProViewX-10);
        _progreTextLabel.font = [UIFont systemFontOfSize:15];
        _progreTextLabel.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:_progreTextLabel];
    }
    return self ;
}



-(void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext() ;
    CGContextSetLineWidth(context, _lineWidth) ;
    CGContextAddArc(context, ProViewX, ProViewY, ProViewX-_lineWidth, 0, M_PI*2, 0);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, ProViewX, ProViewY, ProViewX-_lineWidth, -M_PI_2,(_Progress-.25)*M_PI*2, 0);//从顶部开始 -M_PI_2----0------M_PI+M_PI_2   一周
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    CGContextStrokePath(context);
    
    _progreTextLabel.text = [NSString stringWithFormat:@"%.1f%%",_Progress*100];
    

}
-(void)updateView
{

    [self setNeedsDisplay] ; //跟新ui
}
@end

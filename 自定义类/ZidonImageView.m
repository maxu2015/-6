#import "ZidonImageView.h"

@implementation ZidonImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setDelegate:(id)delegate
{
    myDelegate=delegate;
    self.userInteractionEnabled=YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    if (touch.tapCount==1) {
        if ([myDelegate respondsToSelector:@selector(imageSingelClick:)]) {
            [myDelegate imageSingelClick:self];
        }
    }
}

@end

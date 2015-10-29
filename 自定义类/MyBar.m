#import "MyBar.h"

@implementation MyBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [[UIImage imageNamed:@"navBar"] drawInRect:rect];
}

@end

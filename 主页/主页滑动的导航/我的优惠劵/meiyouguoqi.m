

#import "meiyouguoqi.h"
#import "NoYouViewController.h"
@implementation meiyouguoqi
- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    //[self addUI];
    UIColor *color=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:240/255.0 alpha:1.0];
    self.backgroundColor=color;
    return self;
}
- (void)addUI{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(60, 40, SCREEN_WIDTH - 120, 200)];
    image.image=[UIImage imageNamed:@"youhuijuan"];
    [self addSubview:image];
//    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(60, 270, SCREEN_WIDTH - 120, 40)];
//    [button setImage:[UIImage imageNamed:@"mashangquqiangjuan"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(qiangjuan) forControlEvents:UIControlEventTouchDown];
//    [self addSubview:button];
}
- (void)qiangjuan{
    
    
    NoYouViewController *nouyou=[[NoYouViewController alloc]init];
    [APP_DELEGATE.rootNav pushViewController:nouyou animated:YES];
}

@end

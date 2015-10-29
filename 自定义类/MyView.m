#import "MyView.h"
@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = nil;
        _trackLayer.frame = self.bounds;
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = self.bounds;
        //默认5
        self.progressWidth = 5;//下面又重写的set方法
    }
    return self;
}

- (void)setTrack//2,9
{
    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress//3,7,10
{
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
}

- (void)setProgressWidth:(float)progressWidth//1,8
{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
    [self setTrack];
    [self setProgress];
}

- (void)setTrackColor:(UIColor *)trackColor//4
{
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor//5
{
    _progressLayer.strokeColor = progressColor.CGColor;
}

-(void)setProgressBool:(BOOL)progressBool
{
    _trackLayer = [CAShapeLayer new];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.frame = self.bounds;
    _progressLayer = [CAShapeLayer new];
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.frame = self.bounds;
    //默认5
    self.progressWidth = 5;//下面又重写的set方法
}

- (void)setProgress:(float)progress//6
{
    _progress = progress;
    [self setProgress];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    
}

@end

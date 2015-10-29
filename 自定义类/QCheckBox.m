#import "QCheckBox.h"

#define Q_CHECK_ICON_WH                    (15.0)
#define Q_ICON_TITLE_MARGIN                (5.0)

@implementation QCheckBox

@synthesize delegate = _delegate;
@synthesize checked = _checked;
@synthesize userInfo = _userInfo;

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        self.exclusiveTouch = YES;
        [self setImage:[UIImage imageNamed:@"uncheck_icon.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"check_icon.png"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setDelegate:(id<QCheckBoxDelegate>)delegate
{
    _delegate = delegate;
    
    self.exclusiveTouch = YES;
    [self setImage:[UIImage imageNamed:@"uncheck_icon.png"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"check_icon.png"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    _checked = checked;
    self.selected = checked;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked {
//    self.selected = !self.selected;
    _checked = self.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(20, 5, 30, 30);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(70, 0,150,40);
}

- (void)dealloc {
    [_userInfo release];
    _delegate = nil;
    [super dealloc];
}

@end

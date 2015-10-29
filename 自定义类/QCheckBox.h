#import <UIKit/UIKit.h>

@protocol QCheckBoxDelegate;

@interface QCheckBox : UIButton {
    id<QCheckBoxDelegate> _delegate;
    BOOL _checked;
    id _userInfo;
}

@property(nonatomic, assign)id<QCheckBoxDelegate> delegate;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, retain)id userInfo;

- (id)initWithDelegate:(id)delegate;

@end

@protocol QCheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked;

@end

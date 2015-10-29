#import <UIKit/UIKit.h>
@class ZidonImageView;
@protocol ZidonImageViewDelegate <NSObject>

-(void)imageSingelClick:(ZidonImageView *)imgView;

@end

@interface ZidonImageView : UIImageView
{
    SEL _selector;
    id myDelegate;
}

@property (nonatomic,weak) __weak id<ZidonImageViewDelegate> delegate;

@end

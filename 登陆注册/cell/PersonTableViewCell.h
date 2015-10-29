#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftText;

-(void)clear;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

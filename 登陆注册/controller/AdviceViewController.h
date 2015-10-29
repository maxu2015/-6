#import <UIKit/UIKit.h>

@interface AdviceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *adviceReview;
- (IBAction)commit:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLable;
- (IBAction)returnButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UILabel *wordsLimit;
@property (weak, nonatomic) IBOutlet UIView *bgUIView;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;

@end

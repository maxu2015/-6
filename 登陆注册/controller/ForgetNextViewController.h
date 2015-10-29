#import <UIKit/UIKit.h>

@interface ForgetNextViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
- (IBAction)completeCorrectPassword:(UIButton *)sender;
- (IBAction)returnButtonClick:(id)sender;


@end

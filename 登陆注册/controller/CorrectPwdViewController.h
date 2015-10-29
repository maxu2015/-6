#import <UIKit/UIKit.h>

@interface CorrectPwdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;

@property (weak, nonatomic) IBOutlet UITextField *cckTF;

@property (weak, nonatomic) IBOutlet UITextField *nearPassWordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)commitCorrect:(UIButton *)sender;
- (IBAction)returnButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cckNum;
- (IBAction)getCheckNum:(id)sender;


@end

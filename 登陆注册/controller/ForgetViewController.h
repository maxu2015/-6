#import <UIKit/UIKit.h>

@interface ForgetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *cckNum;
@property (weak, nonatomic) IBOutlet UITextField *checkNum;
- (IBAction)getCheckNum:(UIButton *)sender;

- (IBAction)next:(UIButton *)sender;

- (IBAction)returnButtonClick:(id)sender;

@end

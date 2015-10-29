#import <UIKit/UIKit.h>

@interface CorrectPhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *newlyPhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *checkNum;
@property (weak, nonatomic) IBOutlet UIButton *cckNum;

- (IBAction)getCheckNum:(UIButton *)sender;
- (IBAction)determineBtn:(UIButton *)sender;
- (IBAction)returnButtonClick:(id)sender;

@property(nonatomic,copy)void(^block)(NSString*);

@end

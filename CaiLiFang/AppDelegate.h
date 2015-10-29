#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)UIImageView *startImageView;

@property(nonatomic,strong)UINavigationController *rootNav ;
@property(nonatomic,strong)PPRevealSideViewController *slideViewController;

@property(nonatomic,strong)HomeViewController *hvc;

@property(nonatomic,assign) BOOL pushKey ;

@property(nonatomic,strong)NSDictionary *myUserDic ;
@end

#import "SetUpViewController.h"
#import "AdviceViewController.h"
#import "UseHelpViewController.h"
#import "ZidonAFNetWork.h"
#import "JSON.h"
#import "serveViewController.h"
#import "NotificationNewsViewController.h"
#import "APService.h"
#import "SDImageCache.h"
@interface SetUpViewController ()<zidonDelegate,UIAlertViewDelegate>

@end

@implementation SetUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setVersionLabel];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:FUNDPUSH]==nil) {
        NSLog(@"默认值");
        _switchSta.on = YES;
    }else{
        NSLog(@"bool = %d",[defaults boolForKey:FUNDPUSH]);
        
        if ([defaults boolForKey:FUNDPUSH]==YES) {
            NSLog(@"开状态");
            _switchSta.on = YES;
        }else if([defaults boolForKey:FUNDPUSH]==NO){
            NSLog(@"关状态");
            _switchSta.on = NO;
        }
    }
    
}
-(void)setVersionLabel
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    _currentVersion.text = [NSString stringWithFormat:@"当前版本为:%@",currentVersion];
//    NSLog(@"工程信息%@",infoDic);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushSet:(UISwitch *)sender {
    if (sender.on) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
/*
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80000
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
        
#endif
*/
        //[APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        //[APService setupWithOption:[defaults objectForKey:SAVELAUNCHOPTIONS]];
        
        // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
            [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                           UIUserNotificationTypeSound |
                                                           UIUserNotificationTypeAlert)
                                               categories:nil];
        } else {
            //categories 必须为nil
            [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                           UIRemoteNotificationTypeSound |
                                                           UIRemoteNotificationTypeAlert)
                                               categories:nil];
        }
#else
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
#endif
        // Required
        [APService setupWithOption:[defaults objectForKey:SAVELAUNCHOPTIONS]];
        
        
        
    }else{
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@(sender.on) forKey:FUNDPUSH];
    [defaults synchronize];
}

- (IBAction)adviceButton:(UIButton *)sender {
    AdviceViewController *advice=[[AdviceViewController alloc] init];
    [APP_DELEGATE.rootNav pushViewController:advice animated:YES];
}

- (IBAction)checkNewlyButton:(UIButton *)sender {
    [ProgressHUD show:@"正在检测！"];

    //获取到当前app的版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"%@",currentVersion);
    
    //获取appstore上得版本号进行对比
    NSString *url = @"http://itunes.apple.com/lookup?id=957252192";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc]initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [results JSONValue];
    [ProgressHUD dismiss];
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = infoArray[0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        //如果不相等  则证明有更新
        
        NSArray *lastArr = [lastVersion componentsSeparatedByString:@"."];
        NSArray *currentArr = [currentVersion componentsSeparatedByString:@"."] ;
        
        float currentVer = 0;
        float lastVer = 0 ;
        
        for (int i = 0; i<currentArr.count; i++) {
            currentVer += [[currentArr objectAtIndex:i] floatValue]*pow(10, 2-i);
        }
        for (int i = 0; i<lastArr.count; i++) {
            lastVer += [[lastArr objectAtIndex:i] floatValue]*pow(10, 2-i);
        }
        
        if (currentVer<lastVer) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新提示" message:@"有新的版本更新,是否前往更新？" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新", nil];
            alert.tag = 100;
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新提示" message:@"此版本为最新版本！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 101;
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新提示" message:@"此版本为最新版本！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 102;
        [alert show];
    }
}


//点击更新 事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/qun-xiang-dao/id957252192"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

-(void)requestFinished:(NSDictionary *)parmeters
{
    
}

-(void)requestFailed:(NSError *)error
{
    
}

- (IBAction)aboutUsButton:(UIButton *)sender {
    serveViewController *svc = [[serveViewController alloc]init];
    svc.urlName = @"about";
    svc.titleLabelText = @"关于我们";
    [APP_DELEGATE.rootNav pushViewController:svc animated:YES];
}

- (IBAction)useHelpButton:(UIButton *)sender {
    UseHelpViewController *help=[[UseHelpViewController alloc] init];
    [APP_DELEGATE.rootNav pushViewController:help animated:YES];
}

- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}


- (IBAction)notificationNews:(id)sender {
    
    
    NotificationNewsViewController *nnvc = [[NotificationNewsViewController alloc]init];
    [APP_DELEGATE.rootNav pushViewController:nnvc animated:YES];
}
-(IBAction)clearCache:(id)sender{

    [[SDImageCache sharedImageCache] clearDisk];
   NSString *localPath = [NSHomeDirectory()stringByAppendingPathComponent:@"Library/Caches/com.rnd.yin.CaiLiFang"] ;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:localPath error:nil];
    for (NSString *str in fileArray) {
        NSString *filePath = [localPath stringByAppendingPathComponent:str];
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    [self showToastWithMessage:@"缓存已清除" showTime:1];
    NSLog(@"------%@",localPath);
}
@end

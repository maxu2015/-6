#import "AppDelegate.h"
#import "MyBar.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QQConnection/QQConnection.h>
//#import <RennSDK/RennSDK.h>
//#import "WeiboSDK.h"
#import "JSON.h"
#import "cdfCustomInstance.h"
#import "NotificationNewsViewController.h"
//推送
#import "APService.h"
#import "HomeViewController.h"
#import "LoginManager.h"
#import "userInfo.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
//#import "UIImageView+WebCache.h"

//develper center申请的财立方:
//APP ID:1102466711
//APP KEY：piQn2xDJwNVzYw04

//友盟统计SDK
#import "MobClick.h"
@implementation AppDelegate
{
    UserInfo* user;
    LoginManager* login;
    NetManager* _net;
}

- (void)reloaddidFinishLaunchingWithOptions
{
}
//推送消息发出后，若程序未运行，此函数将被调用
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{

    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    //[userDef setValue:@"canJoInUser" forKey:@"iscanJoinUser"];//判断是否进入过登陆页面
    [userDef removeObjectForKey:@"iscanJoinUser"];

    [MobClick startWithAppkey:@"54fd6ad7fd98c561d00005fe" reportPolicy:BATCH channelId:nil];
    //设置友盟统计版本号
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString* document = [path objectAtIndex:0];

    NSLog(@"-------%@", document);

    NSLog(@"===========%@", launchOptions);

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    //浏览量统计 调用后台的接口
    AFHTTPRequestOperationManager* magr = [AFHTTPRequestOperationManager manager];
    [magr GET:CountForIOS
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
          NSLog(@"count ======== %@", responseObject[@"Count"]);
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
          NSLog(@"请求失败");
        }];

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    }
    else
    {
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
    [APService setupWithOption:launchOptions];

    //分享功能
    [self makeShare];

    NSLog(@"NSHomeDirectory===%@", NSHomeDirectory());

    _hvc = [[HomeViewController alloc] init];
    _rootNav = [[UINavigationController alloc] initWithNavigationBarClass:[MyBar class] toolbarClass:nil];

    _rootNav.viewControllers = @[ _hvc ];

    _slideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:_rootNav]; //侧滑添加导航

    _slideViewController.delegate = self;

    [_slideViewController changeOffset:1 forDirection:PPRevealSideDirectionLeft];

    _slideViewController.view.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = _slideViewController;
    [self.window makeKeyAndVisible];

    NSLog(@"------JPUSH=%@", [APService registrationID]);

    if(launchOptions) {

        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {

            [self performSelector:@selector(getnotifition) withObject:nil afterDelay:.3];
        }
    }
    return YES;
}

- (void)getnotifition
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_comeout" object:_myUserDic];
    _pushKey = NO;
}

- (void)promptUpData
{
    //获取到当前app的版本号
    NSDictionary* infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString* currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"%@", currentVersion);

    //获取appstore上得版本号进行对比   土豆url1102466711(原版)
    NSString* url = @"http://itunes.apple.com/lookup?id=957252192"; ////957252192
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse* urlResponse = nil;
    NSError* error = nil;
    NSData* recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    NSString* results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSMutableDictionary* dic = [results JSONValue];

    NSLog(@"-----dic = %@", dic);

    NSArray* infoArray = [dic objectForKey:@"results"];
    if([infoArray count])
    {
        NSDictionary* releaseInfo = infoArray[0];
        NSString* lastVersion = [releaseInfo objectForKey:@"version"];

        NSLog(@"--------%@--------%@", currentVersion, lastVersion);

        NSString* versinreleaseNotes = [releaseInfo objectForKey:@"releaseNotes"];

        int result1 = [currentVersion compare:lastVersion options:NSLiteralSearch];

        if(result1 == -1)
        {
            [self showAlertWithMessage:versinreleaseNotes];
        }
    }
}
//左对齐的alertview
- (void)showAlertWithMessage:(NSString*)message
{

    UIAlertView* tmpAlertView = [[UIAlertView alloc] initWithTitle:@"更新提示"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"忽略此版本", @"访问 App Store", nil];
    tmpAlertView.tag = 100;

    //如果你的系统大于等于7.0
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        CGSize size = [self getSizeOfStr:message font:[UIFont systemFontOfSize:15]];

        UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, size.height)];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.textColor = [UIColor blackColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping; //UILineBreakModeWordWrap;
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.text = message;
        [tmpAlertView setValue:textLabel forKey:@"accessoryView"];

        //这个地方别忘了把alertview的message设为空
        tmpAlertView.message = @"";
    }

    [tmpAlertView show];
}
- (CGSize)getSizeOfStr:(NSString*)str font:(UIFont*)font
{
    NSDictionary* attribute = @{NSFontAttributeName : font};

    CGRect rect = [str boundingRectWithSize:CGSizeMake(270, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];

    return rect.size;
}
//即将显示alertView
- (void)willPresentAlertView:(UIAlertView*)alertView
{
    for(UIView* view in alertView.subviews)
    {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel* label = (UILabel*)view;
            label.textAlignment = NSTextAlignmentLeft;
        }
    }
}
//点击更新 事件
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 100)
    {
        if(buttonIndex == 1)
        {
            NSURL* url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/qun-xiang-dao/id957252192"];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)removeStartImageView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:.8];
    [UIView setAnimationDidStopSelector:@selector(animationSotp)];
    _startImageView.frame = CGRectMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, 0, 0);
    [UIView commitAnimations];
}

- (void)animationSotp
{

    [_hvc promptUpData1];
    [_startImageView removeFromSuperview];
}
- (void)makeShare
{
    [ShareSDK registerApp:@"29131bb31710"];
//添加新浪微博应用 注册网址 http://open.weibo.com
//原版AppKey568898243,AppSecret38a4f8204cc784f81f9f0daaf31e02e3
//当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台

#if 0
    [ShareSDK  connectSinaWeiboWithAppKey:@"4009497384"
                                appSecret:@"e3dea69867420d484b3228c26b5ef776"
                              redirectUri:@"https://api.weibo.com/oauth2/default.html"                              weiboSDKCls:[WeiboSDK class]];
#endif

    //原版AppKey  801307650,AppSecret  ae36f4ee3946e1cbb98d6965b0b2ff5c
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"1102466711"
                                  appSecret:@"piQn2xDJwNVzYw04"
                                redirectUri:@"http://www.myfund.com/"
                                   wbApiCls:[WeiboApi class]];

    //原版AppKey100371282,AppSecret  aed9b0303e3ed1e27bae87c33761161d
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104068360"
                           appSecret:@"o6YRo5E5AYKNgRwV"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    //    [ShareSDK connectQZoneWithAppKey:@"1102584905" appSecret:@"K5HfJWQFYh9PGlPS"];

    //原版AppKey100371282,AppSecret  aed9b0303e3ed1e27bae87c33761161d
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"1104068360"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];

    //原版微信wx4868b35061f87885//包括微信好友，微信朋友圈，微信收藏
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx9d6082dfe3902d2d"
                           appSecret:@"25e1acf8dbcf585198d82886f1ed5938"
                           wechatCls:[WXApi class]];

    //    //添加网易微博应用 注册网址  http://open.t.163.com
    //    [ShareSDK connect163WeiboWithAppKey:@"T5EI7BXe13vfyDuy"
    //                              appSecret:@"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j"
    //                            redirectUri:@"http://www.shareSDK.cn"];

    //    //添加人人网应用 注册网址  http://dev.renren.com
    //    [ShareSDK connectRenRenWithAppId:@"226427"
    //                              appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
    //                           appSecret:@"f29df781abdd4f49beca5a2194676ca4"
    //                   renrenClientClass:[RennClient class]];
}

#pragma mark - 如果使用SSO（可以简单理解成客户端授权），以下方法是必要的
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}

/*
 *cdf 推送
 */

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{

    //通知注册成功

    NSLog(@"APServicedeviceToken:%@", deviceToken);
     [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{

    //接收到推送通知
    NSLog(@"userInfo :%@", userInfo);

    // Required
    // 处理收到的APNS消息，向服务器上报收到APNS消息
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication*)application didReceiveLocalNotification:(UILocalNotification*)notification
{

    NSLog(@"接收到本地通知");
}

//3.接受注册推送功能时出现的错误，并作出相应处理
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{

    //通知注册失败
    NSLog(@"错误信息:\n%@", error);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //点击推送消息，或者程序正在运行的时候走的方法
    NSLog(@"userInfo = %@", userInfo);

    //将得到的信息存储
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* notificationArray = [[defaults objectForKey:NOTIFICATIONNEWS] mutableCopy];
    if(notificationArray == nil) {
        notificationArray = [[NSMutableArray alloc] init];
    }
    [notificationArray addObject:userInfo];
    [defaults setObject:[notificationArray copy] forKey:NOTIFICATIONNEWS];
    [defaults synchronize];

    //将应用图标提示增加

    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    _myUserDic = [userInfo copy];
    _pushKey = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_comeout" object:userInfo];
}

/*
 */

//////////////////
- (void)networkDidSetup:(NSNotification*)notification
{
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification*)notification
{
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification*)notification
{
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification*)notification
{
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification*)notification
{
    NSLog(@"已经接受到消息");

    NSDictionary* userInfo = [notification userInfo];
    NSLog(@"userInfo :%@", userInfo);
}

//////////////////
- (void)applicationWillResignActive:(UIApplication*)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
    user = [UserInfo shareManager];
    login = [LoginManager shareManager];
    _net = [NetManager shareNetManager];
    if([UserInfo isLogin]) {

        [login requestUserlogin:[[user userInfoDic] objectForKey:@"IDCard"]];
    }

    //
    //    NSLog(@"程序再次激活");
}

- (void)applicationWillTerminate:(UIApplication*)application
{

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//applicationWillEnterForeground

@end

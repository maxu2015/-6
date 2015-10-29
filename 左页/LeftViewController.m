//
//  LeftViewController.m
//  CaiLiFang
//
//  Created by mac on 14-7-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LeftViewController.h"
#import "PPRevealSideViewController.h"
#import "SearchScanViewController.h"
#import "NewsViewController.h"
//#import "ClubListViewController.h"
#import "ShareViewController.h"
//#import "ClucDisViewController.h"
#import "AdviceViewController.h"
#import "SetUpViewController.h"
#import "DealViewController.h"
#import "SLFMDBUtil.h"
#import "FundChooseController.h"
#import "DownloadManager.h"
//#import "ClubSubmittedViewController.h"
#import "BannerDetailViewController.h"
//#import "ClucRootViewController.h"
#import "ZHUserAccount.h"
#import "serveViewController.h"
#import "APService.h"
#import "UseHelpViewController.h"
#import "SDImageCache.h"
#import "banbenjianceViewController.h"
#import "MFLoginViewController.h"
#import "userInfo.h"
#import "PersonCenterViewController.h"

@interface LeftViewController ()<ZidonImageViewDelegate>
{
    NSString *_userDefaults;
    BOOL _isLoginNow;
    NSString *_clubUrl;
    NSMutableDictionary *_clubDict;
    DownloadManager *_downloadManager;
    UserInfo *_user;
}
@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden=YES;
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}
-(void)setVersionLabel
{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    _currentVersion.text = [NSString stringWithFormat:@"v%@",currentVersion];
    //    NSLog(@"工程信息%@",infoDic);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    self.view.backgroundColor=[UIColor blackColor];
    [self.revealSideViewController setOptions:PPRevealSideOptionsShowShadows];
    [self.revealSideViewController changeOffset:100.0 forDirection:PPRevealSideDirectionLeft];
   
    if (![[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME]) {
        _headImg.image=[UIImage imageNamed:@"Shape-326"];
    }
    _headImg.delegate=self;
    //将头像修剪成圆形
    _headImg.clipsToBounds = YES;
    _headImg.layer.cornerRadius = 34;
    
    NSUserDefaults *userNUM = [NSUserDefaults standardUserDefaults];
    _userDefaults = [userNUM objectForKey:USERINFM];
    [self isLogin];
    _clubDict=[[NSMutableDictionary alloc]init];
    _downloadManager=[DownloadManager sharedDownloadManager];
    
    [self setVersionLabel];
//    [self setSwitch];
}

//判断是否登录，改变状态
#pragma mark---查找用户信息
-(void)isLogin
{
    //    NSLog(@"userDefaults = %@",_userDefaults);
    if (![UserInfo isLogin]) {
        //        NSLog(@"没有登录");
        _isLoginNow = NO;
    }else{
        //        NSLog(@"已登录");
        _nickNameLabel.text=[[_user userInfoDic] objectForKey:@"DisplayName"];
        NSString *phoneTest = [[_user userInfoDic] objectForKey:@"Mobile"];
        if (phoneTest.length==11) {
            phoneTest = [NSString stringWithFormat:@"%@****%@",[phoneTest substringWithRange:NSMakeRange(0, 3)],[phoneTest substringWithRange:NSMakeRange(7, 4)]];
        }
        
        _phoneNumLabel.text = phoneTest;
        NSArray *pathR = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [pathR objectAtIndex:0];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *filePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"headerImage%@",[defaults objectForKey:USERNICKNAME]]];
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:filePath];
        if (image) {
            _headImg.image = image;
        }else{
            _headImg.image = [UIImage imageNamed:@"头像"];
        }
        _isLoginNow = YES;
    }
}
-(void)imageSingelClick:(ZidonImageView *)imgView
{
    
    
    if (_isLoginNow == NO) {
        MFLoginViewController *loginVC=[[MFLoginViewController alloc] init];
        [loginVC loginSucceed:^(NSString *LoginBlock) {
            [APP_DELEGATE.hvc.menuView setSelectedIndex:0];
            [loginVC.navigationController popViewControllerAnimated:YES];
        }];
        [self.revealSideViewController popViewControllerAnimated:YES];
        [self.delegate pushViewController:loginVC];
    }else{
        PersonCenterViewController *person=[[PersonCenterViewController alloc]init];

        [self.revealSideViewController popViewControllerAnimated:YES];
        [self.delegate pushViewController:person];
    }
}


-(void)onclick:(UIButton*)button
{
    YYLog(@"点击");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        MFLoginViewController *loginVC=[[MFLoginViewController alloc] init];
        [loginVC loginSucceed:^(NSString *LoginBlock) {
            [APP_DELEGATE.hvc.menuView setSelectedIndex:0];
            [loginVC.navigationController popViewControllerAnimated:YES];
        }];
        
        [APP_DELEGATE.rootNav pushViewController:loginVC animated:YES];

        [self.delegate pushViewController:loginVC];
    }
}



//liaojuncai/juncai417883
-(void)clubDownloadFinished
{
    _clubDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_clubUrl];
    NSLog(@"%d",[_clubDict[@"ReturnResult"] intValue]);
    switch ([_clubDict[@"ReturnResult"] intValue]) {
        case 0:
        {

            
//            ClubListViewController *clvc=[[ClubListViewController alloc]init];
//            [self.revealSideViewController popViewControllerAnimated:YES];
//            [self.delegate pushViewController:clvc];
        }
            break;
        case 1:
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名为空!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录",nil];
            [self.view addSubview:alertView];
            [alertView show];
            
        }
            break;
        case 2:
        {
//            ClubSubmittedViewController *cavc=[[ClubSubmittedViewController alloc]init];
//            cavc.wordDetail=@"                      审核未通过用户\n\n提示已提交申请,但审核未通过,您可以再次申请";
//            [self.revealSideViewController popViewControllerAnimated:YES];
//            [self.delegate pushViewController:cavc];
        }
            break;
        case 3:
        {
//            ClubSubmittedViewController *csvc=[[ClubSubmittedViewController alloc]init];
//            csvc.wordDetail=@"                      已提交申请,\n\n           我们会在3天内进行审核.";
//            csvc.reApplyType=1;
//            [self.revealSideViewController popViewControllerAnimated:YES];
//            [self.delegate pushViewController:csvc];
        }
            break;
        case 4:
        {
//            ClucDisViewController *cdvc=[[ClucDisViewController alloc]init];
//            [self.revealSideViewController popViewControllerAnimated:YES];
//            [self.delegate pushViewController:cdvc];
        }
            break;
        case 5:
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"系统参数错误!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [self.view addSubview:alertView];
            [alertView show];
        }
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_clubUrl object:nil];
}

//分享
- (IBAction)shareButtonOnClick:(id)sender {
    ShareViewController *share=[[ShareViewController alloc] init];
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.delegate pushViewController:share];
}

//设置
- (IBAction)referButtonOnClick:(id)sender {
    SetUpViewController *set=[[SetUpViewController alloc] init];
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.delegate pushViewController:set];
}

#pragma mark------点击侧边栏的按钮
-(IBAction)clickLeftBtn:(UIButton *)sender{

    switch (sender.tag) {
        case 101:
        {//关于我们
            serveViewController *svc = [[serveViewController alloc]init];
            svc.urlName = @"about";
            svc.titleLabelText = @"关于我们";
            [self.revealSideViewController popViewControllerAnimated:YES];
            [self.delegate pushViewController:svc];
        }
            break;
        case 102:
        {
            NSLog(@"1dianji");
        }
            break;
        case 103:
        {
            AdviceViewController *advice=[[AdviceViewController alloc] init];
            [self.revealSideViewController popViewControllerAnimated:YES];
            [self.delegate pushViewController:advice];
        }
            break;
        case 104:
        {
            banbenjianceViewController *banben=[[banbenjianceViewController alloc]init];
            [self.revealSideViewController popViewControllerAnimated:YES];
            [self.delegate pushViewController:banben];
        }
            break;
        case 105:
        {
            UseHelpViewController *help=[[UseHelpViewController alloc] init];
            [self.revealSideViewController popViewControllerAnimated:YES];
            [self.delegate pushViewController:help];
 
        }
            break;
        case 106:
        {
            [[SDImageCache sharedImageCache] clearDisk];
            NSString *localPath = [NSHomeDirectory()stringByAppendingPathComponent:@"Library/Caches/com.rnd.yin.CaiLiFang"] ;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:localPath error:nil];
            for (NSString *str in fileArray) {
                NSString *filePath = [localPath stringByAppendingPathComponent:str];
                [fileManager removeItemAtPath:filePath error:nil];
            }
            
            [self showToastWithMessage:@"缓存已清除" showTime:1];
        }
            break;
        case 107:
        {
            ShareViewController *share=[[ShareViewController alloc] init];
            [self.revealSideViewController popViewControllerAnimated:YES];
            [self.delegate pushViewController:share];
        }
            break;
        case 108:
        {
            

 //6之后
            NSString  * nsStringToOpen = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=957252192"];//957252192
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
            
        
        }
            break;
            
        default:
            break;
    }

}






- (void)showToastWithMessage:(NSString *)message showTime:(float)interval
{
    TipLabel * tip = [[TipLabel alloc] init];
    [tip showToastWithMessage:message showTime:interval];
}
- (IBAction)pushSet:(UISwitch *)sender {
    if (sender.on) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

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











@end

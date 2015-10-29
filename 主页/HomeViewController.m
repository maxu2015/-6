//
//  HomeViewController.m
//  CaiLiFang
//
//  Created by mac on 14-7-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "DownloadManager.h"
#import "BannerDetailViewController.h"
#import "HDLViewController.h"
#import "NotificationNewsViewController.h"
#import "NotificationInformationViewController.h"
#import "FundChooseController.h"
#import "QueryFundInforViewController.h"
#import "Service.h"
#import "JSON.h"
#import "ProgressHUD.h"
#import "NewsViewController.h"
#import "ZHUserAccount.h"
#import "userInfo.h"
#import "MFLoginViewController.h"
#import "IndexFuctionApi.h"

@interface HomeViewController ()<EAIntroDelegate>


-(void)enterFirst;
-(void)enterSecond;
-(void)enterthrid;
-(void)enterFour;
@end

@implementation HomeViewController
{
     CGRect childFrame;
    NSMutableArray *_bannerArray;
    NSMutableArray *_indexArray;
    DownloadManager *_downloadManager;
    NSString *_bannerUrlString;
    NSString *_indexUrlString;
    NSString *_monthUrlString;
    NSMutableArray *_monthArray;
    UserInfo *_user;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)promptUpData1
{
    //获取到当前app的版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"%@",currentVersion);
    
    //获取appstore上得版本号进行对比   土豆url1102466711(原版)
    NSString *url = @"http://itunes.apple.com/lookup?id=957252192";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];

    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSData *recervedData = data;
        NSString *results = [[NSString alloc]initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *dic = [results JSONValue];
        
        NSArray *infoArray = [dic objectForKey:@"results"];
        NSLog(@"------%@",infoArray);
        if ([infoArray count]) {
            NSDictionary *releaseInfo = infoArray[0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            
            
            NSLog(@"--------%@--------%@",lastVersion,currentVersion);
            
            NSString *versinreleaseNotes = [releaseInfo objectForKey:@"releaseNotes"];
            [versinreleaseNotes stringByReplacingOccurrencesOfString:@" " withString:@""];
            int result1 = [currentVersion compare:lastVersion options:NSLiteralSearch];
            
            
            if (result1 == -1) {
                [self showAlertWithMessage:versinreleaseNotes];
  
            }
        }
    }];
    
    
}

//左对齐的alertview
- (void) showAlertWithMessage:(NSString *) message{
    
    UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:@"更新提示"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"忽略此版本",@"访问 App Store", nil];
    tmpAlertView.tag = 100;
    
    //如果你的系统大于等于7.0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        CGSize size = [self getSizeOfStr:message font:[UIFont systemFontOfSize:15]];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, size.height)];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.textColor = [UIColor blackColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;//UILineBreakModeWordWrap;
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.text = message;
        [tmpAlertView setValue:textLabel forKey:@"accessoryView"];
        
        //这个地方别忘了把alertview的message设为空
        tmpAlertView.message = @"";
    }
    
    [tmpAlertView show];
}

- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{ NSFontAttributeName:font};
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(270 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    
    return rect.size;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=YES;
    [self startFirst];  //判断是否为第一次启动
    
}

-(void)notifiConeOut:(id)dic {
    
    
    
    NSLog(@"----%@---%@",dic,[dic class]);
    if (dic) {
        NotificationInformationViewController *noti = [[NotificationInformationViewController alloc] initWithPushKey:[dic objectForKey:@"PushKey"]];
        noti.view.backgroundColor = [UIColor whiteColor];
 
        if (noti.pushKey.length>0) {
            [APP_DELEGATE.rootNav pushViewController:noti animated:NO];
        }
        
    }
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    /*
     
     */
    childFrame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationCone:) name:@"Notification_comeout" object:nil];
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [self.SlideButton addTarget:self action:@selector(enterLeftNavication) forControlEvents:UIControlEventTouchUpInside];//左btn
    [self requestBannerData];//六个图片的数据请求
    [self statisticsCount];
    [self enterFirst];
    [self creatSegment];
}

-(void)creatSegment{
    self.menuView = [[CustomMenuView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49) type:MENU_TYPE_MAIN_MENU_DING];
    self.menuView.menuDelegate = self;
    [self.menuView addMenuSelectedBlock:^(CustomMenuView *view, NSInteger selectedIndex, NSInteger lastSelectedIndex) {
        
    }];
    NSArray * menuNames = @[@"首页",@"推荐",@"资讯",@"我的"];
    NSArray * menuImgs =@[@"首页_icon@2x",@"推荐_icon@2x",@"资讯_icon@2x",@"资产_icon@2x"];
    NSArray * selectedmenuImgs = @[@"首页up_icon@2x",@"推荐up_icon@2x",@"资讯up_icon@2x",@"资产up_icon@2x"];
    [self.menuView initMenuBtns:menuImgs selected:selectedmenuImgs itemNames:menuNames];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width_mainScreen, 1)];
    imageView.image = [UIImage imageNamed:@"横线_icon@2x.png"];
    [_menuView addSubview:imageView];
    [self.view addSubview:_menuView];
    [self.view bringSubviewToFront:_menuView];

}

#pragma mark CustomMenuViewDelegate
- (void)menuSelectedIndex:(NSInteger)index lastSelectedIndex:(NSInteger)lastIndex menuView:(CustomMenuView *)view
{
    
    switch (index) {
        case 0://租车
        {
            [self enterFirst];
        }
            break;
        case 1://驾客
        {
             [self enterSecond];
            //设置是否显示Guide View
            

        }
            break;
        case 2://车东
        {
            [self enterthrid];
        }
            break;
        case 3://更多
        {
            [self enterFour];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)enterFirst{
    if (!self.honeFirstNav) {
        self.homeFirstVC = [[HomeFirstViewController alloc] init];
        self.homeFirstVC.view.frame = childFrame ;
        self.honeFirstNav = [[UINavigationController alloc] initWithRootViewController:self.homeFirstVC];
        self.honeFirstNav.navigationBarHidden = YES ;

    }
    else{
        [self.homeFirstVC clicktransactionButton];
    
    }
    [self.homeFirstVC clickLeftBtn:^{
        [self enterLeftNavication];
    }];
    [self switchViewToShow:self.honeFirstNav.view];
    
}

-(void)enterSecond{
    if (!self.honeSecondNav) {
        self.homeSecondVC = [[HomeREcommendViewController alloc] init];
        self.honeSecondNav = [[UINavigationController alloc] initWithRootViewController:self.homeSecondVC];
        self.honeSecondNav.navigationBarHidden = YES;
    }
    
    [self switchViewToShow:self.honeSecondNav.view];
}
-(void)enterthrid{
    self.homeThridVC = [[HomeSecondViewController alloc] init];
    self.honeThridNav = [[UINavigationController alloc] initWithRootViewController:self.homeThridVC];
    self.homeThridVC.title = @"基金资讯";
    self.honeThridNav.navigationBarHidden = NO;


    [self switchViewToShow:self.honeThridNav.view];
}

-(void)clickMyButton{
    _user=[UserInfo shareManager];
    
    if (![UserInfo isLogin]) {
        //还没登陆
        //还没有登陆
        MFLoginViewController *loginVC=[[MFLoginViewController alloc] init];
        
        [loginVC loginSucceed:^(NSString *LoginBlock) {
             [APP_DELEGATE.hvc.menuView setSelectedIndex:0];
            [loginVC.navigationController popViewControllerAnimated:YES];
        }];
        
        [APP_DELEGATE.rootNav pushViewController:loginVC animated:YES];
    }
}

-(void)enterFour{
         if (!self.honeFourNav) {
        self.homeFourVC = [[HomeFourViewController alloc] init];
        self.honeFourNav = [[UINavigationController alloc] initWithRootViewController:self.homeFourVC];
        self.honeFourNav.navigationBarHidden = YES ; 
    }
    
    [self.homeFourVC clickLeftBtn:^{
        [self enterLeftNavication];
        
    }];
    
    [self.homeFourVC clickMyButton];
    [self switchViewToShow:self.honeFourNav.view];
}

- (void)switchViewToShow:(UIView *)view
{
    if (self.curShowView && view != self.curShowView) {
        view.frame = childFrame;
        [self.curShowView removeFromSuperview];
        [self.view addSubview:view];
    }else if(!self.curShowView){
        view.frame = childFrame;
        [self.view addSubview:view];
    }
    
   if (!IS_IOS_7) [self.view layoutIfNeeded];
    self.curShowView = view;
    [self.view bringSubviewToFront:self.menuView];
}
#pragma mark--------统计接口

-(void)statisticsCount{
    
    
    //推送消息图片
    [_emailButton setImage:[UIImage imageNamed:@"邮件"] forState:UIControlStateNormal];
    NSURL *url = [NSURL URLWithString:@"http://app.myfund.com:8484/Service/DemoService.svc/cailifangCountForIOS"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        

    }];
    
}
-(void)NotificationCone:(NSNotification *)noti

{
    [self notifiConeOut:noti.object];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    
    [super viewDidAppear:animated];
}


//第一次启动的启动页
-(void)startFirst
{
    // 判断是否为第一次启动
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (![[defaults objectForKey:@"one"] isEqualToString:@"first"]) {
        [defaults setObject:@"first" forKey:@"one"];
        [defaults synchronize];
        EAIntroPage *page1 = [EAIntroPage page];
        
        page1.bgImage = [UIImage imageNamed:@"1引导页@2x.jpg"];
        EAIntroPage *page2 = [EAIntroPage page];
        page2.bgImage = [UIImage imageNamed:@"２引导页@2x.jpg"];
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.bgImage = [UIImage imageNamed:@"3引导页@2x.jpg"];
        
        _intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
        
        [_intro setDelegate:self];
        [_intro showInView:self.view animateDuration:0.0];
    }
}



-(void)requestRoundProgressData
{
    _monthUrlString=[NSString stringWithFormat:@"http://app.myfund.com:8484/Service/DemoService.svc/GetMonthMaxExpected"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monthDownloadFinished) name:_monthUrlString object:nil];
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    
    
    [_downloadManager addDownloadWithURLString:_monthUrlString andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)monthDownloadFinished
{

}


-(void)roundProgressClick:(UITapGestureRecognizer*)tgr
{
//    LimitGoodsViewController *lvc=[[LimitGoodsViewController alloc]init];
//    [APP_DELEGATE.rootNav pushViewController:lvc animated:YES];
}

-(void)requestBannerData
{
    _bannerArray=[[NSMutableArray alloc]init];
    _indexArray=[[NSMutableArray alloc]init];
    
    
  _bannerUrlString= GetBanner2;

    //建议：这两个通知放在下面两个方法下面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerDownloadFinished) name:_bannerUrlString object:nil];

    
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_bannerUrlString andColumnId:1 andFileId:1 andCount:1 andType:1];
    
    
}

-(void)indexDownloadFinished
{
    _indexArray=[_downloadManager getDownloadDataWihtURLString:_indexUrlString];
    
    if (_indexArray.count>=2) {
    }
}

//滚动试图
-(void)bannerDownloadFinished
{
    //滚动试图scrollview
    _bannerArray=[_downloadManager getDownloadDataWihtURLString:_bannerUrlString];
   
    [_homeFirstVC reloadBrabdData:_bannerArray];

    [self.view bringSubviewToFront:_intro];
}


//点击滚动试图调用的代理方法
-(void)pushViewController:(UIViewController *)viewController
{
    [APP_DELEGATE.rootNav pushViewController:viewController animated:YES];
    
}


-(void)enterLeftNavication{
    //点击左上角按钮，出现抽屉效果
    
    LeftViewController *lvc = [[LeftViewController alloc]init];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:lvc];
    lvc.delegate=self;
    // 修改方向
    [self.revealSideViewController pushViewController:nc onDirection:PPRevealSideDirectionLeft animated:YES];
}


//查看推送消息

-(IBAction)clickEmailBtn{

    NotificationNewsViewController *nnvc = [[NotificationNewsViewController alloc]init];
    [APP_DELEGATE.rootNav pushViewController:nnvc animated:YES];

}
//亨得利接口
-(void)requestHDLPageURL{
    [ProgressHUD show:nil];
    NSString *url = @"http://app.myfund.com:8484/Service/DemoService.svc/GetMainPart?imageId=03";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error) {
        //错误
    }
    else{
        
        NSArray *dataarr = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            
        }
        else{
            
            
            NSLog(@"--------%@",dataarr);
            if (dataarr&&(dataarr.count>0)) {
                
                NSString *PageURL  = [[dataarr objectAtIndex:0] objectForKey:@"PageURL"];
                NSString *Description = [[dataarr objectAtIndex:0] objectForKey:@"Description"];
                NSString *Title = [[dataarr objectAtIndex:0] objectForKey:@"Title"];
                
                NSString *ImageURL = [[dataarr objectAtIndex:0] objectForKey:@"ImageURL"];
                NSMutableString *picString=[[NSMutableString alloc]initWithString:ImageURL];
                NSMutableString *urlString=[[NSMutableString alloc]initWithString:IMAGE_PREFIX];
                if (picString.length>0) {
                    [picString replaceCharactersInRange:NSMakeRange(0, 1) withString:[urlString substringToIndex:21]];
                }
                
                _HDLDescription = Description ;
                _HDLImageURL = picString ;
                _HDLPageURL = PageURL ;
                _HDLTitle = Title ; 
                HDLViewController *hvc=[[HDLViewController alloc]init];
                hvc.urlName=@"hdl";
                hvc.HDLPageURL = PageURL;
                hvc.HDLDescription = Description ;
                hvc.HDLTitle = Title ;
                hvc.HDLImageURL = picString ;
                [APP_DELEGATE.rootNav pushViewController:hvc animated:YES];
            }
        }
        
    }
    [ProgressHUD dismiss];
}

#if 0
#endif

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/qun-xiang-dao/id957252192"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
    
    if (alertView.tag==10086) {
        if (buttonIndex==1) {
            MFLoginViewController *loginVC=[[MFLoginViewController alloc] init];
            [loginVC loginSucceed:^(NSString *LoginBlock) {
                [APP_DELEGATE.hvc.menuView setSelectedIndex:0];
                [loginVC.navigationController popViewControllerAnimated:YES];
            }];

            [APP_DELEGATE.rootNav pushViewController:loginVC animated:YES];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

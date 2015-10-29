//
//  LLLockViewController.m
//  LockSample
//
//  Created by Lugede on 14/11/11.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "LLLockViewController.h"
#import "LLLockIndicator.h"
#import   "LoginViewController.h"

#import "BannerDetailViewController.h"
#import "QueryFundInforViewController.h"
#import "Service.h"
#import "NSError+NetworkError.h"
#define kTipColorNormal [UIColor blackColor]
#define kTipColorError [UIColor redColor]


@interface LLLockViewController ()
{
    int nRetryTimesRemain; // 剩余几次输入机会
}

@property (weak, nonatomic) IBOutlet UIImageView *preSnapImageView; // 上一界面截图
@property (weak, nonatomic) IBOutlet UIImageView *currentSnapImageView; // 当前界面截图
@property (nonatomic, strong) IBOutlet LLLockIndicator* indecator; // 九点指示图
@property (nonatomic, strong) IBOutlet LLLockView* lockview; // 触摸田字控件
@property (strong, nonatomic) IBOutlet UILabel *tipLable;
@property (strong, nonatomic) IBOutlet UIButton *tipButton; // 重设/(取消)的提示按钮

@property (nonatomic, strong) NSString* savedPassword; // 本地存储的密码
@property (nonatomic, strong) NSString* passwordOld; // 旧密码
@property (nonatomic, strong) NSString* passwordNew; // 新密码
@property (nonatomic, strong) NSString* passwordconfirm; // 确认密码
@property (nonatomic, strong) NSString* tip1; // 三步提示语
@property (nonatomic, strong) NSString* tip2;
@property (nonatomic, strong) NSString* tip3;

@end


@implementation LLLockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(LLLockViewType)type
{
    self = [super init];
    if (self) {
        _nLockViewType = type;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.indecator.backgroundColor = [UIColor clearColor];
    self.lockview.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor blueColor];
    
//    self.horiScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    
    self.lockview.delegate = self;
    
    NSLog(@"实例化了一个LockVC");
}

- (void)viewWillAppear:(BOOL)animated
{
    
#ifdef LLLockAnimationOn
    [self capturePreSnap];
#endif
    
    [super viewWillAppear:animated];
    
    // 初始化内容
    switch (_nLockViewType) {
        case LLLockViewTypeCheck:
        {
            _tipLable.text = @"请输入解锁密码";
        }
            break;
        case LLLockViewTypeCreate:
        {
            _tipLable.text = @"创建手势密码";
        }
            break;
        case LLLockViewTypeModify:
        {
            _tipLable.text = @"请输入原来的密码";
        }
            break;
        case LLLockViewTypeClean:
        default:
        {
            _tipLable.text = @"请输入密码以清除密码";
        }
    }
    
    // 尝试机会
    nRetryTimesRemain = LLLockRetryTimes;
    
    self.passwordOld = @"";
    self.passwordNew = @"";
    self.passwordconfirm = @"";
    
    // 本地保存的手势密码
    self.savedPassword = [LLLockPassword loadLockPassword];
    
    NSLog(@"本地保存的密码是%@", self.savedPassword);
    
    [self updateTipButtonStatus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 检查/更新密码
- (void)checkPassword:(NSString*)string
{
    // 验证密码正确
    if ([string isEqualToString:self.savedPassword]) {
        
        if (_nLockViewType == LLLockViewTypeModify) { // 验证旧密码
            
            self.passwordOld = string; // 设置旧密码，说明是在修改
            
            [self setTip:@"请输入新的密码"]; // 这里和下面的delegate不一致，有空重构
            
        } else if (_nLockViewType == LLLockViewTypeClean) { // 清除密码

            [LLLockPassword saveLockPassword:nil];
            [self hide];
            
            [self showAlert:self.tip2];
            
        } else { // 验证成功
            
            
            //密码输入正确
            [self hide];
        }
        
    }
    // 验证密码错误
    else if (string.length > 0) {
        
        nRetryTimesRemain--;
        
        if (nRetryTimesRemain > 0) {
            
            if (1 == nRetryTimesRemain) {
                [self setErrorTip:[NSString stringWithFormat:@"最后的机会!"]
                           errorPswd:string];
            } else {
                [self setErrorTip:[NSString stringWithFormat:@"密码错误，还可以再输入%d次", nRetryTimesRemain]
                           errorPswd:string];
            }
            
        } else {
            
//            // 强制注销该账户，并清除手势密码，以便重设
//            [self dismissViewControllerAnimated:NO completion:nil]; // 由于是强制登录，这里必须以NO ani的方式才可
//            [LLLockPassword saveLockPassword:nil];
            
            [self showAlertEnd:@"您已输入错误超过5次，请重新输入登陆密码"];
        }
        
    } else {
        NSAssert(YES, @"意外情况");
    }
}

- (void)createPassword:(NSString*)string
{
    // 输入密码
    if ([self.passwordNew isEqualToString:@""] && [self.passwordconfirm isEqualToString:@""]) {
        
        self.passwordNew = string;
        [self setTip:self.tip2];
    }
    // 确认输入密码
    else if (![self.passwordNew isEqualToString:@""] && [self.passwordconfirm isEqualToString:@""]) {

        self.passwordconfirm = string;
        
        if ([self.passwordNew isEqualToString:self.passwordconfirm]) {
            // 创建成功
            NSLog(@"两次密码一致");
            
            NSString *Phonestr = [[NSUserDefaults standardUserDefaults]objectForKey:USEROHONENUM];
            Service *ser = [Service sharedInstance];
            
            [ser queryFundID:Phonestr withPwdGesture:string success:^(id data) {
                
                
                [LLLockPassword saveLockPassword:string];
                
                //[self showAlert:self.tip3];
                
                [self hide];
               // NSLog(@"--------data  =  %@",data);
                /*
                 (
                 {
                 ReturnResult = 1;
                 }
                 )
                 */
                
                
                
                
            } failure:^(NSError *error) {
                
                
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"lock"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self showAlert:[error examineNetError]];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            
        } else {
            
            self.passwordconfirm = @"";
            [self setTip:self.tip2];
            [self setErrorTip:@"与上一次绘制不一致，请重新绘制" errorPswd:string];
            
        }
    } else {
        NSAssert(1, @"设置密码意外");
    }
}

#pragma mark - 显示提示
- (void)setTip:(NSString*)tip
{
    [_tipLable setText:tip];
    [_tipLable setTextColor:kTipColorNormal];
    
    _tipLable.alpha = 1;
    [UIView animateWithDuration:0.8
                     animations:^{
                          _tipLable.alpha = 1;
                     }completion:^(BOOL finished){
                     }
     ];
}

// 错误
- (void)setErrorTip:(NSString*)tip errorPswd:(NSString*)string
{
    // 显示错误点点
    [self.lockview showErrorCircles:string];
    
    // 直接_变量的坏处是
    [_tipLable setText:tip];
    [_tipLable setTextColor:kTipColorError];
    
    [self shakeAnimationForView:_tipLable];
}

#pragma mark 新建/修改后保存
- (void)updateTipButtonStatus
{
    NSLog(@"重设TipButton");
    if ((_nLockViewType == LLLockViewTypeCreate || _nLockViewType == LLLockViewTypeModify) &&
        ![self.passwordNew isEqualToString:@""]) // 新建或修改 & 确认时 才显示按钮
    {
        [self.tipButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [self.tipButton setAlpha:1.0];
        
    } else {
        [self.tipButton setAlpha:1.0];
    }
   
    // 更新指示圆点
    if (![self.passwordNew isEqualToString:@""] && [self.passwordconfirm isEqualToString:@""]){
        self.indecator.hidden = NO;
        [self.indecator setPasswordString:self.passwordNew];
    } else {
        self.indecator.hidden = YES;
        //[self.indecator setPasswordString:self.passwordNew];
    }
}

#pragma mark - 点击了按钮
- (IBAction)tipButtonPressed:(id)sender {
    
    self.passwordNew = @"";
    self.passwordconfirm = @"";
    [self setTip:self.tip1];
    [self updateTipButtonStatus];
    
    [self showLogin:@"忘记手势密码，请重新登录"];
    
}

#pragma mark - 成功后返回
- (void)hide
{
    switch (_nLockViewType) {
            
        case LLLockViewTypeCheck:
        {
            
            
            
        }
            break;
        case LLLockViewTypeCreate:
        case LLLockViewTypeModify:
        {
            
            //[LLLockPassword saveLockPassword:self.passwordNew];
            
            
        }
            break;
        case LLLockViewTypeClean:
        default:
        {
            [LLLockPassword saveLockPassword:nil];
        }
    }
    
    // 在这里可能需要回调上个页面做一些刷新什么的动作

#ifdef LLLockAnimationOn
     [self captureCurrentSnap];
    // 隐藏控件
    for (UIView* v in self.view.subviews) {
        if (v.tag > 10000) continue;
        v.hidden = YES;
    }
    //解锁密码创建成功与输入密码正确的时候走的方法
    
    /*
    BannerDetailViewController *bdvc=[[BannerDetailViewController alloc]init];
    bdvc.presentToCom = YES ;
    bdvc.urlString=@"https://apptrade.myfund.com:8383/appweb/";
    [self.navigationController pushViewController:bdvc animated:YES];
    
    */
    
    
    QueryFundInforViewController *queryFund = [[QueryFundInforViewController alloc] init];
    queryFund.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:queryFund animated:YES];
    
//    if ([_delegate respondsToSelector:@selector(LLLockDisappear:)]) {
//        [_delegate LLLockDisappear:self];
//    }
    
    // 动画解锁
    //[self animateUnlock];
    
#else
    
    //[self.navigationController popViewControllerAnimated:NO];
    //[self dismissViewControllerAnimated:NO completion:nil];
#endif
    
}

#pragma mark - delegate 每次划完手势后
- (void)lockString:(NSString *)string
{
    NSLog(@"这次的密码=--->%@<---", string) ;
    
    
    
    
    switch (_nLockViewType) {
            
        case LLLockViewTypeCheck:
        {
            self.tip1 = @"请输入解锁密码";
            [self checkPassword:string];
        }
            break;
        case LLLockViewTypeCreate:
        {
            
            if (string.length<4) {
                [self showAlert:@"手势密码不能低于四位"];
                return ;
            }
            self.tip1 = @"创建解锁密码";
            self.tip2 = @"请再次绘制解锁密码";
            self.tip3 = @"解锁密码创建成功";
            [self createPassword:string];
        }
            break;
        case LLLockViewTypeModify:
        {
            if ([self.passwordOld isEqualToString:@""]) {
                self.tip1 = @"请输入原来的密码";
                [self checkPassword:string];
            } else {
                self.tip1 = @"请输入新的密码";
                self.tip2 = @"请再次输入密码";
                self.tip3 = @"密码修改成功";
                [self createPassword:string];
            }
        }
            break;
        case LLLockViewTypeClean:
        default:
        {
            self.tip1 = @"请输入密码以清除密码";
            self.tip2 = @"清除密码成功";
            [self checkPassword:string];
        }
    }
    
    [self updateTipButtonStatus];
}

#pragma mark - 解锁动画
// 截屏，用于动画
#ifdef LLLockAnimationOn
- (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// 上一界面截图
- (void)capturePreSnap
{
    self.preSnapImageView.hidden = YES; // 默认是隐藏的
    self.preSnapImageView.image = [self imageFromView:self.presentingViewController.view];
}

// 当前界面截图
- (void)captureCurrentSnap
{
    self.currentSnapImageView.hidden = YES; // 默认是隐藏的
    self.currentSnapImageView.image = [self imageFromView:self.view];
}

- (void)animateUnlock{
    
    self.currentSnapImageView.hidden = NO;
    self.preSnapImageView.hidden = NO;
    
    static NSTimeInterval duration = 0.5;
    
    // currentSnap
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
    
    CABasicAnimation *opacityAnimation;
    opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue=[NSNumber numberWithFloat:1];
    opacityAnimation.toValue=[NSNumber numberWithFloat:0];
    
    CAAnimationGroup* animationGroup =[CAAnimationGroup animation];
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;
    animationGroup.delegate = self;
    animationGroup.autoreverses = NO; // 防止最后显现
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [self.currentSnapImageView.layer addAnimation:animationGroup forKey:nil];
    
    // preSnap
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1];
    
    animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;

    [self.preSnapImageView.layer addAnimation:animationGroup forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.currentSnapImageView.hidden = YES;
    [self.navigationController popViewControllerAnimated:NO];
    //[self dismissViewControllerAnimated:NO completion:nil];
}
#endif

#pragma mark 抖动动画
- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES]; // 平滑结束
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark - 提示信息
- (void)showAlert:(NSString*)string
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:string
                                                   delegate:nil
                                          cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alert.backgroundColor = [UIColor whiteColor];
    [alert show];
}
- (void)showAlertEnd:(NSString*)string
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    alert.backgroundColor = [UIColor whiteColor];
    [alert show];
}

- (void)showLogin:(NSString*)string
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
    alert.backgroundColor = [UIColor whiteColor];
    alert.tag = 1001;
    [alert show];
}

//当错误了五次，点击
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag == 1000) {
        NSUserDefaults *quitLogin = [NSUserDefaults standardUserDefaults];
        [quitLogin removeObjectForKey:USERINFM];
        [quitLogin removeObjectForKey:USERNICKNAME];
        [quitLogin removeObjectForKey:USEROHONENUM];
        
        LoginViewController *loginVC=[[LoginViewController alloc] init];
        //loginVC.view.backgroundColor = [UIColor redColor];
        loginVC.type = 0;
        loginVC.presentToCon = YES ;
        //[self.revealSideViewController popViewControllerAnimated:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
        
        //[self dismissViewControllerAnimated:NO completion:nil]; // 由于是强制登录，这里必须以NO ani的方式才可
        [LLLockPassword saveLockPassword:nil];
    }
    if (alertView.tag == 1001) {
        if (buttonIndex==1) {
            NSUserDefaults *quitLogin = [NSUserDefaults standardUserDefaults];
            
            
            [quitLogin removeObjectForKey:USERINFM];
            [quitLogin removeObjectForKey:USERNICKNAME];
            [quitLogin removeObjectForKey:USEROHONENUM];
            [LLLockPassword saveLockPassword:nil];
            
            NSString *Phonestr = [[NSUserDefaults standardUserDefaults]objectForKey:USEROHONENUM];
            
            Service *ser = [Service sharedInstance];
            [ser queryFundID:Phonestr withPwdGesture:nil success:^(id data) {
             
                //密码清空重新设置
                LoginViewController *loginVC=[[LoginViewController alloc] init];
                //loginVC.view.backgroundColor = [UIColor redColor];
                loginVC.type = 0;
                loginVC.presentToCon = YES ;
                //[self.revealSideViewController popViewControllerAnimated:YES];
                [self.navigationController pushViewController:loginVC animated:YES];
                
                //[self dismissViewControllerAnimated:NO completion:nil]; // 由于是强制登录，这里必须以NO ani的方式才可
                [LLLockPassword saveLockPassword:nil];
            } failure:^(NSError *error) {
                [self showAlert:[error examineNetError]];
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
            
        }
       
    }

}

@end

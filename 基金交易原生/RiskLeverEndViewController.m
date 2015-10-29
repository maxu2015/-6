//
//  RiskLeverEndViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-3-17.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "RiskLeverEndViewController.h"
#import "ZHUserAccount.h"
#import "DealSystemViewController.h"
#import "userInfo.h"
@interface RiskLeverEndViewController ()

@end

@implementation RiskLeverEndViewController {
    UserInfo *_user;

}

- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{ NSFontAttributeName:font};
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(300 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    
    return rect.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   NSString *custrisk  = [NSString stringWithFormat:@"%@",[self.mydic objectForKey:@"custrisk"]];
    [self refrisklevel:custrisk];
}


-(void)refrisklevel:(NSString *)risklevel{
    
    NSString *title = @"";
    NSString *content = @"";
    NSString *nengli  = @"" ;
    NSString *qiDai   = @"" ;
    
    if ([risklevel isEqualToString:@"01"]) {
        title = [NSString stringWithFormat:@"风险等级:%@",@"安逸型"];
        content = @"安逸型：安逸型投资者：在基金投资过程中，保护本金不受损失和保持资产的流动性是您的首要目标。您对投资的态度是希望投资收益稳定，不愿或不能承担高风险以换取高收益，通常不太在意资金是否有较大增值，追求稳定。";
        nengli = @"风险承受能力：低";
        qiDai = @"获利期待：很稳定的投资收益";
    }
    if ([risklevel isEqualToString:@"02"]) {
        title = [NSString stringWithFormat:@"风险等级:%@",@"保守型"];
        content = @"保守型：保守型投资者：稳定是您首要考虑的因素之一。在基金投资中，您希望在保证本金安全的基础上能有一些增值收入。追求较低的风险，对投资回报的要求不是太高。";
        nengli = @"风险承受能力：较低";
        qiDai = @"获利期待：稳定的投资收益";
    }
    if ([risklevel isEqualToString:@"03"]) {
        title = [NSString stringWithFormat:@"风险等级:%@",@"稳健型"];
        content = @"稳健型：稳健型投资者：在基金投资的过程中，风险较小的情况下获得一定的收益是您主要的投资目的。您通常愿意使本金面临一定的风险，但在做投资决定时，会仔细地对将要面临的风险进行认真的分析。总体来看，您愿意承受市场的平均风险。";
        nengli = @"风险承受能力：中";
        qiDai = @"获利期待：中等回报率";
    }
    if ([risklevel isEqualToString:@"04"]) {
        title = [NSString stringWithFormat:@"风险等级:%@",@"积极型"];
        content = @"积极型：在基金投资中，您渴望有较高的投资收益，但又不愿承受较大的风险；可以承受一定的投资波动，但是希望自己的投资风险小于市场的整体风险。您有较高的收益目标，且对风险有清醒的认识。";
        nengli = @"风险承受能力：中高";
        qiDai = @"获利期待：中高回报率";
    }
    if ([risklevel isEqualToString:@"05"]) {
        title = [NSString stringWithFormat:@"风险等级:%@",@"激进型"];
        content = @"激进型：在基金投资中，您渴望有较高的投资收益，但又不愿承受较大的风险；可以承受一定的投资波动，但是希望自己的投资风险小于市场的整体风险。您有较高的收益目标，且对风险有清醒的认识。";
        nengli = @"风险承受能力：高";
        qiDai = @"获利期待：高回报率";
    }
    
    CGSize size = [self getSizeOfStr:content font:[UIFont systemFontOfSize:14]];
    
    _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 152, size.width, size.height)] ;
    _contentLB.font = [UIFont systemFontOfSize:14];
    _contentLB.numberOfLines = 0 ;
    
    _nengLiLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 152+size.height+10+10, SCREEN_WIDTH-20, 20)];
    _nengLiLB.font = [UIFont systemFontOfSize:14];
    
    _qiDaiLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 152+size.height+10+40+10, SCREEN_WIDTH-20, 20)];
    _qiDaiLB.font = [UIFont systemFontOfSize:14];
    
    
    _titleLB.text = title ;
    _contentLB.text = content ;
    _nengLiLB.text = nengli;
    _qiDaiLB.text = qiDai ;
    
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 152+size.height+10, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 152+size.height+10+40, SCREEN_WIDTH, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 152+size.height+10+80, SCREEN_WIDTH, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line3];
    [self.view addSubview:_contentLB];
    [self.view addSubview:_nengLiLB];
    [self.view addSubview:_qiDaiLB];
    
    UIButton *endPage = [UIButton buttonWithType:UIButtonTypeCustom];
    endPage.frame = CGRectMake(80, 152+size.height+10+80+20, SCREEN_WIDTH-160, 30);
    [endPage setTitle:@"返回" forState:UIControlStateNormal];
    endPage.backgroundColor = [UIColor redColor];
    [endPage addTarget:self action:@selector(clickEndButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endPage];
}

-(void)clickEndButton{
    _user=[UserInfo shareManager];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[_user getLocalDic:@"DealMsg"]];
    
    NSString *point  = [NSString stringWithFormat:@"%@",[self.mydic objectForKey:@"point"]];
    NSString *custrisk  = [NSString stringWithFormat:@"%@",[self.mydic objectForKey:@"custrisk"]];
    
    
    if (point) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        [userDefaultes setValue:custrisk forKey:@"risklevel"];//风险等级保
        DealSystemViewController *info;
        for (UIViewController *VC in self.navigationController.childViewControllers) {
            if ([VC isKindOfClass:[DealSystemViewController class]]) {
                //重新评定风险
                
                info = (DealSystemViewController *)VC ;
                [dic setObject:custrisk forKey:@"risklevel"];
                [_user syncDataToLocal:@"DealMsg" userInfoDic:dic];
                [self.navigationController popToViewController:VC animated:YES];
                return ;
            }
        }
        if (info==nil) {
            [APP_DELEGATE.hvc.menuView setSelectedIndex:3];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }

    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clickEND:(id)sender{

    [self clickEndButton];
   }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

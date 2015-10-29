//
//  GuShouSuccessViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/10.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "GuShouSuccessViewController.h"
#import "CustomIOS7AlertView.h"
#import "GlobalConfig.h"

#define Font [UIFont systemFontOfSize:15]
#define lx 100
#define ly 270

@interface GuShouSuccessViewController ()
{
    CustomIOS7AlertView * _customView;
}


@property (strong, nonatomic) IBOutlet UILabel *productTitle;
@property (strong, nonatomic) IBOutlet UILabel *fName;

@property (strong, nonatomic) IBOutlet UILabel *fcount;


@property (strong, nonatomic) IBOutlet UILabel *promptLabel;



@end

@implementation GuShouSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _customView = [CustomIOS7AlertView sharedInstace];
    
    [self setUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUI
{
    
    UILabel * fBank = [[UILabel alloc] init];
    fBank.font = [UIFont systemFontOfSize:15];
    fBank.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    fBank.numberOfLines = 0;
    
    UILabel * prompt = [[UILabel alloc] init];
    prompt.font = [UIFont systemFontOfSize:13];
    prompt.textColor = [UIColor redColor];
    prompt.text = @"提示：";
    prompt.frame = CGRectMake(41, ly, 68, 21);
    [self.view addSubview:prompt];
    
    if ([self.product isEqualToString:@"恒有财"]) {
       
        self.productTitle.text = @"恒有财汇款账户";
        self.fName.text = @"吕艳梅";
        self.fcount.text = @"6215590200009252164";
        fBank.text = @"工商银行北京分行王府井新东安支行";
        
        self.promptLabel.hidden = YES;
        [self setPrompt];
        
    }
    else if ([self.product isEqualToString:@"恒得利"]){
    
        self.productTitle.text = @"恒得利汇款账户";
        self.fName.text = @"北京展恒基金销售有限公司";
        fBank.text = @"7117610182600003334";
        
        CGRect rect = CGRectMake(10, 320, SCREEN_WIDTH - 20, 40);
        [self createBtnWith:rect];
        
    }
    
    NSDictionary * dict = @{NSFontAttributeName:Font};
    CGRect rect = [fBank.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 112, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
   fBank.frame = CGRectMake(112, 213, SCREEN_WIDTH - 112, rect.size.height);
    [self.view addSubview:fBank];
}

-(void)setPrompt{
    
    NSArray * titleArr = @[@"1.转账汇款时请注明“姓名+手机号”",
                           @"2.请用本人银行卡账户打款",
                           @"3.汇款成功后请将截图发送到邮箱“service@myfund.com”",
                           @"4.预约成功后工作人员会在2个工作日内与您联系"
                           ];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel * label = [[UILabel alloc] init];
        int height = 0;
        if (i < 2) {
            height = 21;
            label.frame = CGRectMake(lx, ly + height * i, SCREEN_WIDTH - 100, height);

        }
        else{
            height = 42;
            label.frame = CGRectMake(lx, ly + 2 * 21 + (i - 2) * height, SCREEN_WIDTH - 100, height);
        }
        
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor redColor];
        label.text = titleArr[i];
        label.numberOfLines = 0;
        
        [self.view addSubview:label];
        
        if (i == 3) {
            CGRect rect = CGRectMake(10, SCREEN_HEIGHT - 80, SCREEN_WIDTH - 20, 40);
            [self createBtnWith:rect];
        }
    }
}

-(void)createBtnWith:(CGRect)rect
{
    
    CGPoint point = rect.origin;
    CGSize size = rect.size;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(point.x, point.y, size.width,  size.height);
    [btn setBackgroundImage:[UIImage imageNamed:@"下一步背景.png"] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)pressSureBtn:(id)sender {
    
    [_customView popAlert:@"预约成功"];
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
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

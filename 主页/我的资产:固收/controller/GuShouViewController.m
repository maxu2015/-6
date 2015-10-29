 //
//  GuShouViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/8.
//  Copyright (c) 2015年 08. All rights reserved.
//


#import "GuShouViewController.h"

#import "NetManager.h"
#import "userInfo.h"
#import "GuShouDealHistoryViewController.h"
#import "GuShouHasViewController.h"
#import "NoProductViewController.h"

@interface GuShouViewController ()
- (IBAction)FanHuiWoDe:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *dealHistory;

@end

@implementation GuShouViewController
{   NetManager *_netManager;
    NSArray *_chiyouxinxiArray;
    UserInfo *_user;
    GuShouDealHistoryViewController * _gSDealhistory;
    NSString * _IDCard;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    [self setUI];
    [self ifIdcard];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"持有固收";


}
-(void)setUI
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"交易记录";
    label.font = [UIFont systemFontOfSize:15 weight:3];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressDealAction:)];
    [label addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];
}
/**
 *  点击交易记录按钮
 */
-(void)pressDealAction:(UITapGestureRecognizer *)tap
{
    _gSDealhistory = [[GuShouDealHistoryViewController alloc] init];
    _gSDealhistory.title = @"交易记录";
    [APP_DELEGATE.rootNav pushViewController:_gSDealhistory animated:YES];
}

- (void)ifIdcard{
    
    NSDictionary *dic=[_user userInfoDic];
    _IDCard = [dic objectForKey:@"IDCard"];
    if (_IDCard && _IDCard.length==18) {
        //18为身份证
        [self createData];
    }
    else{
        
        [self createData];
    }
}

- (void)createData {
    [ProgressHUD show:nil];
    _netManager =[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:@"%@%@",GMJL,[[_user userInfoDic] objectForKey:@"IDCard"]];
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _chiyouxinxiArray=[NSMutableArray arrayWithArray:data];
        
        if (([_chiyouxinxiArray count]==0)){
            

            
            NoProductViewController * noProduct = [[NoProductViewController alloc] init];
            noProduct.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
            [self.view addSubview:noProduct.view];
            [self addChildViewController:noProduct];
        }
        else{

            
            GuShouHasViewController * gushou = [[GuShouHasViewController alloc] init];
            gushou.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
            
            gushou.IDCard = _IDCard;
            [self.view addSubview:gushou.view];
            [self addChildViewController:gushou];

        }
        
        [self reloadInputViews];
        [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
        NoProductViewController * noProduct = [[NoProductViewController alloc] init];
        noProduct.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self.view addSubview:noProduct.view];
        [self addChildViewController:noProduct];
    } Tag:'cell'];
}


- (IBAction)FanHuiWoDe:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end

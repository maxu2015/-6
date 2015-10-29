//
//  FundDanYeViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "FundDanYeViewController.h"

@interface FundDanYeViewController ()<UIScrollViewDelegate>



@end

@implementation FundDanYeViewController
-(id)initWithfundCode:(NSString *)fundCode{
    
    self = [super init];
    if (self) {
        self.fundCode = fundCode ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self setUI];
}

-(void)tabItemSelectedAtIndex:(int)index tabItem:(CustomTabItemView1 *)view{

    //NSLog(@"=======%d",index);
    
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:1 animations:^{
        
        [_ScrollView setContentOffset:CGPointMake(_ScrollView.frame.size.width*index, 0) animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    switch (index) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
            if (!_managerInfoVC) {
                _managerInfoVC = [[ProductManagerViewController alloc] initWithfundCode:_fundCode];
                _managerInfoVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35);

                [self addChildViewController:_managerInfoVC];
                [_ScrollView addSubview:_managerInfoVC.view];
            }
           
            
        }
            break;
        case 2:
        {
            if (!_companyInfoVC) {
                _companyInfoVC = [[ProductCompanyViewController alloc] initWithfundCode:_fundCode];
                _companyInfoVC.view.frame = CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35);
                [self addChildViewController:_companyInfoVC];
                [_ScrollView addSubview:_companyInfoVC.view];
            }
        }
            break;
            
        default:
            break;
    }
}


-(void)setUI{

    
    _customTab = [[CustomTabItemView1 alloc] initWithFrame:CGRectMake(0, 64+7, SCREEN_WIDTH, 23) type:TAB_ITEM_TYPE_DEFAULT1];
    [_customTab initWithItemNames:@[@"产品详情",@"基金经理",@"基金公司"]];
    _customTab.delegate = self ;
    [_customTab setBtnBackColor:[UIColor whiteColor] withTitleColor:COLOR_RGB(51,188,218)];
    [self.view addSubview:_customTab];
    
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+35, SCREEN_WIDTH, SCREEN_HEIGHT-64-35)];
    _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT-64-35);
    _ScrollView.pagingEnabled = YES ;
    _ScrollView.delegate =self ;
    _ScrollView.backgroundColor = [UIColor whiteColor];
    _ScrollView.bounces = NO;
    _ScrollView.showsHorizontalScrollIndicator = NO;
    _ScrollView.showsVerticalScrollIndicator   = NO;
    [self.view addSubview:_ScrollView] ;
    
    _InfomationVC = [[ProductInfoViewController alloc] initWithfundCode:_fundCode];

    _InfomationVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35);
    [self addChildViewController:_InfomationVC];
    [_ScrollView addSubview:_InfomationVC.view];
    
    
    
//    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSLog(@"======scrollViewDidEndDecelerating");
    int pageNum = scrollView.contentOffset.x / SCREEN_WIDTH;
    [_customTab setSelectedIndex:pageNum];
    if (pageNum==1) {
        
        if (!_managerInfoVC) {
            _managerInfoVC = [[ProductManagerViewController alloc] initWithfundCode:_fundCode];
            _managerInfoVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35);

            [self addChildViewController:_managerInfoVC];
            [_ScrollView addSubview:_managerInfoVC.view];
        }
    }
    
    if (pageNum==2) {
        
        if (!_companyInfoVC) {
            _companyInfoVC = [[ProductCompanyViewController alloc] initWithfundCode:_fundCode];
            _companyInfoVC.view.frame = CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35);
            [_ScrollView addSubview:_companyInfoVC.view];
        }
    }
}
-(IBAction)navBar:(id)sender{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

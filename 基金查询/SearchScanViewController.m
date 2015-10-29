//
//  SearchScanViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-2.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SearchScanViewController.h"
#import "DownloadManager.h"
#import "HomeFundSearcViewController.h"

@interface SearchScanViewController ()

@end

@implementation SearchScanViewController
{
    UIView *_view;
    UITextField *_textField;
    UIButton *_cancelButton;
    UIView *_translucentView;
    UIView *_translucentView2;
    SearchResultViewController *_searchVC;
    UIView *_indicatorView;
    DownloadManager *_downloadManager;
    NSMutableArray *_indexArray;
    NSArray *titleArr;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setIndexData];
    [self createSelectBut];
    titleArr=@[@"股票型",@"混合型",@"QDII",@"指数型",@"债券型",@"保本型",@"货币型"];
    [_searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self createChildViewController];
}
- (void)createSelectBut {
    _downButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 70, 82, 30)];
    [_downButton addTarget:self action:@selector(downButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_downButton setTitle:@"股票型" forState:UIControlStateNormal];
    _downButton.backgroundColor=[UIColor lightGrayColor];
    _downButton.layer.cornerRadius=5;
        [self.view addSubview:_downButton];

}


-(void)downButtonClick:(UIButton *)button
{
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0)];
    
    _view.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [self.view addSubview:_view];
    
    UIView *moreView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    moreView.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    [_view addSubview:moreView];
    
    UILabel *moreLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 40, 40)];
    moreLabel.text=@"更多";
    moreLabel.font=[UIFont systemFontOfSize:14];
    moreLabel.textColor=[UIColor colorWithRed:0.53f green:0.52f blue:0.52f alpha:1.00f];
    [moreView addSubview:moreLabel];
    
    UIButton *moreButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 10, 40, 30)];
    [moreButton setImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:moreButton];
    
    NSArray *titleArray=@[@"股票型",@"混合型",@"QDII",@"指数型",@"债券型",@"保本型",@"货币型"];
    
    [self.view bringSubviewToFront:_view];
    
    _translucentView2=[[UIView alloc]initWithFrame:CGRectMake(0, 214, SCREEN_WIDTH, self.view.bounds.size.height-214)];
    _translucentView2.backgroundColor=[UIColor blackColor];
    _translucentView2.alpha=0.3;
    
    [UIView animateWithDuration:0.2 animations:^{
        _view.frame=CGRectMake(0, 64, SCREEN_WIDTH, 150);
    } completion:^(BOOL finished) {
        for (int i=0; i<titleArray.count; i++) {
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(20+i%4*(SCREEN_WIDTH - 40)/4, 60+i/4*40, (SCREEN_WIDTH - 40)/4, 30)];//60
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:13];
            [button setTitleColor:[UIColor colorWithRed:0.53f green:0.52f blue:0.52f alpha:1.00f] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            button.tag=101+i;
            //101,102,103....
            [button addTarget:self action:@selector(transitonToViewController:) forControlEvents:UIControlEventTouchUpInside];
            //button.backgroundColor = [UIColor redColor];
            [_view addSubview:button];
            
            UILabel *verticalLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+i%4*(SCREEN_WIDTH - 40)/4, 65+i/4*40, 1, 15)];
            verticalLabel.backgroundColor=[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
            if (i%4==0) {
                verticalLabel.backgroundColor=[UIColor clearColor];
            }
            [_view addSubview:verticalLabel];
        }
        for (int i=0; i<2; i++) {
            UILabel *horizonLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 92+i*40, SCREEN_WIDTH - 20, 1)];
            horizonLabel.backgroundColor=[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
            [_view addSubview:horizonLabel];
        }
        
        [self.view addSubview:_translucentView2];
        [self.view bringSubviewToFront:_translucentView2];
    }];

}

-(void)fundTypeButtonClick:(UIButton *)button
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _indicatorView.frame=CGRectMake((button.tag-1001)*60, 33, 60, 3);
    }];
    UIView *view=[self.view viewWithTag:11+button.tag-1001];
    
    
    NSLog(@"----%d",button.tag);
    if (!view) {
        if (button.tag==1007) {
            
            //货币性
            CurrencyViewController *cvc=[[CurrencyViewController alloc]init];
            cvc.delegate=self;
            cvc.fundtype=button.tag-1000;//基金类型，非常重要的，看跳到哪个页面。
            cvc.view.tag=11+button.tag-1001;
            cvc.view.frame=CGRectMake(0, 101, SCREEN_WIDTH, SCREEN_HEIGHT-101-48);
            
            [self addChildViewController:cvc];
            [self.view addSubview:cvc.view];
            [self.view bringSubviewToFront:cvc.view];
        }
        else{
            SearchCateViewController *cvc=[[SearchCateViewController alloc]init];
            cvc.delegate=self;
            cvc.fundtype=button.tag-1000;
            cvc.view.tag=11+button.tag-1001;
            cvc.view.frame=CGRectMake(0, 101, SCREEN_WIDTH, SCREEN_HEIGHT-101-48);
            
            [self addChildViewController:cvc];
            [self.view addSubview:cvc.view];
            [self.view bringSubviewToFront:cvc.view];
        }
    }
    else
        [self.view bringSubviewToFront:view];
}

-(void)searchButtonClick:(UIButton*)button
{

    HomeFundSearcViewController * _homeFund = [[HomeFundSearcViewController alloc] init];
    [APP_DELEGATE.rootNav pushViewController:_homeFund animated:YES];
}

#pragma mark------textFielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{

    NSString *serchKey = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    if (_translucentView) {
        [_translucentView removeFromSuperview];
    }
    if (![serchKey isEqualToString:@""]) {
        if (!_searchVC) {
            _searchVC=[[SearchResultViewController alloc]init];
            _searchVC.delegate=self;
        }
        _searchVC.searchWord=serchKey;
        _searchVC.view.frame=CGRectMake(0, 64, 320, self.view.bounds.size.height-64);
        [_searchVC setTableView];
        [self.view addSubview:_searchVC.view];
        [self.view bringSubviewToFront:_searchVC.view];
    }

    return YES ;
}
-(void)cancelButtonClick:(UIButton *)button
{
    [_cancelButton removeFromSuperview];
    [_textField removeFromSuperview];
    if (_translucentView) {
        [_translucentView removeFromSuperview];
    }
    if (_searchVC) {
        [_searchVC.view removeFromSuperview];
    }
    [ProgressHUD dismiss];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    if (_translucentView) {
        [_translucentView removeFromSuperview];
    }
    if (![_textField.text isEqualToString:@""]) {
        if (!_searchVC) {
            _searchVC=[[SearchResultViewController alloc]init];
            _searchVC.delegate=self;
        }
        _searchVC.searchWord=_textField.text;
        _searchVC.view.frame=CGRectMake(0, 64, 320, self.view.bounds.size.height-64);
        [_searchVC setTableView];
        [self.view addSubview:_searchVC.view];
        [self.view bringSubviewToFront:_searchVC.view];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _translucentView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height-64)];
    _translucentView.backgroundColor=[UIColor blackColor];
    _translucentView.alpha=0.3;
    [self.view addSubview:_translucentView];
    [self.view bringSubviewToFront:_translucentView];
}

//创建searchcateviewcontroller
-(void)createChildViewController
{
    SearchCateViewController *cvc=[[SearchCateViewController alloc]init];
    cvc.delegate=self;
    cvc.fundtype=1;
    cvc.view.frame=CGRectMake(0, 101, self.view.frame.size.width, self.view.frame.size.height - 100); //self.view.bounds.size.height
    cvc.view.tag=11;
    [self addChildViewController:cvc];
    [self.view addSubview:cvc.view];
} 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}

-(void)removeView
{
    [_translucentView2 removeFromSuperview];
        _view.frame=CGRectMake(0, 64, 320, 0);
        for (UIView *view in _view.subviews) {
            [view removeFromSuperview];
        }
        [_view removeFromSuperview];
}

-(void)transitonToViewController:(UIButton*)button
{
    [self removeView];
    [_downButton setTitle:titleArr[button.tag-101] forState:UIControlStateNormal];
    
//    button.tag-101
    if (button.tag>=108) {
//        _headScrollView.contentOffset=CGPointMake(6.7*60, 0);
    }
    else
//    _headScrollView.contentOffset=CGPointMake((button.tag-101)*60, 0);
    [UIView animateWithDuration:0.3 animations:^{
        _indicatorView.frame=CGRectMake((button.tag-101)*60, 33, 60, 3);
    }];
    UIView *view=[self.view viewWithTag:11+button.tag-101];
    if (!view) {
        if (button.tag==107) {
            CurrencyViewController *cvc=[[CurrencyViewController alloc]init];
            cvc.delegate=self;
            cvc.fundtype=button.tag-100;
            cvc.view.tag=11+button.tag-101;
            cvc.view.frame=CGRectMake(0, 101, self.view.frame.size.width, self.view.frame.size.height-101);
            
            [self addChildViewController:cvc];
            [self.view addSubview:cvc.view];
            [self.view bringSubviewToFront:cvc.view];
        }
        else{
            SearchCateViewController *cvc=[[SearchCateViewController alloc]init];
            cvc.delegate=self;
            cvc.fundtype=button.tag-100;
            cvc.view.tag=11+button.tag-101;
            cvc.view.frame=CGRectMake(0, 101, self.view.frame.size.width, self.view.frame.size.height-101);
            
            [self addChildViewController:cvc];
            [self.view addSubview:cvc.view];
            [self.view bringSubviewToFront:cvc.view];
        }
    }
    else
    [self.view bringSubviewToFront:view];
}

-(void)pushToViewController:(UIViewController *)viewController
{
    [APP_DELEGATE.rootNav pushViewController:viewController animated:YES];
}

-(void)sendViewController:(UIViewController *)viewController
{
    [self pushToViewController:viewController];
}

-(void)setIndexData
{
    _downloadManager=[DownloadManager sharedDownloadManager];
    HCServer *myserver = [[HCServer alloc] init]
    ;
    [myserver sendAsynchronousRequest:@"http://app.myfund.com:8484/Service/DemoService.svc/Getindex?" withBlock:^(NSData *data, NSError *connectionError) {
        
        if (!connectionError) {
            _indexArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (_indexArray.count>=2) {
                _haiTclose.text=[NSString stringWithFormat:@"%.2f",[_indexArray[0][@"Tclose"] floatValue]];
                
                if ([_indexArray[0][@"Chg"]hasPrefix:@"-"]) {
                    
                    _haiTrend.text=[NSString stringWithFormat:@"%.2f  %.2f%s",[_indexArray[0][@"Chg"] floatValue]*(-1),[_indexArray[0][@"Pchg"]floatValue]*(-1),"%"];
                    
                    [_haiTImageView setImage:[UIImage imageNamed:@"矩形-7.png"]];
                    
                    _haiTclose.textColor=[UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
                    _haiTrend.textColor=[UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
                }
                else{
                    
                    _haiTrend.text=[NSString stringWithFormat:@"%.2f  %.2f%s",[_indexArray[0][@"Chg"] floatValue],[_indexArray[0][@"Pchg"]floatValue],"%"];
                    
                    [_haiTImageView setImage:[UIImage imageNamed:@"矩形-6.png"]];
                    _haiTclose.textColor=[UIColor colorWithRed:0.90f green:0.06f blue:0.10f alpha:1.00f];
                    _haiTrend.textColor=[UIColor colorWithRed:0.90f green:0.06f blue:0.10f alpha:1.00f];
                }
                
                _zhenTclose.text=[NSString stringWithFormat:@"%.2f",[_indexArray[1][@"Tclose"] floatValue]];
                
                
                
                if ([_indexArray[1][@"Chg"]hasPrefix:@"-"]) {
                    
                    _zhenTrend.text=[NSString stringWithFormat:@"%.2f  %.2f%s",[_indexArray[1][@"Chg"] floatValue]*(-1),[_indexArray[1][@"Pchg"]floatValue]*(-1),"%"];
                    
                    [_zhenTImageView setImage:[UIImage imageNamed:@"矩形-7.png"]];
                    _zhenTclose.textColor=[UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
                    _zhenTrend.textColor=[UIColor colorWithRed:0.23f green:0.62f blue:0.22f alpha:1.00f];
                }
                else{
                    
                    _zhenTrend.text=[NSString stringWithFormat:@"%.2f  %.2f%s",[_indexArray[1][@"Chg"] floatValue],[_indexArray[1][@"Pchg"]floatValue],"%"];
                    
                    [_zhenTImageView setImage:[UIImage imageNamed:@"矩形-6.png"]];
                    _zhenTclose.textColor=[UIColor colorWithRed:0.90f green:0.06f blue:0.10f alpha:1.00f];
                    _zhenTrend.textColor=[UIColor colorWithRed:0.90f green:0.06f blue:0.10f alpha:1.00f];
                }
            }
        }
        
    }];
    
    
    
}


@end

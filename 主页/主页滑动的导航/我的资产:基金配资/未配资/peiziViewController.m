//
//  peiziViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/29.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "peiziViewController.h"

@interface peiziViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *mingxiView;

@end

@implementation peiziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize=self.mingxiView.frame.size;
    
    
    
    //4 不显示滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO; //水平滚动条
    //self.scrollView.showsVerticalScrollIndicator = NO; //垂直滚动条
    
    //5 弹簧效果
        self.scrollView.bounces = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

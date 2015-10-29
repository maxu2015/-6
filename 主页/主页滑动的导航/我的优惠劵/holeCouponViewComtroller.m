//
//  holeCouponViewComtroller.m
//  CaiLiFang
//
//  Created by 08 on 15/6/16.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "holeCouponViewComtroller.h"
#import "HoleCouponView.h"
@interface holeCouponViewComtroller ()

@end

@implementation holeCouponViewComtroller

- (void)viewDidLoad {
    [super viewDidLoad];
    HoleCouponView *hole=[[HoleCouponView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self.view addSubview:hole];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

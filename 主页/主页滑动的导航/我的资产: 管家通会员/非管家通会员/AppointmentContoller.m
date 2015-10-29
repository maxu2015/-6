//
//  AppointmentContoller.m
//  CaiLiFang
//
//  Created by 08 on 15/5/26.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "AppointmentContoller.h"
#import "HomeFourViewController.h"
@interface AppointmentContoller ()

@end

@implementation AppointmentContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addUI{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 94, 300, 44)];
    label.textColor=[UIColor blackColor];
    label.text=@"您已成功预约了管家通服务";
    [self.view addSubview:label];
    
    UILabel *huise=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 44)];
    huise.textColor=[UIColor grayColor];
    huise.lineBreakMode=NSLineBreakByWordWrapping;
    huise.numberOfLines=0;
    huise.text=@"您已进入管家通审核流程,请耐心等待,如有问题,请联系:010-62020088";
    [self.view addSubview:huise];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(5,230 , SCREEN_WIDTH-10, 50)];
    image.image=[UIImage imageNamed:@"beinaudit.png"];
    [self.view addSubview:image];
}
- (IBAction)fanhui:(UIButton *)sender {
    HomeFourViewController *hf=[[HomeFourViewController alloc]init];
    [hf ifIdcard];
    [hf IFGuanJiaTong];
    [self.navigationController popToRootViewControllerAnimated:YES];
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

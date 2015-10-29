//
//  GuShouViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/8.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "GuShouViewController.h"
#import "gushouzichan.h"
#import "UserInfomatiViewController.h"
#import "ZHUserAccount.h"
#import "MYHeadView.h"
#import "LoginViewController.h"
#import "FundLoginViewController.h"
#import "HomeFourViewController.h"
#import "GuShouViewController.h"
#import "ZiChanXianShiView.h"
#import "GuShouChanPinView.h"
@interface GuShouViewController ()
- (IBAction)FanHuiWoDe:(UIButton *)sender;

@end

@implementation GuShouViewController
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
    if (0) {
        gushouzichan *gushou=[[gushouzichan alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH , 160)];
        [self.view addSubview:gushou];
        
        [self setUI:gushou];
    }else{
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 73,SCREEN_WIDTH/2-20 , 44)];
        //button.backgroundColor=[UIColor redColor];
        [button setImage:[UIImage imageNamed:@"button_purchase_bonus.png"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5f+5, 73,SCREEN_WIDTH/2-15 , 44)];
        [button1 setImage:[UIImage imageNamed:@"button_purchase_bonus.png"] forState:UIControlStateNormal];
        //button1.backgroundColor=[UIColor redColor];
        [self.view addSubview:button1];
    }
    
//    GuShouChanPinView *cp=[[GuShouChanPinView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-224) style:UITableViewStylePlain];
//    
//    [self.view addSubview:cp];
    
}


- (void)setUI:(gushouzichan *)gushou {
    
        UILabel *totaladdincomerate=[[UILabel alloc]initWithFrame:CGRectMake(55, 55, 300, 30)];
        [totaladdincomerate setNumberOfLines:0];
        //totaladdincomerate.backgroundColor=[UIColor yellowColor];
        totaladdincomerate.textColor=[UIColor redColor];
        totaladdincomerate.text=@" 您目前还没有购买固收产品";
        [gushou addSubview:totaladdincomerate];
        
        UILabel *totalfundmarketvalue=[[UILabel alloc]initWithFrame:CGRectMake(20, 110, 250, 30)];
        [totalfundmarketvalue setNumberOfLines:0];
        //totalfundmarketvalue.backgroundColor=[UIColor redColor];
        //totalfundmarketvalue.textColor=[UIColor redColor];
        totaladdincomerate.font= [UIFont fontWithName:@"Helvetica" size:20];;
        totalfundmarketvalue.text=@"大家都在买:";
        [gushou addSubview:totalfundmarketvalue];

   
    
    
}



- (IBAction)FanHuiWoDe:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

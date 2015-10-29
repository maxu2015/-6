//
//  MakeAnAppointment.m
//  CaiLiFang
//
//  Created by 08 on 15/5/26.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "MakeAnAppointment.h"
#import "AppointmentContoller.h"
@interface MakeAnAppointment ()

@end

@implementation MakeAnAppointment

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fanhui:(UIButton *)sender {
    AppointmentContoller *appoin=[[AppointmentContoller alloc]init];
    [self.navigationController pushViewController:appoin animated:YES];
}


@end

//
//  NewsCateViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *headButton1;
@property (weak, nonatomic) IBOutlet UIButton *headButton2;
@property (weak, nonatomic) IBOutlet UIButton *headButton3;
@property (weak, nonatomic) IBOutlet UIButton *headButton4;

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
- (IBAction)button1Click:(id)sender;
- (IBAction)button2Click:(id)sender;
- (IBAction)button3Click:(id)sender;
- (IBAction)button4Click:(id)sender;


@end

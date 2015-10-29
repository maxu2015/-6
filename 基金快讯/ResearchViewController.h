//
//  ResearchViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *reserchTableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;


- (IBAction)button1Click:(id)sender;
- (IBAction)button2Click:(id)sender;
- (IBAction)button3Click:(id)sender;
- (IBAction)button4Click:(id)sender;



@end

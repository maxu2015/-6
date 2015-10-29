//
//  HomeFundSearcViewController.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/18.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeFundSearcViewController : indexFunctionViewController

- (IBAction)pressBacktBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

- (IBAction)pressSearchBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;

@property (strong, nonatomic) IBOutlet UITableView *table;


@end

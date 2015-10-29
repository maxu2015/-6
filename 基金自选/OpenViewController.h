//
//  OpenViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDetailCell.h"


@interface OpenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SearchDetailCellDelegate>
@property(nonatomic)int fundtype;

@property (weak, nonatomic) IBOutlet UIButton *leftSlideButton;

@property (weak, nonatomic) IBOutlet UIButton *rightSlideButton;

@property (strong, nonatomic) UITableView *tableViewList;

@property (strong, nonatomic) UITableView *detailTableVIewList;


-(IBAction)clickLeftSlideButton:(id)sender;
-(IBAction)clickRightSlideButton:(id)sender;

//*********************************天机***************************//
@property(nonatomic, assign) BOOL isAdd;
@end


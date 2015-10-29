//
//  searchCateCell.h
//  CaiLiFang
//
//  Created by mac on 14-8-2.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchCellModel.h"
//#import "LoginViewController.h"

@class searchCateCell ;
@protocol searchCateCellDelegate <NSObject>

-(void)searchCateCellPushViewController:(UIViewController*)viewController;
-(void)clickHeadImagewithself:(searchCateCell *)cell;
@end

@interface searchCateCell : UITableViewCell<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fundCodeLabel;
@property(nonatomic,strong)searchCellModel *model;
@property (strong, nonatomic) IBOutlet UIButton *starButton;


-(void)reloadData;

@property(nonatomic,weak)__weak id<searchCateCellDelegate>delegate;

@end

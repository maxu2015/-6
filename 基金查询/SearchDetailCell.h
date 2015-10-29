//
//  SearchDetailCell.h
//  CaiLiFang
//
//  Created by mac on 14-8-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchCellModel.h"

@protocol SearchDetailCellDelegate <NSObject>

-(void)SearchDetailCellPushViewController:(UIViewController*)viewController;
-(void)superPushOpenAccout;
@end


@interface SearchDetailCell : UITableViewCell<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;

@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;

@property (weak, nonatomic) IBOutlet UILabel *label11;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property(nonatomic,strong)searchCellModel *model;

-(void)reloadData;
@property(nonatomic,weak)__weak id<SearchDetailCellDelegate>delegate;


@end

//
//  CurrencyCell.h
//  CaiLiFang
//
//  Created by mac on 14-8-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchCellModel.h"

@protocol CurrencyCellDelegate <NSObject>

-(void)CurrencyCellPushViewController:(UIViewController*)viewController;

-(void)OpenAccount;
@end

@interface CurrencyCell : UITableViewCell<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property(nonatomic,strong)searchCellModel *model;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

-(void)reloadData;

@property(nonatomic,weak)__weak id<CurrencyCellDelegate>delegate;

@end

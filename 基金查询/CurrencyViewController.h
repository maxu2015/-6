//
//  CurrencyViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshBaseView.h"
#import "CurrencyCell.h"
#import "CustomViewController.h"
@protocol  CurrencyViewControllerDelegate<NSObject>

-(void)pushToViewController:(UIViewController*)viewController;

@end

@interface CurrencyViewController : CustomViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,CurrencyCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property(nonatomic)int fundtype;

@property(nonatomic,weak)__weak id<CurrencyViewControllerDelegate>delegate;


@property (weak, nonatomic) IBOutlet UILabel *sevenLabel;



@end

//
//  CurrencyChooseController.h
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyCell.h"
@interface CurrencyChooseController : UIViewController<UITableViewDataSource,UITableViewDelegate,CurrencyCellDelegate>

@property(nonatomic)int fundtype;

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (strong, nonatomic)UITableView *listTableView;


@end


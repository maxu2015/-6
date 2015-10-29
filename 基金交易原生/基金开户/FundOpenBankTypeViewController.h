//
//  FundOpenBankTypeViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundOpenBankTypeViewController : FundBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    

}

typedef void(^titleBlock)(NSDictionary *title);
@property(nonatomic,copy)titleBlock  myBlock ;

@property(nonatomic,strong)IBOutlet UITableView *tableView ;
@property(nonatomic,strong)NSMutableArray *tableViewArr ;

-(void)selectBankInfoBlock:(titleBlock)block;
-(IBAction)NacBack:(id)sender;
@end

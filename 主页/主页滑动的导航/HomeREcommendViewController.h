//
//  HomeREcommendViewController.h
//  CaiLiFang
//
//  Created by 展恒 on 15/7/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

//#import "indexFunctionViewController.h"
//indexFunctionViewController


#import <UIKit/UIKit.h>
#import "NetManager.h"

@interface HomeREcommendViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * table;
    NetManager * _net;
}

@property(nonatomic, strong) NSMutableArray * dataSource;



@end

//
//  QueryFundTableViewCell.h
//  CaiLiFang
//
//  Created by  展恒 on 14-12-22.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryFundTableViewCell : UITableViewCell


@property(nonatomic,strong)UILabel *daiMa ;
@property(nonatomic,strong)UILabel *mingCheng ;
@property(nonatomic,strong)UILabel *ShiZhi;
@property(nonatomic,strong)UILabel *yingKui ;
@property(nonatomic,strong)UILabel *shouYiLv;


-(void)loadData:(NSDictionary *)dic ; 
@end

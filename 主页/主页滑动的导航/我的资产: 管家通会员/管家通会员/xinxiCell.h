//
//  xinxiCell.h
//  CaiLiFang
//
//  Created by 08 on 15/5/27.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xinxiCell : UITableViewCell

@property(nonatomic,strong)UILabel *daiMa ;
@property(nonatomic,strong)UILabel *mingCheng ;
@property(nonatomic,strong)UILabel *ShiZhi;
@property(nonatomic,strong)UILabel *yingKui ;
@property(nonatomic,strong)UILabel *shouYiLv;


-(void)loadData:(NSDictionary *)dic ;
@end

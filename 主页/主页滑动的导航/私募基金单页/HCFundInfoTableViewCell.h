//
//  HCFundInfoTableViewCell.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCFundInfoTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel   *timeLB ;
@property(nonatomic,strong)UILabel   *signeLB ;
@property(nonatomic,strong)UILabel   *totalLB ;
@property(nonatomic,strong)UILabel   *rateLB  ;


-(void)reloadDic:(NSDictionary *)dic;
@end

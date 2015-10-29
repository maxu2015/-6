//
//  HCMangerTableViewCell.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCMangerTableViewCell;
@protocol HCMangerTableViewCellDelegate <NSObject>

-(void)clickEdit:(HCMangerTableViewCell *)cell;

@end


@interface HCMangerTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel   *fundNameLB;
@property(nonatomic,strong)UILabel   *jingliNameLB;
@property(nonatomic,strong)UILabel   *jingzhiTimeLB;
@property(nonatomic,strong)UILabel   *todayLB;
@property(nonatomic,strong)UILabel   *oneYearLB;
@property(nonatomic,strong)UILabel   *chengliTimeLB;
@property(nonatomic,strong)UILabel   *caozuoLB ; 
@property(nonatomic,strong)UIButton   *caozuoBTN;
@property(nonatomic,strong)NSDictionary *cellDIC;
@property(nonatomic,weak)id<HCMangerTableViewCellDelegate>delegate ; 

-(void)reloadData:(NSDictionary *)dic ; 
@end

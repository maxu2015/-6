//
//  GSHasTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSHasModel.h"
@interface GSHasTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *SName;
@property (strong, nonatomic) IBOutlet UILabel *Fnetmoney;
@property (strong, nonatomic) IBOutlet UILabel *Smodel;
@property (strong, nonatomic) IBOutlet UILabel *Startdate;
@property (strong, nonatomic) IBOutlet UILabel *DEstimateEnd;

-(void)loadDataWith:(GSHasModel *)model;

@end

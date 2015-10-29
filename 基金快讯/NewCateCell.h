//
//  NewCateCell.h
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsCateModel.h"

@interface NewCateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addDateLabel;

@property(nonatomic,strong)newsCateModel *model;

-(void)reloadData;

@end

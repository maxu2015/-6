//
//  ZHChangeBonusTableViewCell.h
//  CaiLiFang
//
//  Created by 08 on 15/3/30.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZHChangeBonusTableViewCellDelegate;
@class ZHBonusInfo;
@interface ZHChangeBonusTableViewCell : UITableViewCell
@property(nonatomic,strong)ZHBonusInfo*bonusInfo;
@property(nonatomic,weak)id<ZHChangeBonusTableViewCellDelegate>delegate;
+(instancetype)cellWithTableView:(UITableView*)tableView;
@end

@protocol ZHChangeBonusTableViewCellDelegate <NSObject>

@required
-(void)changeBonusTableViewCellDidClickOperationButton:(ZHChangeBonusTableViewCell*)cell;
@end
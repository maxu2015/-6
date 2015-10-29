//
//  ZHManagerTableViewCell.h
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZHManagerTableViewCellDelegate;
@class ZHRegularlyinvestInfo;
@interface ZHManagerTableViewCell : UITableViewCell
@property(nonatomic,strong)ZHRegularlyinvestInfo*regularlyinvestInfo;
+(instancetype)managerTableViewCellWith:(UITableView*)tableView;
@property(nonatomic,weak)id<ZHManagerTableViewCellDelegate>delegate;
@end
@protocol ZHManagerTableViewCellDelegate <NSObject>
@required
/**
 *  点击操作按钮时调用
 */
-(void)managerTableViewCellDidClickOperButton:(ZHManagerTableViewCell*)cell;

@end
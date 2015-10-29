//
//  ZHTradeQueryResultTableViewCell.h
//  基金转换
//
//  Created by 08 on 15/3/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZHTradeQueryResultTableViewCellDelegate;
@class ZHTradeQueryInfo,ZHHistoryQueryInfo;
@interface ZHTradeQueryResultTableViewCell : UITableViewCell
@property(nonatomic,strong)ZHTradeQueryInfo*tradeQueryInfo;
@property(nonatomic,strong)ZHHistoryQueryInfo*historyQueryInfo;
@property(nonatomic,weak)id<ZHTradeQueryResultTableViewCellDelegate>delegate;
+(instancetype)tradeQueryResultTableViewCellWith:(UITableView*)tableView;
@end
@protocol ZHTradeQueryResultTableViewCellDelegate <NSObject>

@required
/**
 *  点击详情按钮时调用
 *
 */
-(void)tradeQueryResultTableViewCellDidClickDetailButton:(ZHTradeQueryResultTableViewCell*)cell;

@end
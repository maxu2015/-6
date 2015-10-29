//
//  ZHFundListTableViewCell.h
//  基金转换
//
//  Created by 08 on 15/2/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZHFundListTableViewCellDelegate;
@class ZHFundInfo;
@interface ZHFundListTableViewCell : UITableViewCell
@property(nonatomic,weak)id<ZHFundListTableViewCellDelegate>delegate;
@property(nonatomic,strong)ZHFundInfo*fundInfo;
+(instancetype)fundListTableViewCellWithTableView:(UITableView*)tableView;
@end
@protocol ZHFundListTableViewCellDelegate <NSObject>

@required
/**
 *  点击转换按钮调用
 */
-(void)fundInfoCellDidClickTransformBtn:(ZHFundListTableViewCell*)fundListTableViewCell;

@end
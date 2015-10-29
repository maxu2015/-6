//
//  ZHMREcommend_CollectionViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHMREcommend_CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *headlabel;
@property (strong, nonatomic) IBOutlet UILabel *profitLabel;
@property (strong, nonatomic) IBOutlet UILabel *recommendLabel;

-(void)showDataWith:(NSDictionary *)dic;


@end

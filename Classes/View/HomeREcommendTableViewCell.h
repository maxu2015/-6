//
//  HomeREcommendTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/23.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeREcommendTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *subImage;


-(void)showdataWith:(NSDictionary *)dic;

@end

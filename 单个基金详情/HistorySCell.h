//
//  HistorySCell.h
//  CaiLiFang
//
//  Created by mac on 14-9-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistorySCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

-(void)reloadData;

@property(nonatomic,strong)NSDictionary *dataDict;

@end

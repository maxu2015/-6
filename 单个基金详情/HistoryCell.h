//
//  HistoryCell.h
//  CaiLiFang
//
//  Created by mac on 14-8-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property(nonatomic,strong)NSDictionary *dataDict;

-(void)reloadData;

@end

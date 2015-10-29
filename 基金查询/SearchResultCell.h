//
//  SearchResultCell.h
//  CaiLiFang
//
//  Created by mac on 14-8-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

@property(nonatomic,strong)NSDictionary *dataDict;

-(void)reloadData;

@end

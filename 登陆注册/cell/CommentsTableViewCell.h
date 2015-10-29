//
//  CommentsTableViewCell.h
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsCountsLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsTimeLabel;

@end

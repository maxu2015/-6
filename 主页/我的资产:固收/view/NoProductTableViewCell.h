//
//  NoProductTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPModel.h"
@interface NoProductTableViewCell : UITableViewCell




@property (strong, nonatomic) IBOutlet UILabel *sname;

@property (strong, nonatomic) IBOutlet UILabel *smodel;

@property (strong, nonatomic) IBOutlet UILabel *term;

@property (strong, nonatomic) IBOutlet UILabel *sdlowlimit;


-(void)loadDataWith:(NPModel *)model;





@end

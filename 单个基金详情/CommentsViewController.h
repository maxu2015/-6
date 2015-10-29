//
//  CommentsViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController
- (IBAction)returnBtn:(id)sender;
//传过来的基金名称和基金代码
@property(nonatomic,strong)NSString *fundCode;
@property(nonatomic,strong)NSString *fundName;
- (IBAction)addComment:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *commentsListTableView;

@end

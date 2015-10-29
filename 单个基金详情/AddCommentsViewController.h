//
//  AddCommentsViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentsViewController : UIViewController
- (IBAction)returnBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *wordsLimitLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentsDetail;
- (IBAction)enterBtn:(id)sender;

@property(nonatomic,strong)NSString *fundCode;
@property(nonatomic,strong)NSString *fundName;
@end

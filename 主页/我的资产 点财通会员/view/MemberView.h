//
//  MemberView.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/14.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberContentView.h"
@interface MemberView : UIView
@property (weak, nonatomic) IBOutlet UITableView *memberTv;

@property (weak, nonatomic) IBOutlet MemberContentView *title;
@end

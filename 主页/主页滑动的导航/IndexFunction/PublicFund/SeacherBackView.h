//
//  SeacherBackView.h
//  CaiLiFang
//
//  Created by 展恒 on 15/6/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeacherBackView : UIView
@property (weak, nonatomic) IBOutlet UITableView *seacherTV;
@property (weak, nonatomic) IBOutlet UIView *seacherHeader;
- (void)seacherViewHide;
- (void)seacherViewShow;
@end

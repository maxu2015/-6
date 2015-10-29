//
//  serveViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface serveViewController : UIViewController<UIWebViewDelegate>
- (IBAction)returnBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)NSString *urlName;
@property (nonatomic,strong)NSString *titleLabelText;
@end

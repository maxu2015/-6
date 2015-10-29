//
//  LimitProductController.h
//  CaiLiFang
//
//  Created by mac on 14-8-14.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LimitProductController : UIViewController<UIWebViewDelegate>

- (IBAction)returnButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,strong)NSString *fundTitle;

@property(nonatomic,strong)NSString *descriptionStr;

@property(nonatomic,strong)NSString *urlString;

@end

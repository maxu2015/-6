//
//  ExaminInfoViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-1-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExaminInfoViewController : UIViewController
- (IBAction)returnBtnClick:(id)sender;
- (IBAction)ShareButtonClick:(id)sender;

@property(nonatomic,strong)NSString *DetailURL;
-(id)initWithDetailURL:(NSString *)DetailURL;
@end

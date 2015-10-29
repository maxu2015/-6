//
//  WebPresentViewController.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/11.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebPresentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webLoad;

- (IBAction)preeBackNavBarBtn:(id)sender;

@property(nonatomic, retain) NSString * url;
@property (strong, nonatomic) IBOutlet UINavigationItem *barTitle;
@property (strong, nonatomic) IBOutlet UINavigationBar *customNavBar;

@property(nonatomic, strong) NSString * customTitle;

@end

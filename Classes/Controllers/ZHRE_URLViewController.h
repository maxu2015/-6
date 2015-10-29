//
//  ZHRE_URLViewController.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZHRE_URLViewController : indexFunctionViewController

- (IBAction)pressBackBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIWebView *webload;
@property (strong, nonatomic) NSString * url;


@end

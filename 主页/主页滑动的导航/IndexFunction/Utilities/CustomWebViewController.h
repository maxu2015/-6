//
//  CustomWebViewController.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indexFunctionViewController.h"
#import "IndexFuctionApi.h"
@interface CustomWebViewController : indexFunctionViewController

@property (nonatomic,copy) NSString *webURL;

- (void)createWebViewWith:(NSString*)webur;
- (void)getWebContentWith:(NSString *)url ;
- (void)createWebViewWithURL:(NSURL*)URL ;
@end

//
//  DealViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"
#import "FreeBuyViewController.h"
#import "MFLoginViewController.h"
#import "userInfo.h"
@interface DealViewController : indexFunctionViewController<UIWebViewDelegate>
- (IBAction)returnButtonClick:(id)sender;

@property(nonatomic,strong)NSString *urlString; 



@property(nonatomic,strong)BannerModel *bannerInfo;

@end

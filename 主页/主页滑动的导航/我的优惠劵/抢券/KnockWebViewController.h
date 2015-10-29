//
//  KnockWebViewController.h
//  CaiLiFang
//
//  Created by 展恒 on 15/6/17.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "CustomWebViewController.h"

@interface KnockWebViewController : CustomWebViewController
@property (nonatomic,copy) void (^getWebClick)(void);
@end

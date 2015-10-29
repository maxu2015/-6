//
//  BannerDetailViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerDetailViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)NSString *pagJudge ; 

- (IBAction)returnBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *showWebView;

@property (weak, nonatomic) IBOutlet UIView *headView;

@property(nonatomic,assign)BOOL NOclickBack ;//不让返回

@property(nonatomic,assign)BOOL presentToCom ;
//-(IBAction)clickBack:(id)sender;


//下面是基金详情的app原生控件



@end

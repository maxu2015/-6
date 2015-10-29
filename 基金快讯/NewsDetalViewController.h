//
//  NewsDetalViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface NewsDetalViewController : UIViewController
{
    AppDelegate *_appDelegate;
}
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *sourceLabel;
@property (strong, nonatomic) UIScrollView *contentScroll;
@property (strong, nonatomic) UILabel *contentLabel;

@property(nonatomic,strong)NSString *titleName;

@property(nonatomic, strong) NSString * newsId;

@property(nonatomic)int newstype;
- (IBAction)returnButtonClick:(id)sender;
- (IBAction)shareButtonClick:(id)sender;



@end

//
//  SearchResultViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SearchResultViewControllerDelegate<NSObject>

-(void)sendViewController:(UIViewController*)viewController;

@end

@interface SearchResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSString *searchWord;

@property(nonatomic,strong)NSString *urlString;

-(void)setTableView;

@property(nonatomic,weak)__weak id<SearchResultViewControllerDelegate>delegate;

@end

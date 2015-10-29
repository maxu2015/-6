//
//  SearchCateViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-2.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshBaseView.h"
#import "SearchDetailCell.h"
#import "searchCateCell.h"
#import "CustomViewController.h"

@protocol  SearchCateViewControllerDelegate<NSObject>

-(void)pushToViewController:(UIViewController*)viewController;

@end

@interface SearchCateViewController : CustomViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,SearchDetailCellDelegate,searchCateCellDelegate>

@property (strong, nonatomic) UITableView *tableViewList;
@property (strong, nonatomic) UITableView *detailTableVIewList;


@property(nonatomic)int fundtype;
@property (weak, nonatomic) IBOutlet UIButton *leftSlideButton;
@property (weak, nonatomic) IBOutlet UIButton *rightSlideButton;


-(IBAction)clickLeftSlideButton:(id)sender;
-(IBAction)clickRightSlideButton:(id)sender;
@property(nonatomic,weak)__weak id<SearchCateViewControllerDelegate>delegate;

@end

//
//  SearchScanViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-2.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCateViewController.h"
#import "CurrencyViewController.h"
#import "SearchResultViewController.h"

@interface SearchScanViewController : UIViewController<UITextFieldDelegate,SearchCateViewControllerDelegate,CurrencyViewControllerDelegate,SearchResultViewControllerDelegate>

- (IBAction)returnButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *downButton;

@property (weak, nonatomic) IBOutlet UILabel *haiTclose;

@property (weak, nonatomic) IBOutlet UILabel *haiTrend;
@property (weak, nonatomic) IBOutlet UILabel *zhenTclose;

@property (weak, nonatomic) IBOutlet UILabel *zhenTrend;

@property (weak, nonatomic) IBOutlet UIImageView *haiTImageView;

@property (weak, nonatomic) IBOutlet UIImageView *zhenTImageView;

@end




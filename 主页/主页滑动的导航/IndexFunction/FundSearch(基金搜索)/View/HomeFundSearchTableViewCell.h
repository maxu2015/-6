//
//  HomeFundSearchTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/18.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFundSearchModel.h"
@interface HomeFundSearchTableViewCell : UITableViewCell

@property(nonatomic , strong) UIViewController * superController;
@property (strong, nonatomic) IBOutlet UILabel *fundcodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *fundNameLabel;
@property(nonatomic, strong) HomeFundSearchModel * model;
@property (strong, nonatomic) IBOutlet UIButton *fundChooseBtn;

- (IBAction)pressFundChooseBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *fundType;


-(void)showDataWithdict:(HomeFundSearchModel *)model OnTable:(UITableView *)table;
@end

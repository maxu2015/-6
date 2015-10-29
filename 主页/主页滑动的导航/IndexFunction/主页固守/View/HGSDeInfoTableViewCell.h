//
//  HGSDeInfoTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPModel.h"
@interface HGSDeInfoTableViewCell :
UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *sname;




@property (strong, nonatomic) IBOutlet NSLayoutConstraint *averageConstant;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *averageConstant2;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *averagesConstant3;

@property (strong, nonatomic) IBOutlet UIView *superExcel;

@property (strong, nonatomic) IBOutlet UIImageView *redExcel;

@property (strong, nonatomic) IBOutlet UILabel *Level;

@property (strong, nonatomic) IBOutlet UILabel *saleamount;

@property (strong, nonatomic) IBOutlet UILabel *term;

@property (strong, nonatomic) IBOutlet UILabel *sdlowlimit;
@property (strong, nonatomic) IBOutlet UILabel *smodel;


@property (strong, nonatomic) IBOutlet UILabel *sspec;

@property (strong, nonatomic) IBOutlet UILabel *sdstartdate;

@property (strong, nonatomic) IBOutlet UILabel *sdoverdate;

@property (strong, nonatomic) IBOutlet UILabel *security;


@property (strong, nonatomic) IBOutlet UILabel *balaceway;



@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widtExcelConstraint;

@property(nonatomic, strong) UIViewController * superController;

-(void)loadDataWith:(NPModel *)model andLevel:(NSString *)Level;
@property(nonatomic, strong) NSString * productId;

@end

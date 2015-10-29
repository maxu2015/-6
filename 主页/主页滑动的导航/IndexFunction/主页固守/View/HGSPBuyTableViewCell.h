//
//  HGSPBuyTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "userInfo.h"
#import "NetManager.h"

@interface HGSPBuyTableViewCell : UITableViewCell<UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UITextField *IdCard;

@property (strong, nonatomic) IBOutlet UIView *nameBottomView;
@property (strong, nonatomic) IBOutlet UIView *idCardBottomView;

@property(strong, nonatomic) CustomIOS7AlertView * customView;
@property(nonatomic, strong) UserInfo * user;
@property(nonatomic, strong) NetManager * netManger;

@property(nonatomic, assign) BOOL OnLine;
@property(nonatomic, assign) BOOL Banker;

@property (strong, nonatomic) IBOutlet UITextField *fileName;

@property (strong, nonatomic) IBOutlet UILabel *phoneNumbr;


@property (strong, nonatomic) IBOutlet UILabel *productName;


@property (strong, nonatomic) IBOutlet UITextField *countBuy;


@property (strong, nonatomic) IBOutlet UITextField *recommendMan;

- (IBAction)pressOnLinePay:(id)sender;

- (IBAction)pressBankTransfer:(id)sender;

- (IBAction)pressTongYIBtn:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *onLineBtn;
@property (strong, nonatomic) IBOutlet UIButton *bankTransferBtn;
@property (strong, nonatomic) IBOutlet UIButton *tongYIBtn;
@property (strong, nonatomic) IBOutlet UIButton *contractBtn;

- (IBAction)pressContractBtn:(id)sender;

- (IBAction)pressNextBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *limitMoney;

-(void)loadDataWith:(NSDictionary *)dict;

@property(nonatomic, strong) NSString * productId;

@end

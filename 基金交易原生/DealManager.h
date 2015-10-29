//
//  DealManager.h
//  CaiLiFang
//
//  Created by 展恒 on 15/7/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum DealStations {
      openDealAccoutSuc,
    openDealAccoutFail,
    BankCardVerifySuc,
    BankCardVerifyFail,
    StationsNone
}DealStations;

typedef void(^openDealAccout)(DealStations );
typedef void(^qrySmallMoney)(DealStations );

typedef void (^SSuccessBlock) (void);
typedef void (^SFailedBlock) (void);

@interface DealManager : NSObject
@property (nonatomic,copy) openDealAccout openDealAccoutBlock;
@property (nonatomic,copy) qrySmallMoney qrySmallMoneyBlock;
@property(nonatomic, copy) SSuccessBlock succBlock;
@property(nonatomic, copy) SFailedBlock failBlock;

+(instancetype)shareManager;
- (void)getOpenAccountStatus:(NSString *)idCard status:(openDealAccout)openDealBlock; // 判断开户是否成功 根据手机号
- (void)qrySmallMoney:(qrySmallMoney)qrySmallMoneyBlock;   // 判断小额打款成功
@property(nonatomic, strong) NSString * sessionid;   //***********添加sessionid 属性值******//

-(void)getOpenAccountByIDCard:(NSString *)idCard statusCan:(SSuccessBlock)openDealBlock andFailOpen:(SFailedBlock)failedBlock;  // // 判断开户是否成功 根据身份证号


@end

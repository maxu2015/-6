//
//  FundBuyViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

//基金申购
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundBuyViewController : FundBaseViewController

@property(nonatomic,strong)NSString *isFirstBuy;//是否是第一次购买
@property(nonatomic,assign)BOOL isFirstBuyJieKou;//判断接口

@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码

@property(nonatomic,strong)NSString *fundNameSTR ;//基金名称
@property(nonatomic,strong)NSString *fundCodeSTR ;//基金代码


@property(nonatomic,strong)NSString *fundJinE    ;//基金金额
@property(nonatomic,strong)NSString *fundType    ;//基金类型
@property(nonatomic,strong)NSString *fundStates  ;//基金状态
@property(nonatomic,strong)NSString *shareType   ;//收费方式
@property(nonatomic,strong)NSString *channelid   ;//支付网点代码
@property(nonatomic,strong)NSString *fundTano    ;//Ta，必填
@property(nonatomic,strong)NSString *moneyAccount;//资金账号
@property(nonatomic,strong)NSString *isfirstbuy  ;//是否是第一次购买
@property(nonatomic,strong)NSString *gouMaiOFshenGou;//申购或者认购
@property(nonatomic,strong)NSString *minBuyMoney    ;//购买的最少值
@property(nonatomic,strong)NSString *maxBuyMoney    ;//购买的最多值



@property(nonatomic,strong)IBOutlet UISearchBar *fundCodeSB;//基金代码 输入框
@property(nonatomic,strong)NSMutableArray *fundArray ;//基金数据
@property(nonatomic,strong)NSMutableArray *queryFundArray ;//查询基金数据
@property(nonatomic,strong)IBOutlet UITableView *tableView ; 

@property(nonatomic,strong)UIView *fundDisplayV;//显示基金的view
@property(nonatomic,strong)UIView *lineV ;
@property(nonatomic,strong)UIImageView *seleImage ;
@property(nonatomic,strong)UIImageView *noDefaultSeleImage ;
@property(nonatomic,strong)UIButton *nextBtn ; 
@property(nonatomic,strong)UILabel *seleLB ;
@property(nonatomic,strong)UILabel *noDefaultSeleLB ; 
@property(nonatomic,strong)UILabel *seleFundName;//选择基金名称
@property(nonatomic,strong)UILabel *seleFundState ; //选择基金类型
@property(nonatomic,assign)BOOL isBankDaiKou ;  //是否是银行代扣

@property(nonatomic,weak)IBOutlet UIButton *searchBut ; //查询按钮


@property(nonatomic,strong)NSDictionary *fundStateDid ; //基金类型
@property(nonatomic,strong)NSDictionary *fundFengXDic ;//基金风险
@property(nonatomic,strong)NSDictionary *fundShouFDic ;//收费前后端
@property(nonatomic,copy)NSString*buyFundCode;//购买code
@property(nonatomic,assign)int    requestTag ;

@property(nonatomic, strong) NSString * firstBuymin;  // 最小申购额   修改添加============
@property(nonatomic, strong) NSString * firstBuymax;  // 最大申购额   修改添加============

-(IBAction)NacBack:(id)sender;
-(IBAction)searchFund:(id)sender;




@end

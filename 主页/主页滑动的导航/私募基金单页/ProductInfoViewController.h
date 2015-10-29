//
//  ProductInfoViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundDanYeView.h"
#import "HCFundInfoView.h"
#import "HCAccountInfo.h"

@interface ProductInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

typedef void(^PersonID)(NSString *PersonIDstr);

@property(nonatomic,copy)PersonID  myblock;

@property(nonatomic,strong)UIScrollView    *ScrollView ;
@property(nonatomic,strong)UILabel         *strategyDesc;//策略描述
@property(nonatomic,strong)FundDanYeView       *fundView ; 
@property(nonatomic,strong)HCFundInfoView      *fundInfoView;
@property(nonatomic,strong)NSString   *fundCode ; //基金代码
@property(nonatomic,strong)NSMutableArray *EquitychartArray ;
@property(nonatomic,strong)UITableView         *fundJingZhiTableView ; //历史净值

@property(nonatomic,strong)HCAccountInfo *accountView ;//账户信息view

-(id)initWithfundCode:(NSString *)fundCode;
-(void)getPersonID:(PersonID)block;
@end

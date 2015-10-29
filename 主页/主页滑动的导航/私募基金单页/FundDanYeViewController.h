//
//  FundDanYeViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCompanyViewController.h"
#import "ProductManagerViewController.h"
#import "ProductInfoViewController.h"
#import "CustomTabItemView1.h"

@interface FundDanYeViewController : UIViewController<CustomTabItemView1Delegate>

@property(nonatomic,strong)UIScrollView    *ScrollView ;
@property(nonatomic,strong)CustomTabItemView1    *customTab ; 
@property(nonatomic,strong)ProductInfoViewController      *InfomationVC  ;
@property(nonatomic,strong)ProductCompanyViewController   *companyInfoVC ;
@property(nonatomic,strong)ProductManagerViewController   *managerInfoVC ;
@property(nonatomic,strong)NSString   *fundCode ; //基金代码
@property(nonatomic,strong)NSString   *PersonID ;//没有用到

-(id)initWithfundCode:(NSString *)fundCode;
-(IBAction)navBar:(id)sender;
@end

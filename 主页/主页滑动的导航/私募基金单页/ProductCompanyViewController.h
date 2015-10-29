//
//  ProductCompanyViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyView1.h"
@interface ProductCompanyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UIScrollView    *ScrollView ;
@property(nonatomic,strong)CompanyView1    *comInfoView ;
@property(nonatomic,strong)UITableView    *productTableView;
@property(nonatomic,strong)NSArray        *tableViewArray;

@property(nonatomic,strong)NSArray       *ProductCodeArray ;
@property(nonatomic,strong)NSString       *proCode ; //产品code

//
@property(nonatomic,strong)UILabel *linianTitleLB ;
@property(nonatomic,strong)UILabel *linianContentLB ;
@property(nonatomic,strong)UILabel *renwuTitleLB;
@property(nonatomic,strong)UILabel *renwuContentLB;
@property(nonatomic,strong)UILabel *jiangxiangTitleLB;
@property(nonatomic,strong)UILabel *jingxiangContentLB ; 

-(id)initWithfundCode:(NSString *)fundCode;
@end

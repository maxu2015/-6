//
//  ProductManagerViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerView1.h"
@interface ProductManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)ManagerView1   *managerInfoView ; 

@property(nonatomic,strong)UIScrollView    *ScrollView ;
@property(nonatomic,strong)UILabel         *jingliDesLB ;
@property(nonatomic,strong)UITableView    *productTableView;
@property(nonatomic,strong)NSArray        *currentProArray;
@property(nonatomic,strong)NSArray       *ProductCodeArray ; 
@property(nonatomic,strong)NSString       *proCode ; //产品code
@property(nonatomic,strong)NSString   *PersonID ;
@property(nonatomic,strong)UILabel    *desLB1 ;
@property(nonatomic,strong)UIScrollView *proScrollView ; 
-(id)initWithfundCode:(NSString *)fundCode;
@end

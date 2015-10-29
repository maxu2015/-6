//
//  CompanyView1.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyView1 : UIView
@property(nonatomic,strong)UILabel *comNameLB ;
@property(nonatomic,strong)UILabel *placeLB ;
@property(nonatomic,strong)UILabel *mainPersonLB;
@property(nonatomic,strong)UILabel *moneyLB ;
@property(nonatomic,strong)UILabel *timeLB ;
@property(nonatomic,strong)UILabel *personNumLB ;
@property(nonatomic,strong)UILabel *fundCodeLB ;


-(void)reloadContentData:(NSArray *)dic;

@end

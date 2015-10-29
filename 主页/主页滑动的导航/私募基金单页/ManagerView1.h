//
//  ManagerView1.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerView1 : UIView

@property(nonatomic,strong)UIImageView *headImgView ; //
@property(nonatomic,strong)UILabel   *jingliName;
@property(nonatomic,strong)UILabel   *jingliName2;
@property(nonatomic,strong)UILabel   *xueliLB;
@property(nonatomic,strong)UILabel   *productNubLB;
@property(nonatomic,strong)UILabel   *schoolLB ;
@property(nonatomic,strong)UILabel   *comLB ;
@property(nonatomic,strong)UILabel   *yearLB ; 








-(void)reloadContentData:(NSArray *)mangerArr;

















@end

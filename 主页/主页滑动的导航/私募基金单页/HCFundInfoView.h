//
//  HCFundInfoView.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCFundInfoView : UIView

@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *zhangArray ;
@property(nonatomic,strong)NSMutableArray *hushengArray ;
@property(nonatomic,strong)NSMutableArray *xiangDuiArray ;



-(void)reloadTitle:(NSArray *)arra;
@end

//
//  RiskLeverEndViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-3-17.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHUserAccount;
@interface RiskLeverEndViewController : UIViewController
@property(nonatomic,strong)ZHUserAccount*userAccount;
@property(nonatomic,strong)NSDictionary *mydic ;
@property(nonatomic,strong)IBOutlet UILabel *titleLB ;
@property(nonatomic,strong)IBOutlet UILabel *contentLB ;
@property(nonatomic,strong)IBOutlet UILabel *nengLiLB ;
@property(nonatomic,strong)IBOutlet UILabel *qiDaiLB;//

-(IBAction)clickEND:(id)sender;
@end

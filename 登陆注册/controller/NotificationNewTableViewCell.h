//
//  NotificationNewTableViewCell.h
//  CaiLiFang
//
//  Created by  展恒 on 15-1-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationNewTableViewCell : UITableViewCell


@property(nonatomic,strong)UILabel *smallLB ;
@property(nonatomic,strong)UILabel *titleLB  ;
@property(nonatomic,strong)UILabel *timeLB   ;
@property(nonatomic,strong)NSString *PushKey ;
-(void)reloadData:(NSDictionary *)dic;
@end

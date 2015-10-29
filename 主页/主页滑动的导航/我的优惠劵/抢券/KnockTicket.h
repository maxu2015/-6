//
//  KnockTicket.h
//  CaiLiFang
//
//  Created by 展恒 on 15/6/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnockTicket : UIView
@property (weak, nonatomic) IBOutlet UITableView *KnockTicketTV;
@property (nonatomic,copy) void (^hadGetWebClick)(void);
@end

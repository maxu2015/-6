//
//  KnockTicketManager.h
//  CaiLiFang
//
//  Created by 展恒 on 15/6/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndexFuctionApi.h"
#import "TableViewCell.h"

typedef void(^loadBlock)(void);
typedef void(^selectTicketBlock)(NSString*);
@interface KnockTicketManager : NSObject <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)selectTicketBlock selectBlock;
+(instancetype)shareKnockTicket;
- (void)createData:(loadBlock)LoadBlock;
- (void)selectTicket:(selectTicketBlock)selectTicketBlock;
@end

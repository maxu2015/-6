//
//  KnockTicket.m
//  CaiLiFang
//
//  Created by 展恒 on 15/6/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "KnockTicket.h"
#import "KnockTicketManager.h"
#import "KnockWebViewController.h"
@implementation KnockTicket

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {

    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"KnockTicket" owner:self options:nil][0];
    }
    self.frame=frame;
    [self createTV];
    return self;
}
- (void)createTV {

    _KnockTicketTV.separatorStyle=UITableViewCellSeparatorStyleNone;
    KnockTicketManager *knockT=[KnockTicketManager shareKnockTicket];
    _KnockTicketTV.delegate=knockT;
    _KnockTicketTV.dataSource=knockT;
//    _KnockTicketTV.backgroundColor=[UIColor redColor];
    [knockT createData:^{
        
        [_KnockTicketTV reloadData];
    }];
    [knockT selectTicket:^(NSString *url) {
        KnockWebViewController *web=[[KnockWebViewController alloc]init];
        web.getWebClick=^(void){
            if (self.hadGetWebClick) {
                self.hadGetWebClick();
            }
        };
        web.webURL=url;
        [APP_DELEGATE.rootNav pushViewController:web animated:YES];
    }];

}
@end

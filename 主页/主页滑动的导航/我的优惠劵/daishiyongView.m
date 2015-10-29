//
//  daishiyongView.m
//  CaiLiFang
//
//  Created by 08 on 15/6/15.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "daishiyongView.h"
#import "HoleCoupontableView.h"
#import "NOUseCouponView.h"
#import "NetManager.h"
#import "NoHoleCouponView.h"
#import "yiyongyouhui.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"

@implementation daishiyongView
{
    NetManager *_netManager;
    NSDictionary *_infoHuiYuan;
    NSArray *_youhuijuan;
}

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    return self;

}
- (void)createData{
    [ProgressHUD show:@"加载中····"];
    _infoHuiYuan=[[UserInfo shareManager] userInfoDic];
    NSString *userName=[_infoHuiYuan objectForKey:@"UserName"];
    NSString *huiyuan=[NSString stringWithFormat:@"%d",0];
    NSString *url=[NSString stringWithFormat:IFyouhuijuan,userName,huiyuan];
    NSLog(@"-------------%@",url);
    _netManager =[NetManager shareNetManager];
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _youhuijuan=data;
        if ([_youhuijuan count]==0) {
            NOUseCouponView *hc=[[NOUseCouponView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self addSubview:hc];
            for (UIView *subviews in self.subviews){
                if ([subviews isKindOfClass:[NoHoleCouponView class]]) {
                    
                    [subviews removeFromSuperview];
                    
                }
            }

        }else{
            HoleCoupontableView *yiyong=[[HoleCoupontableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            yiyong.tableArray=_youhuijuan;
            [self addSubview:yiyong];
        }
       
        for (UIView *subviews in self.subviews){
            if ([subviews isKindOfClass:[yiyongyouhui class]]) {
                
                [subviews removeFromSuperview];
                
            }
        }
        
        [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
    } Tag:'juan'];
    
    
}

@end

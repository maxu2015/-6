//
//  HoleCouponView.m
//  CaiLiFang
//
//  Created by 08 on 15/6/11.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "HoleCouponView.h"
#import "NetManager.h"
#import "NoHoleCouponView.h"
#import "HoleCoupontableView.h"
#import "NOUseCouponView.h"
#import "yishiyongdeView.h"
#import "guoqicouponView.h"
#import "daishiyongView.h"
#import "guoqideView.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"

@interface HoleCouponView ()
@property (nonatomic,strong) daishiyongView *daishiyongV;
@property (nonatomic,strong) yishiyongdeView *yishiyongV;
@property (nonatomic,strong) guoqicouponView *guoqiV;

@end
@implementation HoleCouponView
{
    NetManager *_netManager;
    NSArray *_youhuijuan;
    NSDictionary *_infoHuiYuan;
    NSInteger _index;
}
-(daishiyongView *)daishiyongV{
    if (!_daishiyongV) {
        _daishiyongV=[[daishiyongView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _daishiyongV;
}
-(yishiyongdeView *)yishiyongV{
    if (!_yishiyongV) {
        _yishiyongV=[[yishiyongdeView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];

    }
    return _yishiyongV;
}
- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"待使用",@"已使用",@"已过期",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.backgroundColor=[UIColor whiteColor];
    segmentedControl.frame = CGRectMake(10.0, 10.0,SCREEN_WIDTH - 20, 30.0);
    segmentedControl.tintColor = [UIColor redColor];
    
    
    
    segmentedControl.selectedSegmentIndex =0;
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor redColor], NSForegroundColorAttributeName,nil];
    
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    [self addSubview:segmentedControl];
    [self createData1];
    return self;
}


- (void)doSomethingInSegment:(UISegmentedControl *)seg{
     _index=seg.selectedSegmentIndex;
    
//    if([_youhuijuan count]!=0 ) {
        switch (_index) {
                
            case 0:
            {
                _daishiyongV=[self daishiyongV];
                [self addSubview:_daishiyongV];
                [_daishiyongV createData];
                _daishiyongV.alpha=1;
                _yishiyongV.alpha=0;
            }
                break;
            case 1:{
                
                _yishiyongV=[self yishiyongV];
                [self addSubview:_yishiyongV];
                [_yishiyongV createData];
                _daishiyongV.alpha=0;
                _yishiyongV.alpha=1;
                
            }
                break;
            case 2:
            {
                guoqideView *guoqi=[[guoqideView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
                
                [guoqi createData];
                [self addSubview:guoqi];
                for (UIView *subviews in self.subviews){
                    if ([subviews isKindOfClass:[daishiyongView class]]) {
                        
                        [subviews removeFromSuperview];
                        
                    }
                }

                
            }
                break;
            default:
                break;
        }
        

//    }
        }
- (void)createData1{
    [ProgressHUD show:@"加载中····"];
    _infoHuiYuan=[[UserInfo shareManager] userInfoDic];
    if (_infoHuiYuan.count < 1) {
        return;
    }
    NSString *userName=[_infoHuiYuan objectForKey:@"UserName"];
    NSString *huiyuan=[NSString stringWithFormat:@"%ld",(long)_index];
    NSString *url=[NSString stringWithFormat:CouponsState,userName,huiyuan];
    NSLog(@"--xxxxx-----------%@",url);
    _netManager =[NetManager shareNetManager];
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _youhuijuan=data;
        NSLog(@"==-======%@",_youhuijuan);
        if ([_youhuijuan count]==0) {
            if (_index==0) {
                NoHoleCouponView *nohole=[[NoHoleCouponView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)];
                [self addSubview:nohole];
                NOUseCouponView *hc=[[NOUseCouponView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)];
                [self addSubview:hc];
                for (UIView *subviews in self.subviews){
                    if ([subviews isKindOfClass:[NoHoleCouponView class]]) {
                        
                        [subviews removeFromSuperview];
                        
                    }
                }

            }
            
            [ProgressHUD dismiss];
        }
        else{
            if (_index==0) {
                
                HoleCoupontableView *hole=[[HoleCoupontableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
                hole.tableArray=_youhuijuan;
                hole.backgroundColor=[UIColor clearColor];
                [self addSubview:hole];
                for (UIView *subviews in self.subviews){
                    if ([subviews isKindOfClass:[guoqicouponView class]]) {
                        
                        [subviews removeFromSuperview];
                        
                    }
                }

                
            }            
            
}
        [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
    } Tag:'juan'];


}

@end

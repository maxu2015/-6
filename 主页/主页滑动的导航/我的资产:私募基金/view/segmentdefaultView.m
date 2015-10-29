//
//  segmentdefaultView.m
//  CaiLiFang
//
//  Created by 08 on 15/5/13.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "segmentdefaultView.h"
#import "HoldPrivate.h"
#import "TransactionRecords.h"
#import "NoHoldPrivate.h"
#import "NoTransactionRecords.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"

@implementation segmentdefaultView
{
    NSDictionary *_gerenxinxiArray;
    NetManager *_netManager;
    NSMutableArray *_ModelArray;
}
- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    
    
    
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"持有的私募",@"交易记录",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(10.0, 10.0,300.0, 35.0);
    segmentedControl.tintColor = [UIColor redColor];
    
        
    
    segmentedControl.selectedSegmentIndex =0;
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor redColor], NSForegroundColorAttributeName,nil];
    
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:segmentedControl];
    [self ifIdcard];
    return self;
}
- (void)doSomethingInSegment:(UISegmentedControl *)seg{
    NSInteger index=seg.selectedSegmentIndex;
    if ([_ModelArray count]==0) {

        switch (index) {
            case 0:
            {
                NoHoldPrivate *Np=[[NoHoldPrivate alloc]initWithFrame:CGRectMake(0, 67,SCREEN_WIDTH , SCREEN_HEIGHT)];
                [self addSubview:Np];
                for (UIView *subviews in self.subviews){
                    if ([subviews isKindOfClass:[NoTransactionRecords class]]) {
                        [subviews removeFromSuperview];
                    }
                }
                
            }
                break;
            case 1:{
                
                
                NoTransactionRecords *ntr=[[NoTransactionRecords alloc]initWithFrame:CGRectMake(0, 67,SCREEN_WIDTH , SCREEN_HEIGHT)];
                [self addSubview:ntr];
                for (UIView *subviews in self.subviews){
                    if ([subviews isKindOfClass:[NoHoldPrivate class]]) {
                        [subviews removeFromSuperview];
                    }
                }
            }
            default:
                break;
        }
        
    }


    
else{
            switch (index) {
                case 0:
                {
                    HoldPrivate *hold=[[HoldPrivate alloc]initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [self addSubview:hold];
                    for (UIView *subviews in self.subviews){
                        if ([subviews isKindOfClass:[TransactionRecords class]]) {
                            [subviews removeFromSuperview];
                        }
                    }
    
                }
                    break;
                case 1:{
                    TransactionRecords *ttr=[[TransactionRecords alloc]initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    //
                    [self addSubview:ttr];
    
                    for (UIView *subviews in self.subviews){
                        if ([subviews isKindOfClass:[HoldPrivate class]]) {
                            [subviews removeFromSuperview];
                        }
                    }
    
                }
                    break;
                default:
                    break;
    
        }
    }

}

- (void)createData {
        [ProgressHUD show:nil];
        NSString *url=[NSString stringWithFormat:@"%@%@",GetPrivateproductsList,[_gerenxinxiArray objectForKey:@"IDCard"]];
        _netManager =[NetManager shareNetManager];
        [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
            _ModelArray=[NSMutableArray arrayWithArray:data];
            if ([_ModelArray count]==0) {
                    NoHoldPrivate *ntr=[[NoHoldPrivate alloc]initWithFrame:CGRectMake(0, 67,SCREEN_WIDTH , SCREEN_HEIGHT)];
                [self addSubview:ntr];
                for (UIView *subviews in self.subviews){
                    if ([subviews isKindOfClass:[NoTransactionRecords class]]) {
                        
                        [subviews removeFromSuperview];
                        
                    }
                }

            }
            else{
                HoldPrivate *hold=[[HoldPrivate alloc]initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, SCREEN_HEIGHT)];
                [self addSubview:hold];
                
                for (UIView *subviews in self.subviews){
                    if ([subviews isKindOfClass:[TransactionRecords class]]) {
                        
                        [subviews removeFromSuperview];
                        
                    }
                }

                
            }
            
            [ProgressHUD dismiss];
        } fail:^(id errorMsg, NSInteger tag) {
            [ProgressHUD dismiss];
        } Tag:'cell'];
}



- (void)ifIdcard{
    
    _gerenxinxiArray=[[UserInfo shareManager] userInfoDic];
    
    
    
    if (_gerenxinxiArray.count>0) {
        NSString *IDCard = [_gerenxinxiArray objectForKey:@"IDCard"];
        if (IDCard&&IDCard.length==18) {
            //18为身份证
            [self createData];
        }
        else{
            
            
        }
    }
}

@end

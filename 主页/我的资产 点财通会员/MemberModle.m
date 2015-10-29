//
//  MemberModle.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/14.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MemberModle.h"
#import "NSData+replaceReturn.h"
static MemberModle *_intance;

@implementation MemberModle

+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[MemberModle alloc]init];
            
        }
    });
    return _intance;
}
- (void)getRequestWith:(NSString *)url tag:(NSInteger)tag {
    NetManager *net=[NetManager shareNetManager];
    [net dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSData *u8data=(NSData *)data;
        switch (tag) {
            case 'info': {
                _loadOver=@"yes";
            _memberInfoDic= [NSData baseItemWith:u8data];
            
            }
                break;
                
            default:
                break;
        }
        
       
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:tag];

}
@end

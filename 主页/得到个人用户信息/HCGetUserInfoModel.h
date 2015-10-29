//
//  HCGetUserInfoModel.h
//  CaiLiFang
//
//  Created by  展恒 on 15-5-15.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCGetUserInfoModel : NSObject


+(id)returnUserInfo;
-(void)returnUserInfo:(void(^)(id data))userData;
+(void)clearUSERNICKNAME;
@end

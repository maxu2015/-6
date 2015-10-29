//
//  ZHRegularlyinvestInfo.m
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHRegularlyinvestInfo.h"

@implementation ZHRegularlyinvestInfo
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
/**
 *  首次扣款日期
 */
-(NSString *)firstinvestdate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [formatter dateFromString:_firstinvestdate];
    formatter.dateFormat = @"yyyy年MM月dd日";
    return [formatter stringFromDate:date];
}
/**
 *  定投状态
 */
#pragma mark -debug
-(NSString *)status
{
    NSDictionary*dict = @{@"X":@"未知",@"W":@"待确认",@"N":@"正常",@"P":@"暂停",@"D":@"系统作废",@"C":@"终止"};
    return dict[_status];
}
/**
 *  后续投资方式
 */
-(NSString *)investmode
{
    NSString*str;
    switch ([_investmode integerValue]) {
        case 0:
            str = @"按余额比例扣款";
            break;
        case 1:
            str = @"按递增金额扣款";
            break;
        case 2:
            str = @"按后续投资金额不变";
            break;
        default:
            str = @"--";
            break;
    }
    return str;
}
-(NSArray *)arrayFromModel
{
    NSArray*arr = @[@[@"协议号：",self.buyplanno],@[@"基金名称：",[NSString stringWithFormat:@"[%@]%@",self.fundcode,self.fundname]],@[@"业务类别：",@"定期投资终止"],@[@"扣款银行：",self.channelname],@[@"首次扣款日期：",self.firstinvestdate],@[@"首次扣款金额：",self.firstinvestamount],@[@"后续投资方式：",self.investmode]];
    
    return arr;
}
-(NSArray *)arrayFromModelWithAppno
{
    NSArray*arr = @[@[@"申请单号：",self.appsheetserialno],@[@"协议号：",self.buyplanno],@[@"基金名称：",[NSString stringWithFormat:@"[%@]%@",self.fundcode,self.fundname]],@[@"业务类别：",@"定期投资终止"],@[@"扣款银行：",self.channelname],@[@"首次扣款日期：",self.firstinvestdate],@[@"首次扣款金额：",self.firstinvestamount],@[@"后续投资方式：",self.investmode]];
    
    return arr;
}
@end

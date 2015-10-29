//
//  ZHHistoryQueryInfo.m
//  基金转换
//
//  Created by 08 on 15/3/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHHistoryQueryInfo.h"
#import "NSString+numberSeparator.h"

@implementation ZHHistoryQueryInfo
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
-(NSArray*)historyArrayFromModel
{   NSString *fene=[NSString stringWithFormat:@"%@份",self.confirmedvol];
    NSString *yuan=[NSString stringWithFormat:@"%@元",self.confirmedamount];
    NSArray*arr = @[@[@"原申请单编号：",self.appsheetserialno],@[@"基金账号：",self.taaccountid],@[@"支付渠道：",self.paycenterid],@[@"申请金额：",self.applicationamount],@[@"确认份额：",fene],@[@"手续费：",self.charge],@[@"确认日期：",self.transactioncfmdate],@[@"默认分红方式：",self.defdividendmethod],@[@"TA确认流水号：",self.taserialno],@[@"基金名称：",[NSString stringWithFormat:@"[%@]%@",_fundcode,_fundname]],@[@"业务类别：",self.businesscode],@[@"申请份额：",self.applicationvol],@[@"确认金额：",yuan],@[@"份额净值：",self.nav],@[@"确认信息：",self.returnmsg],@[@"目标基金名称：",self.targetfundname]/*,@[@"处理状态：",@""],@[@"处理状态说明：",@""],@[@"银行卡号：",@""]*/];
    
    return arr;
}
/**
 *  确认信息
 *
 */
-(NSString *)returnmsg
{
    if ([_returnmsg rangeOfString:@"0000"].length !=0) {
        return @"成功";
    }
    return _returnmsg;
}
/**
 *  单号
 */
-(NSString *)appsheetserialno
{
    //    NSLog(@"%ld",_appsheetserialno.length);
    if (_appsheetserialno.length == 0) {
        return @"--";
    } else {
        return _appsheetserialno;
    }
}
/**
 *  目标基金名称
 */
-(NSString *)targetfundname
{
    if (_targetfundname == nil) {
        return @"--";
    } else {
        return [NSString stringWithFormat:@"[%@]%@",_targetfundcode,_targetfundname];
    }
}
/**
 *  确认金额
 */
-(NSString *)confirmedamount
{
    if ([_confirmedamount floatValue]==0) {
        return @"--";
    } else {
        
        return [NSString stringHasNumberSeparatorWithFloatString:_confirmedamount];
    }
}
/**
 *  交易确认日期
 */
-(NSString *)transactioncfmdate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [formatter dateFromString:_transactioncfmdate];
    formatter.dateFormat = @"yyyy年MM月dd日";
    return [formatter stringFromDate:date];
}
/**
 *  业务类型
 */
-(NSString *)businesscode
{
    NSString*str;
    switch ([_businesscode integerValue]) {
        case 20:
            str = @"认购";
            break;
        case 22:
            str = @"申购";
            break;
        case 24:
            str = @"赎回";
            break;
        case 26:
            str = @"转托管申请";
            break;
        case 27:
            str = @"转托管转入";
            break;
        case 28:
            str = @"转托管转出";
            break;
        case 29:
            str = @"设置分红";
            break;
        case 30:
            str = @"认购结果";
            break;
        case 31:
            str = @"基金份额冻结";
            break;
        case 32:
            str = @"基金份额解冻";
            break;
        case 33:
            str = @"非交易过户";
            break;
        case 34:
            str = @"非交易过户转入";
            break;
        case 35:
            str = @"非交易过户转出";
            break;
        case 36:
            str = @"基金转换";
            break;
        case 37:
            str = @"基金转换入";
            break;
        case 38:
            str = @"基金转换出";
            break;
        case 39:
            str = @"定投";
            break;
        case 42:
            str = @"强制赎回";
            break;
        case 43:
            str = @"分红";
            break;
        case 44:
            str = @"强行调增";
            break;
        case 45:
            str = @"强行调减";
            break;
        case 49:
            str = @"基金募集失败";
            break;
        case 50:
            str = @"基金清盘";
            break;
        case 59:
            str = @"定投开通";
            break;
        case 60:
            str = @"定投撤销";
            break;
        case 61:
            str = @"定投协议变更";
            break;
        case 98:
            str = @"快速赎回T+0";
            break;
        default:
            str = @"其他";
            break;
    }
    return str;
}
/**
 *  确认金额
 */
-(NSString *)confirmedvol
{
    if ([_confirmedvol floatValue]== 0) {
        return @"--";
    } else {
    
        return [NSString stringHasNumberSeparatorWithFloatString:_confirmedvol];
    }
}
/**
 *  基金账号
 */
-(NSString *)taaccountid
{
    //    NSLog(@"%ld",_taaccountid.length);
    if ([_taaccountid isEqualToString:@"            "]) {
        return @"--";
    } else {
        return _taaccountid;
    }
}
/**
 *  默认分红方式
 */
-(NSString *)defdividendmethod
{
    NSString*str;
    if (_defdividendmethod.length ==0) {
        return @"--";
    } else {
        switch ([_defdividendmethod integerValue]) {
            case 0:
                str = @"红利再投";
                break;
            case 1:
                str = @"现金分红";
                break;
                /*
                 case 2:
                 str = @"利得现金增值再投资";
                 break;
                 case 3:
                 str = @"增值现金利得再投资";
                 break;
                 case 4:
                 str = @"部分再投资";
                 break;
                 case 5:
                 str = @"赠送";
                 break;
                 */
            default:
                str = @"--";
                break;
        }
        return str;
    }
}
/**
 *  支付渠道
 */
-(NSString *)paycenterid
{
    NSString*str;
    switch ([_paycenterid integerValue]) {
        case 10:
            str = @"银联";
            break;
        case 108:
            str = @"民生";
            break;
        case 204:
            str = @"易宝支付";
            break;
        case 302:
            str = @"通联";
            break;
        case 2000:
            str = @"汇款支付";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@渠道",str];
}
/**
 *  申请份额
 */
-(NSString *)applicationvol
{
    if ([_applicationvol floatValue]==0) {
        return @"--";
    } else {
        return [NSString stringHasNumberSeparatorWithFloatString:_applicationamount];
    }
}
/**
 *  申请金额
 */
-(NSString *)applicationamount
{
    if ([_applicationamount floatValue]==0) {
        return @"--";
    } else {
        return [NSString stringHasNumberSeparatorWithFloatString:_applicationamount];
    }
}

@end

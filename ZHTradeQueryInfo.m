//
//  ZHTradeQueryInfo.m
//  基金转换
//
//  Created by 08 on 15/3/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTradeQueryInfo.h"

@implementation ZHTradeQueryInfo
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
-(NSArray *)tradeArrayFromModel
{
    NSArray*arr = @[@[@"申请单编号：",self.appsheetserialno],@[@"业务名称：",self.businesscode],@[@"基金账号：",self.taaccountid],@[@"基金名称：",[NSString stringWithFormat:@"[%@]%@",self.fundcode,self.fundname]],@[@"申请金额：",self.applicationamount],@[@"申请份额：",self.applicationvol],@[@"支付渠道：",self.paycenterid],@[@"支付方式：",self.paytype],@[@"下单日期：",self.operdate],@[@"下单时间：",self.opertime],@[@"申请日期：",self.transactiondate],@[@"分红方式：",self.defdividendmethod],@[@"原申请单编号：",self.originalappsheetno],@[@"协议号：",self.protocolno],@[@"目标基金名称:",self.targetfundname],@[@"支付状态：",self.paystatus],@[@"处理状态：",self.status],@[@"处理状态说明:",@"--"],@[@"银行卡号：",self.depositacct]];
    
    
    
    return arr;
}
-(NSString *)targetfundname
{
    //    NSLog(@"%@,%ld",_targetfundname,_targetfundname.length);
    if (_targetfundname==nil) {
        return @"--";
    } else {
        return [NSString stringWithFormat:@"[%@]%@",_targetfundcode,_targetfundname];
    }
}
-(NSString *)taaccountid
{
    //    NSLog(@"%ld",_taaccountid.length);
    if ([_taaccountid isEqualToString:@"            "]) {
        return @"--";
    } else {
        return _taaccountid;
    }
}
-(NSString *)paystatus
{
    NSString*str;
    switch ([_paystatus integerValue]) {
        case 0:
            str = @"未支付";
            break;
        case 1:
            str = @"委托正在处理";
            break;
        case 2:
            str = @"支付成功";
            break;
        case 3:
            str = @"支付失败";
            break;
        case 7:
            str = @"托收成功";
            break;
        default:
            str = @"--";
            break;
    }
    return str;
}
-(NSString *)operdate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [formatter dateFromString:_operdate];
    formatter.dateFormat = @"yyyy年MM月dd日";
    return [formatter stringFromDate:date];
}
-(NSString *)transactiondate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [formatter dateFromString:_transactiondate];
    formatter.dateFormat = @"yyyy年MM月dd日";
    return [formatter stringFromDate:date];
}
-(NSString *)originalappsheetno
{
    if ([_originalappsheetno isEqualToString:@" "]) {
        return @"--";
    } else {
        return _originalappsheetno;
    }
}
-(NSString *)protocolno
{
    //    NSLog(@"%@",_protocolno);
    if ([_protocolno isEqualToString:@" "]) {
        return @"--";
    } else {
        return _protocolno;
    }
}
-(NSString *)defdividendmethod
{
    NSString*str;
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
-(NSString *)depositacct
{
    if (_depositacct==nil) {
        return @"--";
    } else {
        if (_depositacct.length < 16) {
            return [_depositacct stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"***"];;
        } else {
            return [_depositacct stringByReplacingCharactersInRange:NSMakeRange(13, 3) withString:@"***"];
        }
    }
}
-(NSString *)paytype
{
    NSInteger type = [_paytype integerValue];
    switch (type) {
        case 1:
            return @"银行转账";
            break;
        case 2:
            return @"银行汇款";
            break;
        default:
            return @"--";
            break;
    }
}
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
-(NSString *)status
{
    NSString*str;
    switch ([_status integerValue]) {
        case 0:
            str = @"带复核";
            break;
        case 1:
            str = @"待勾兑";
            break;
        case 2:
            str = @"待确认";
            break;
        case 4:
            str = @"废单";
            break;
        case 5:
            str = @"已撤";
            break;
        case 6:
            str = @"已报";
            break;
        case 7:
            str = @"已确认";
            break;
        case 8:
            str = @"已结束";
            break;
        default:
            break;
    }
    return str;
}
-(NSString *)applicationvol
{
    if ([_applicationvol floatValue]==0) {
        return @"--";
    } else {
        return _applicationvol;
    }
}
-(NSString *)applicationamount
{
    if ([_applicationamount floatValue]==0) {
        return @"--";
    } else {
        return _applicationamount;
    }
}
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
        case 29:
            str = @"设置分红方式";
            break;
        case 36:
            str = @"基金转换";
            break;
        case 39:
            str = @"定投";
            break;
        case 59:
            str = @"定投开通";
            break;
        case 60:
            str = @"定投撤销";
            break;
        default:
            str = @"其他";
            break;
    }
    return str;
}
@end

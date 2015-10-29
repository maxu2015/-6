//
//  ZHTransformPageView.m
//  基金转换
//
//  Created by 08 on 15/2/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTransformPageView.h"
#import "ZHFundInfo.h"
#import "ZHTransformInfo.h"
#import "AFNetworking.h"
#import "NSData+replaceReturn.h"
#import "NSString+numberSeparator.h"
#import "MBProgressHUD+NJ.h"
#import "NSString+digitUppercase.h"
#import "ZHFundMinNum.h"
#import "ZHUserAccount.h"
#import "CustomPassWord.h"
#import "EncryptManager.h"

@interface ZHTransformPageView ()
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *holdFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *frozenFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableFundLabel;
@property (weak, nonatomic) IBOutlet UIButton *fundSelectbtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

- (IBAction)selectFundClick:(UIButton*)sender;
@property (weak, nonatomic) IBOutlet UILabel *fundTransformRangeLabel;
- (IBAction)confirmClick;



@end
@implementation ZHTransformPageView

-(void)setFundInfo:(ZHFundInfo *)fundInfo
{
    _fundInfo = fundInfo;
    self.fundNameLabel.text = [NSString stringWithFormat:@"[%@]%@",fundInfo.fundcode,fundInfo.fundname];
    self.holdFundLabel.text = [NSString stringHasNumberSeparatorWithFloatString: fundInfo.fundvolbalance];
    self.frozenFundLabel.text = [NSString stringHasNumberSeparatorWithFloatString: fundInfo.confirmfrozen];
    self.availableFundLabel.text = [NSString stringHasNumberSeparatorWithFloatString: fundInfo.availablevol];
    //设置默认转换份额
    self.transformNumField.text = self.fundInfo.availablevol;
    self.chinsesNumLabel.text = [NSString stringWithFormat:@"%@(份)",[NSString stringDigitUppercaseNumberWith:self.fundInfo.availablevol]];
}
- (IBAction)selectFundClick:(UIButton*)sender {
    if ([self.delegate respondsToSelector:@selector(transformPageView:DidSelectClick:)]) {
        [self.delegate transformPageView:self DidSelectClick:sender];
    }
}
-(void)requestData;
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sessionId = [defaults objectForKey:@"sessionid"];
  //  NSString*str = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getFundTotalInfo?id=%@&passwd=%@&condition=%@",ZHServerAddress,self.userAccount.userName,self.userAccount.password,self.fundInfo.fundcode];
  
    NSString * newStr = [NSString stringWithFormat:BUYFUYNDNEW,apptrade8000 ,sessionId, self.fundInfo.fundcode, @"10",0];
    NSLog(@"%@",self.userAccount.userName);
//    NSDictionary*para = @{@"passwd":self.userAccount.password};
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:newStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        NSArray*arr = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        if (arr.count==0) {
            return ;
        }
        ZHFundMinNum*minNum = [[ZHFundMinNum alloc]initWithDictionary:arr[0] error:NULL];
        NSLog(@"////???=%@", arr);
        minNum.max = self.fundInfo.availablevol;
        NSString*max = minNum.max;
        NSString*min = minNum.per_min_36;

        if ([max floatValue]>[min floatValue]) {
            self.fundTransformRangeLabel.text = [NSString stringWithFormat:@"本基金转换范围：%@份 ~ %@份",min,max];
        } else {
            self.fundTransformRangeLabel.text = [NSString stringWithFormat:@"本基金转换范围：最小%@份",min];
        }
        self.min = min;
        self.max = max;
        
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
    }];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self requestData];

    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 5.0;
}
- (IBAction)confirmClick {
    if ([self.fundSelectbtn.titleLabel.text isEqualToString:@"基金"]||[self.fundSelectbtn.titleLabel.text isEqualToString:@"无可转换基金"]) {
        [MBProgressHUD showError:@"未选择转换基金！"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(transformPageView:DidConfirmClick:)]) {
        // 实现代理方法
        [self.delegate transformPageView:self DidConfirmClick:nil];
    }
}

-(ZHTransformInfo *)transformInfo
{
    ZHTransformInfo*info = [[ZHTransformInfo alloc]init];
    info.fundcode = self.fundInfo.fundcode;
    info.applicationamount = self.transformNumField.text;
    info.tano=self.fundInfo.tano;
    info.targetfundcode = self.targetfundcode;
    info.targetFundName = self.selectedFund.titleLabel.text;
    info.fundName = self.fundNameLabel.text;
    return info;
}
-(void)dealloc
{
//    NSLog(@"销毁");
}
@end

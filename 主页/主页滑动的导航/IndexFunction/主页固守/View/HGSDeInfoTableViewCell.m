//
//  HGSDeInfoTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HGSDeInfoTableViewCell.h"
#import "HGSProductBuyViewController.h"
#import "userInfo.h"
#import "MFLoginViewController.h"
#import "WebPresentViewController.h"
#import "IndexFuctionApi.h"
@implementation HGSDeInfoTableViewCell
{
    NSString * QustionUrl;  // 问题
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)loadDataWith:(NPModel *)model andLevel:(NSString *)Level
{
    float percent = [Level floatValue] / [model.saleamount floatValue];
    float width = percent * 278;
    if (width > 278) {
        width = 278;
    }
    self.widtExcelConstraint.constant = width;
    
    
    self.Level.text = [NSString stringWithFormat:@"%@%@ (%1.f%@)", Level, @"万", percent*100, @"%"];
    self.sspec.text = model.sspec;
    self.term.text = [NSString stringWithFormat:@"%@%@", model.term, @"天"];
    self.sdlowlimit.text = [NSString stringWithFormat:@"%@%@", model.sdlowlimit, @"万"];
    self.smodel.text = model.smodel;
    self.sname.text = model.sname;
    
    self.security.text = model.security;
    self.balaceway.text = model.balaceway;
    NSArray * stardate = [model.sdstartdate componentsSeparatedByString:@" "];
    self.sdstartdate.text = stardate[0];
    NSArray * sdoverDate = [model.sdoverdate componentsSeparatedByString:@" "];
    self.sdoverdate.text = sdoverDate[0];
    self.saleamount.text = [NSString stringWithFormat:@"%@%@", model.saleamount, @"万"];
    self.productId = model.Id;
    
    float distance = (SCREEN_WIDTH - (59 * 4)) / 5;
    self.averageConstant.constant = distance;
    self.averageConstant2.constant = distance;
    self.averagesConstant3.constant = distance;
}

- (IBAction)pressCommentQustion:(id)sender {
    [self judgeProduct];
    WebPresentViewController * web = [[WebPresentViewController alloc] init];
    web.customTitle = @"常见问题";
    web.url = QustionUrl;
    [APP_DELEGATE.rootNav presentViewController:web animated:YES completion:^{
        
    }];
}

-(void)judgeProduct
{
    
    NSRange hengdeli = [self.sname.text rangeOfString:@"恒得利"];
    NSRange hengyoucai = [self.sname.text rangeOfString:@"恒有财"];
    if (hengdeli.location != NSNotFound && hengyoucai.location == NSNotFound) {

        QustionUrl = HENGDELI_qustion;
    }
    else if (hengyoucai.location != NSNotFound && hengdeli.location == NSNotFound){
        
        QustionUrl = HENGYOUCAI_qustion;
    }
    
}

- (IBAction)pressInventMoney:(id)sender {
    
    if ([UserInfo isLogin]) {
        HGSProductBuyViewController * product = [[HGSProductBuyViewController alloc] init];
        
        product.limitMoney = self.sdlowlimit.text;
        product.productName = self.sname.text;
        product.productId = self.productId;
        [APP_DELEGATE.rootNav pushViewController:product  animated:YES];
    }
    else{
        MFLoginViewController *login=[[MFLoginViewController alloc]init];
        [APP_DELEGATE.rootNav pushViewController:login animated:YES];
        [login loginSucceed:^(NSString *str) {
            [login.navigationController popViewControllerAnimated:YES];
        }];
    }
 
}

@end

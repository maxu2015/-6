//
//  FundBuyTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/27.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "FundBuyTableViewCell.h"
@implementation FundBuyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//0交易，1发行，2发行成功，3发行失败，4基金停止交易，5停止申购，6停止赎回，7权益登记，8红利发放，9基金封闭，a基金终止
-(void)showdataWithdic:(NSDictionary *)dic
{
    NSDictionary * fundtypeDic = @{@"0":@"股票型", @"1":@"债券型", @"2":@"货币型",
                                   @"3":@"混合型", @"4":@"专户基金", @"5":@"指数型", @"6":@"QDII型"};
    NSDictionary * stastusDic = @{@"0":@"交易", @"1":@"发行", @"2":@"发行成功", @"3":@"发行失败",
                                  @"4":@"停止交易", @"5":@"停止申购", @"6":@"停止赎回",
                                  @"7":@"权益登记", @"8": @"红利发放", @"9":@"基金封闭",
                                  @"a": @"基金终止"};
    self.codeName.text = [dic objectForKey:@"fundname"];
    self.codeNet.text = [dic objectForKey:@"nav"];   // 基金净值
    self.codeType.text = [fundtypeDic objectForKey:[dic objectForKey:@"fundtype"]];
    self.codeNum.text = [dic objectForKey:@"fundcode"];
    NSString * status = [dic objectForKey:@"status"];
    if ([status isEqualToString:@"0"]) {
        [self.makeBtn setBackgroundImage:[UIImage imageNamed:@"购买.png"] forState:UIControlStateNormal];
    }
    else{
        self.makeBtn.backgroundColor = [UIColor lightGrayColor];
        self.makeBtn.layer.cornerRadius = 4;
        [self.makeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.makeBtn setTitle:[stastusDic objectForKey:status] forState:UIControlStateNormal];
        self.makeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    }
}






@end

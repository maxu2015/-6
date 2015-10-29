//
//  ZHTradeQueryResultTableViewCell.m
//  基金转换
//
//  Created by 08 on 15/3/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTradeQueryResultTableViewCell.h"
#import "ZHTradeQueryInfo.h"
#import "ZHHistoryQueryInfo.h"
@interface ZHTradeQueryResultTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *fundCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fundNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@end
@implementation ZHTradeQueryResultTableViewCell
- (IBAction)tradeClick {
    if ([self.delegate respondsToSelector:@selector(tradeQueryResultTableViewCellDidClickDetailButton:)]) {
        [self.delegate tradeQueryResultTableViewCellDidClickDetailButton:self];
    }
}
+(instancetype)tradeQueryResultTableViewCellWith:(UITableView *)tableView
{
    NSString*reuseID = @"tradeResult";
    ZHTradeQueryResultTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHTradeQueryResultTableViewCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailBtn.layer.masksToBounds = YES;
    cell.detailBtn.layer.cornerRadius = 5.0;
    return cell;
}
-(void)setTradeQueryInfo:(ZHTradeQueryInfo *)tradeQueryInfo
{
    _tradeQueryInfo = tradeQueryInfo;
    self.fundCodeLabel.text =[NSString stringWithFormat:@"[%@]%@",tradeQueryInfo.fundcode,tradeQueryInfo.fundname] ;

    self.typeLabel.text = tradeQueryInfo.businesscode;
    self.fundNumberLabel.text = tradeQueryInfo.applicationamount;
}
-(void)setHistoryQueryInfo:(ZHHistoryQueryInfo *)historyQueryInfo
{
    _historyQueryInfo = historyQueryInfo;
    self.fundCodeLabel.text =  [NSString stringWithFormat:@"[%@]%@",historyQueryInfo.fundcode,historyQueryInfo.fundname] ;
//    NSLog(@"%@",historyQueryInfo.fundname);
//    self.fundNameLabel.text = historyQueryInfo.fundname;
    self.fundNumberLabel.text = historyQueryInfo.confirmedamount;
    self.typeLabel.text = historyQueryInfo.businesscode;
}
@end

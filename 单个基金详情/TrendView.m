//
//  TrendView.m
//  CaiLiFang
//
//  Created by mac on 14-8-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TrendView.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"

@implementation TrendView
{
    NSMutableArray *_buttonArray;
    LineChartView *_chartView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dateArray=[[NSMutableArray alloc]init];
        _fundArray=[[NSMutableArray alloc]init];
        _contrastArray=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)createTrendGraph
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20+i*80, 5, 10, 10)];
        if (i==0) {
            if (_contrastArray.count>0){
                label.backgroundColor=[UIColor blueColor];
            }
        }
        if (i==1) {
            label.backgroundColor=[UIColor colorWithRed:0.89f green:0.05f blue:0.00f alpha:1.00f];
        }
        [self addSubview:label];
    }
    
    for (int i=0;i<2;i++) {
        UILabel *dataLabel=[[UILabel alloc]initWithFrame:CGRectMake(35+i*80, 5, 70, 10)];
        dataLabel.font=[UIFont systemFontOfSize:10];
        if (i==0) {
            if (_contrastArray.count>0) {
                dataLabel.text=[NSString stringWithFormat:@"上证涨跌"];
                if (_labelType==11) {
                   dataLabel.text=_contrastTitle;
                }
            }
        }
        if (i==1) {
            dataLabel.text=[NSString stringWithFormat:@"本基金"];
            if (_labelType==11) {
                dataLabel.text=_selfTitle;
            }
        }
        [self addSubview:dataLabel];
    }
    
    _chartView= [[LineChartView alloc] initWithFrame:CGRectMake(-5,20,self.bounds.size.width, self.bounds.size.height-20)];
    
    NSMutableArray *array1=[[NSMutableArray alloc]initWithArray:_fundArray];
    
    [array1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    LineChartData *d1x = [LineChartData new];
    {
        LineChartData *d1 = d1x;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"y-M-d"];
        NSDate *date1=[formatter dateFromString:_dateArray[0]];
        NSDate *date2=[formatter dateFromString:_dateArray[_dateArray.count-1]];

        d1.xMin = [date1 timeIntervalSinceReferenceDate];
        d1.xMax = [date2 timeIntervalSinceReferenceDate];
        
        d1.title = @"";
        d1.color = [UIColor redColor];
        d1.itemCount = _dateArray.count;
        
        d1.getData = ^(NSUInteger item) {
            float x = [[formatter dateFromString:_dateArray[item]]timeIntervalSinceReferenceDate];
            float y = [_fundArray[item] floatValue];
            
            NSString *label1=_dateArray[item];
            NSString *label2;
            if (_isMoneyFund==NO&&_labelType==1) {
                label2=[NSString stringWithFormat:@"单位净值:%.3f",[_fundArray[item]floatValue]];
            }
            if (_isMoneyFund==NO&&_labelType==2) {
                label2=[NSString stringWithFormat:@"累计收益:%.3f%s",[_fundArray[item]floatValue],"%"];
            }
            if (_isMoneyFund==YES&&_labelType==1) {
                label2=[NSString stringWithFormat:@"万分收益:%.3f",[_fundArray[item]floatValue]];
            }
            if (_isMoneyFund==YES&&_labelType==2) {
                label2=[NSString stringWithFormat:@"七日年化:%.3f%s",[_fundArray[item]floatValue],"%"];
            }
            if (_labelType==11) {
                label2=[NSString stringWithFormat:@"%@%s%.3f%s",_selfTitle,":",[_fundArray[item]floatValue],"%"];
            }
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
    }
    
    if (_contrastArray.count>0) {
        LineChartData *d2x = [LineChartData new];
        {
            LineChartData *d1 = d2x;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"y-M-d"];
            NSDate *date1=[formatter dateFromString:_dateArray[0]];
            NSDate *date2=[formatter dateFromString:_dateArray[_dateArray.count-1]];
            d1.xMin = [date1 timeIntervalSinceReferenceDate];
            d1.xMax = [date2 timeIntervalSinceReferenceDate];
            d1.title = @"";
            d1.color = [UIColor blueColor];
            d1.itemCount = _dateArray.count;
            
            d1.getData = ^(NSUInteger item) {
                float x = [[formatter dateFromString:_dateArray[item]]timeIntervalSinceReferenceDate];
                float y = [_contrastArray[item] floatValue];
                
                NSString *label1=_dateArray[item];
                NSString *label2=[NSString stringWithFormat:@"上证涨跌:%.3f%s",[_contrastArray[item]floatValue],"%"];
                
                if (_labelType==11) {
                    label2=[NSString stringWithFormat:@"%@%s%.3f%s",_contrastTitle,":",[_contrastArray[item]floatValue],"%"];
                }
                return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
            };
        }
        _chartView.data = @[d1x,d2x];
        NSMutableArray *array2=[[NSMutableArray alloc]initWithArray:_contrastArray];
        [array2 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        float ymin=[array1[0]floatValue]<[array2[0]floatValue]?[array1[0]floatValue]:[array2[0]floatValue];
        _chartView.yMin = ymin;
        float ymax=[array1[array1.count-1]floatValue]>[array2[array2.count-1]floatValue]?[array1[array1.count-1]floatValue]:[array2[array2.count-1]floatValue];
        _chartView.yMax = ymax;
        NSMutableArray *yArray=[[NSMutableArray alloc]init];
        for (int i=0; i<5; i++) {
            [yArray addObject:[NSString stringWithFormat:@"%.3f",ymin+i*(ymax-ymin)/4]];
        }
        _chartView.ySteps=yArray;
    }
    else
    {
        _chartView.data = @[d1x];
        float ymin=[array1[0]floatValue];
        _chartView.yMin = ymin;
        float ymax=[array1[array1.count-1]floatValue];
        _chartView.yMax = ymax;
        NSMutableArray *yArray=[[NSMutableArray alloc]init];
        for (int i=1; i<=5; i++) {
            [yArray addObject:[NSString stringWithFormat:@"%.3f",ymin+i*(ymax-ymin)/4]];
        }
        _chartView.ySteps=yArray;
        
    }
    
    
    
    _chartView.xStepsCount = 8;
    //_chartView.backgroundColor = [UIColor redColor];
    [self addSubview:_chartView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

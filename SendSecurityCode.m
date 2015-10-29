//
//  SendSecurityCode.m
//  验证码
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "SendSecurityCode.h"
#import "NetManager.h"
#import "CustomIOS7AlertView.h"
#import "NSData+replaceReturn.h"
@implementation SendSecurityCode
{
    int _CheckNum;
    NetManager * _netManger;
    CustomIOS7AlertView * _customeView;
    NSString * _path;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SendSecurityCode" owner:self options:nil] lastObject];
        
        _customeView = [CustomIOS7AlertView sharedInstace];
        [self timeChangeLabelAction];
    }
    self.frame = frame;
    return self;
}

-(void)sendSecurityCode:(UITapGestureRecognizer *)tap
{
    /**Label 设置**/
    self.longStringImage.image = [UIImage imageNamed:@"1_0008_形状-2.png"];
    self.timeChangeLabel.userInteractionEnabled = NO;
    self.timeChangeLabel.text = @"60";
    self.timeChangeLabel.textColor = [UIColor lightGrayColor];
    self.secondLabel.text = @"s";
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChangeLabelAction) userInfo:nil repeats:YES];
    
    /** 发送验证码**/;
    
    _CheckNum = (arc4random()%9000)+1000;
    
}

-(void)sendeSecurityCodeWithPath:(NSString *)path and:(LSuccessBlock)succBlock failed:(LFailedBlock)failBLock
{
    _path = path;
    self.failedblock = failBLock;
    self.Succblock = succBlock;
    
    [self requestData];
}

-(void)requestData{
    _netManger = [NetManager shareNetManager];
    [_netManger dataGetRequestWithUrl:_path Finsh:^(id data, NSInteger tag) {
        
        self.Succblock(data, _CheckNum);
        
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"发送验证码错误errorMsg%@", errorMsg);
        self.failedblock(errorMsg);
        
    } Tag:0];
    

}

-(void)timeChangeLabelAction
{
    NSString * timeStr = self.timeChangeLabel.text;
    int time = [timeStr intValue];
    
    if (time >= 1) {
        time--;
        self.timeChangeLabel.text = [NSString stringWithFormat:@"%d", time];
    }
    else{
        [_timer invalidate];
        self.longStringImage.image = [UIImage imageNamed:@"1_0006_形状-2.png"];
        self.timeChangeLabel.text = @"获取验证码";
        self.timeChangeLabel.textColor = [UIColor blueColor];
        self.secondLabel.text = @"";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendSecurityCode:)];
        [self.timeChangeLabel addGestureRecognizer:tap];
    }
}


-(void)sendeMsgInTime:(inTimeBlock)inBlock outTime:(outTimeBlock)outBlock
{
    self.intimeBock = inBlock;
    self.outtimeBlock = outBlock;
    
    NSString * timeStr = self.timeChangeLabel.text;
    int time = [timeStr intValue];
    
    if (time < 60 && time > 0) {
        self.intimeBock(_CheckNum);
    }
    else{
        self.outtimeBlock(_CheckNum);
    }
}


-(NSTimer *)_timer
{
    return _timer;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

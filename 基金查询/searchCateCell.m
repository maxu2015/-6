//
//  searchCateCell.m
//  CaiLiFang
//
//  Created by mac on 14-8-2.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "searchCateCell.h"
#import "DownloadManager.h"
#import "userInfo.h"
#import "MFLoginViewController.h"
@implementation searchCateCell
{
    DownloadManager *_downloadManager;
    NSString *_chooseUrl;
    NSMutableDictionary *_chooseDict;
    UserInfo *_user;
}

- (void)awakeFromNib
{
    // Initialization code
}

//-(void)setSelected:(BOOL)selected animated:(BOOL)animated

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(void)reloadData
{
    _fundNameLabel.text=_model.FundName;
    _fundCodeLabel.text=_model.FundCode;
    [_starButton setImage:[UIImage imageNamed:@"自选选中按钮"] forState:UIControlStateSelected];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:_fundCodeLabel.text]isEqualToString:@"YES"]) {
        _starButton.selected=YES;
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:_fundCodeLabel.text]isEqualToString:@"NO"]) {
        _starButton.selected=NO;
    }
    if ([_model.IsFlag intValue]==1) {
        _starButton.selected=YES;
    }
    [_starButton addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   
    
}


-(void)starButtonClick:(UIButton *)button
{
    _user=[UserInfo shareManager];
    if ([UserInfo isLogin]) {
        _chooseUrl=[[NSString stringWithFormat:@"http://app.myfund.com:8484/Service/DemoService.svc/GetMyFundCenter?UserName=%@&FundCode=%@&FundName=%@",[[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME],_model.FundCode,_model.FundName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_chooseUrl object:nil];
        _downloadManager=[DownloadManager sharedDownloadManager];
        [_downloadManager addDownloadWithURLString:_chooseUrl andColumnId:1 andFileId:1 andCount:1 andType:7];
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录后才可自选哦!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录",nil];
        [self addSubview:alertView];
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        MFLoginViewController *lvc=[[MFLoginViewController alloc]init];
        [lvc loginSucceed:^(NSString *LoginBlock) {
            [lvc.navigationController popViewControllerAnimated:YES];
        }];
        [self.delegate searchCateCellPushViewController:lvc];
    }
}


-(void)downloadFinished
{
    _chooseDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_chooseUrl];
    switch ([_chooseDict[@"ReturnResult"]intValue]) {
        case 0:
        {
            _starButton.selected=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:_fundCodeLabel.text];
        }
            break;
        case 2:
        {
            _starButton.selected=NO;
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:_fundCodeLabel.text];
        }
            break;
        case 3:
        {
            _starButton.selected=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:_fundCodeLabel.text];
        }
            break;
        default:
            break;
}
    
    
    //防止图片重用出错
    if (_starButton.selected) {
        self.model.IsFlag = [NSString stringWithFormat:@"%d",1] ;
    }
    
    else{
    self.model.IsFlag = [NSString stringWithFormat:@"%d",0] ;
        
    }
    
    
//    if ([_delegate respondsToSelector:@selector(clickHeadImagewithself:)]) {
//        [_delegate clickHeadImagewithself:self];
//    }
    //[self reloadData];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_chooseUrl object:nil];
}


@end

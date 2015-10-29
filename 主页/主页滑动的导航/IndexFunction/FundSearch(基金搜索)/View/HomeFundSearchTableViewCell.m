//
//  HomeFundSearchTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/18.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HomeFundSearchTableViewCell.h"
#import "userInfo.h"
#import "DownloadManager.h"
#import "MFLoginViewController.h"
#import "userInfo.h"

@implementation HomeFundSearchTableViewCell
{
    DownloadManager *_downloadManager;
    NSString *_chooseUrl;
    NSMutableDictionary *_chooseDict;
    UserInfo *_user;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithdict:(HomeFundSearchModel *)model OnTable:(UITableView *)table
{
    self.fundChooseBtn.selected = NO;
    
    self.fundcodeLabel.text = model.FundCode;
    self.fundNameLabel.text = model.FundName;
    self.fundType.text = model.FundType;

    [self.fundChooseBtn setImage:[UIImage imageNamed:@"自选选中按钮"] forState:UIControlStateSelected];
    [self.fundChooseBtn setImage:[UIImage imageNamed:@"icon_1.png"] forState:UIControlStateNormal];
    
    if ([UserInfo isLogin]) {
        if ([model.IsFlag intValue] == 1 || [model.Flag intValue] == 1) {
            self.fundChooseBtn.selected = YES;
        }
    }
}

- (IBAction)pressFundChooseBtn:(id)sender {
    
    
    if ([UserInfo isLogin]) {
     _chooseUrl=[[NSString stringWithFormat:@"http://app.myfund.com:8484/Service/DemoService.svc/GetMyFundCenter?UserName=%@&FundCode=%@&FundName=%@",[[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME], self.fundcodeLabel.text, self.fundNameLabel.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_chooseUrl object:nil];
        
       _downloadManager=[DownloadManager sharedDownloadManager];
        [_downloadManager addDownloadWithURLString:_chooseUrl andColumnId:1 andFileId:1 andCount:1 andType:7];
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录后才可自选哦!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录",nil];
        alertView.delegate = self;
        [self addSubview:alertView];
        [alertView show];
    }
}

-(void)downloadFinished
{
    _chooseDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_chooseUrl];
    switch ([_chooseDict[@"ReturnResult"]intValue]) {
        case 0:
        {
            self.fundChooseBtn.selected=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:self.fundcodeLabel.text];
        }
            break;
        case 2:
        {
            self.fundChooseBtn.selected=NO;
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:_fundcodeLabel.text];
        }
            break;
        case 3:
        {
            self.fundChooseBtn.selected=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:_fundcodeLabel.text];
        }
            break;
        default:
            break;
    }
    
    
    //防止图片重用出错
    if (self.fundChooseBtn.selected) {
        self.model.IsFlag = [NSString stringWithFormat:@"%d",1] ;
        self.model.Flag = [NSString stringWithFormat:@"%d", 1];
    }
    
    else{
        self.model.Flag = [NSString stringWithFormat:@"%d",0] ;
        self.model.IsFlag = [NSString stringWithFormat:@"%d", 0];
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_chooseUrl object:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        MFLoginViewController *login=[[MFLoginViewController alloc]init];
        login.isREcommend = YES;
        [self.superController.navigationController pushViewController:login animated:YES];
        [login loginSucceed:^(NSString *str) {
            [login.navigationController popViewControllerAnimated:YES];
        }];
    }
}



@end

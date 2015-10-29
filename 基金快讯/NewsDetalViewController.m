//
//  NewsDetalViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NewsDetalViewController.h"
#import "DownloadManager.h"
#import <ShareSDK/ShareSDK.h>
#import "UIView+Image.h"
#import "IndexFuctionApi.h"

@interface NewsDetalViewController ()

@end

@implementation NewsDetalViewController
{
    NSMutableDictionary *_contentDict;
    DownloadManager *_downloadManager;
    NSString *_contentUrlString;
    
    //分享链接网址
    NSString *_strUrl;
     
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if (device_is_iphone_5) {
        _contentScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    }
    else{
        _contentScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _contentScroll.backgroundColor = [UIColor whiteColor];
        //NSLog(@"------%f",self.view.bounds.size.height);
    }
    
    
    NSLog(@"------%f",self.view.bounds.size.height);
    [self.view addSubview:_contentScroll];
    [self requestData];
    
    
}

-(void)requestData
{
    _contentDict=[[NSMutableDictionary alloc]init];
    _downloadManager=[DownloadManager sharedDownloadManager];
    _contentUrlString=[[NSString stringWithFormat: FUND_DETAILEDNEWS, apptrade8484,self.newsId]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [ProgressHUD show:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentDownloadFinished) name:_contentUrlString object:nil];
    [_downloadManager addDownloadWithURLString:_contentUrlString andColumnId:1 andFileId:1 andCount:1 andType:7];
}


-(void)contentDownloadFinished
{
    [ProgressHUD dismiss];
    _contentDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_contentUrlString];
    
    NSLog(@"-------%@",_contentDict);
    _strUrl = _contentDict[@"ContentURL"];

    if (_contentDict[@"Content"]) {
        NSMutableString *string=[[NSMutableString alloc]initWithString:_contentDict[@"Content"]];
        
        [string replaceOccurrencesOfString:@"$" withString:@"\n       " options:NSCaseInsensitiveSearch range:NSMakeRange(0, string.length)];
        [string insertString:@"       " atIndex:0];
        
        
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:10];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [string length])];
        
        
        CGSize stringSize=[string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(310, 10000) lineBreakMode:NSLineBreakByCharWrapping];
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 100, SCREEN_WIDTH - 10, stringSize.height)];
       
        [_contentScroll addSubview:_contentLabel];
        
        
        _contentLabel.font=[UIFont systemFontOfSize:16];
        _contentLabel.backgroundColor = [UIColor whiteColor];
       // _contentLabel.textColor=[UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
        _contentLabel.numberOfLines=0;
        [_contentLabel setAttributedText:attributedString1];
        [_contentLabel sizeToFit];
        _contentScroll.contentSize=CGSizeMake(SCREEN_WIDTH, 100+stringSize.height*1.53);
    }
    
    if (_contentDict[@"Title"]) {
        _sourceLabel.font=[UIFont systemFontOfSize:20];
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320, 50)];
        _titleLabel.text=[NSString stringWithFormat:@"    %@",_contentDict[@"Title"]];
        _titleLabel.textColor=[UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f];
        _titleLabel.numberOfLines=0;
        [_contentScroll addSubview:_titleLabel];
        
        _sourceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 320, 20)];
        _sourceLabel.font=[UIFont systemFontOfSize:13];
        _sourceLabel.textColor=[UIColor colorWithRed:0.64f green:0.64f blue:0.64f alpha:1.00f];
        _sourceLabel.text=[NSString stringWithFormat:@"    %@ %@",_contentDict[@"Source"],_contentDict[@"AddDate"]];
        [_contentScroll addSubview:_sourceLabel];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}

- (void)shareButtonClick:(id)sender {
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon"  ofType:@"png"];
    //截取内容长度
    NSString *shareContent = [[NSString alloc]init];
    if (_contentLabel.text.length>50) {
        shareContent = [_contentLabel.text substringToIndex:49];
    }
    UIImage *image = [_contentScroll imageWithRect:CGRectMake(0, 0, _contentScroll.contentSize.width, _contentScroll.contentSize.height)];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@",shareContent,_strUrl]
                                       defaultContent:[NSString stringWithFormat:@"%@...",shareContent]
                                                image:[ShareSDK pngImageWithImage:image]
                                                title:[NSString stringWithFormat:@"%@ %@",shareContent,_strUrl]
                                                  url:_strUrl
                                          description:[NSString stringWithFormat:@"%@...",shareContent]
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess){
                                    YYLog(@"分享成功");
                                }else if (state == SSResponseStateFail){
                                    YYLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }}];


}



//- (void) pushMenuItem:(id)sender
//{
//    
//    NSLog(@"%@", sender);
//}

@end

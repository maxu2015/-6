//
//  NotificationInformationViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 14-12-5.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "NotificationInformationViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "CustomIOS7AlertView.h"
#import "UIImageView+WebCache.h"
#import "ExaminInfoViewController.h"
@interface NotificationInformationViewController ()<UIWebViewDelegate>

@end

@implementation NotificationInformationViewController

-(id)initWithPushKey:(NSString *)pushKey{

    self = [super init];
    if (self) {
        self.pushKey = pushKey ;
       // NSLog(@"------%@",_pushKey);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *familyNames = [UIFont familyNames];
//    for (NSString *familyName in familyNames) {
//        printf("Family:%s\n",[familyName UTF8String]);
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for (NSString *fontName in fontNames) {
//            printf("\tFont:%s\n",[fontName UTF8String]);
//        }
//    }
    
    // Do any additional setup after loading the view from its nib.
    
 
//    _web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//    _web.delegate = self ;
//    //[_web loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.myfund.com/app/sendMsg.html"]]];
//    [self.view addSubview:_web];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//去掉推送的红点
    [self loadLayerUI];
    [self requestData];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    
}
-(void)loadLayerUI{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:_scrollView] ;

}


-(void)requestData{
    [ProgressHUD show:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Service/DemoService.svc/GetJpushDetail?Key=%@",LOCAL_URL,_pushKey]];
    
    NSLog(@"-------%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dataArr.count>0) {
            NSDictionary *dataDic = [dataArr objectAtIndex:0];
            if (dataDic) {
                
                NSString *titleString = [dataDic objectForKey:@"Title"];
                _titleString = titleString;
                NSString *sourceString = [NSString stringWithFormat:@"来源：%@",[dataDic objectForKey:@"Source"]];
                NSString *timeString = [dataDic objectForKey:@"AddDate"] ;
                NSString *ContentString = [dataDic objectForKey:@"Content"];
                
                NSString *SaleContentString = [dataDic objectForKey:@"SaleContent"];
               
                
                _shareURL = [dataDic objectForKey:@"ShareURL"];//分享url
                _DetailURL = [dataDic objectForKey:@"DetailURL"];
                NSString *smallLogStr = [dataDic objectForKey:@"SmallLogo"] ;
                _smallLogoStr = [[NSMutableString alloc] initWithString:smallLogStr];//分享的图片
                //特殊字符处理
                if (sourceString) {
                    
                    NSMutableString *SaleContentstr = [[NSMutableString alloc] initWithString:SaleContentString];
                    
//                    [SaleContentstr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[NSMakeRange(0, 21)]];
                    
                    [SaleContentstr replaceOccurrencesOfString:@"$" withString:@"\n       " options:NSCaseInsensitiveSearch range:NSMakeRange(0, SaleContentstr.length)];
                    
                    
                    
                    [SaleContentstr insertString:@"       " atIndex:0];
                    CGSize saleSize = [self getSizeOfStr:SaleContentstr font:[UIFont systemFontOfSize:16]];
                    //
                    NSMutableString *string = [[NSMutableString alloc] initWithString:ContentString];
                   
                    [string replaceOccurrencesOfString:@"$" withString:@"\n       " options:NSCaseInsensitiveSearch range:NSMakeRange(0, string.length)];
                    
                    [string insertString:@"       " atIndex:0];
                    
                    CGSize titleSize   = [self getSizeOfStr:titleString font:[UIFont boldSystemFontOfSize:18]];
                    CGSize contentSize = [self getSizeOfStr:string font:[UIFont systemFontOfSize:16]];
                    
                    //NSLog(@"------%@",string);
                    
                    //
                    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titleSize.height+60+160, SCREEN_WIDTH-20, contentSize.height)];
                    
                    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                    //paragraphStyle.paragraphSpacing = 0 ;
                    paragraphStyle.lineSpacing = 8; //行距
                    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
                    
                    NSDictionary *attributes1 = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSParagraphStyleAttributeName:paragraphStyle};
                    
                    //
                    //NSLog(@"-----%f",contentSize.height);
                    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, titleSize.height)];
                    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
                    _titleLabel.numberOfLines = 10 ;
                    _titleLabel.attributedText = [[NSAttributedString alloc]initWithString: titleString attributes:attributes1];
                    [_scrollView addSubview:_titleLabel];
                    
                    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30+titleSize.height, 120, 20)];
                    _sourceLabel.text = sourceString ;
                    _sourceLabel.font = [UIFont systemFontOfSize:12];
                    _sourceLabel.textColor = [UIColor lightGrayColor];
                    [_scrollView addSubview:_sourceLabel];
                    
                    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 30+titleSize.height, SCREEN_WIDTH-150, 20)];
                    _timeLabel.text = timeString ;
                    _timeLabel.font = [UIFont systemFontOfSize:12];
                    _timeLabel.textAlignment = NSTextAlignmentRight ;
                    _timeLabel.textColor = [UIColor lightGrayColor];
                    [_scrollView addSubview:_timeLabel];
                    
                    NSString *strr = [dataDic objectForKey:@"ContentLogo"];
                    NSMutableString *picString=[[NSMutableString alloc]initWithString:strr];
                    
                    //NSLog(@"------picString%@",picString);
                    NSMutableString *urlString=[[NSMutableString alloc]initWithString:IMAGE_PREFIX];
                    if (picString.length>0) {
                        [picString replaceCharactersInRange:NSMakeRange(0, 1) withString:[urlString substringToIndex:21]];
                    }
                    
                    // NSLog(@"------picString%@",_smallLogoStr);
                    //NSString *smallLoge = @"http://www.myfund.com" ;
                    
                    if (_smallLogoStr.length>0) {
                         [_smallLogoStr replaceCharactersInRange:NSMakeRange(0, 1) withString:[urlString substringToIndex:21]];
                    }
                   
                    
                    _imageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30+titleSize.height+20+10, SCREEN_WIDTH, 150)];
                    [_imageVeiw setImageWithURL:[NSURL URLWithString:picString] placeholderImage:nil];
                    NSLog(@"-------%@",urlString);
                    [_scrollView addSubview:_imageVeiw];
                    
                    
                    
            
                   // _contentLabel.textColor = [UIColor grayColor];
                    //_contentLabel.editable = NO;
                    //_contentLabel.scrollEnabled = NO;
                    _contentLabel.font = [UIFont systemFontOfSize:16];
                    //_contentLabel.font = [UIFont fontWithName:@"AvenirNext-UltraLightItalic" size:16];
                    //_contentLabel.text = string;
                    _contentLabel.attributedText = [[NSAttributedString alloc]initWithString: string attributes:attributes];
                    _contentLabel.numberOfLines = 0;
                    [_scrollView addSubview:_contentLabel];
                    
                    
                    //NSLog(@"------%@------%f",NSStringFromCGRect(_contentLabel.frame),_contentLabel.intrinsicContentSize.height);
                    
                   
                    
                    _SaleContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titleSize.height+60+160+contentSize.height, SCREEN_WIDTH-20, saleSize.height)];
                   // _SaleContentLabel.font = [UIFont boldSystemFontOfSize:15];
                    
                    _SaleContentLabel.font = [UIFont systemFontOfSize:16];
                    //_SaleContentLabel.editable = NO;
                   // _SaleContentLabel.scrollEnabled = NO ;
                    _SaleContentLabel.numberOfLines = 0;
                   // _SaleContentLabel.text = SaleContentstr ;
                   _SaleContentLabel.attributedText =[[NSAttributedString alloc]initWithString: SaleContentstr attributes:attributes];
                    _SaleContentLabel.textColor = [UIColor blueColor] ;
                    [_scrollView addSubview:_SaleContentLabel];
                    
                    //
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(110, titleSize.height+60+160+contentSize.height+saleSize.height, 100, 40);
                    [btn setTitle:@"查看详情" forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(clickBTn) forControlEvents:UIControlEventTouchUpInside];
                    [_scrollView addSubview:btn];
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, titleSize.height+60+contentSize.height+30+160+saleSize.height+20+20);
                }
                
                
            }
        }
       
        
        
        
        [ProgressHUD dismiss];
    }];
    
}

-(void)clickBTn{

    ExaminInfoViewController *exa = [[ExaminInfoViewController alloc] initWithDetailURL:_DetailURL];
    [APP_DELEGATE.rootNav pushViewController:exa animated:YES];
}
- (CGSize)getSizeOfStr1:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(280 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    //    CGSize size = [str sizeWithFont:font
    //                  constrainedToSize:CGSizeMake(280 , MAXFLOAT)];
    return rect.size;
}

- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    //str = [NSString stringWithFormat:@"%@\n",str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 8; //行距
    NSDictionary *attribute = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    
   
    
    
    //NSAttributedString *string = [[NSAttributedString alloc]initWithString: str attributes:attribute];
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20 , MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    //    CGSize size = [str sizeWithFont:font
    //                  constrainedToSize:CGSizeMake(280 , MAXFLOAT)];
   // rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+20);
    return rect.size;
}


//- (void)webViewDidStartLoad:(UIWebView *)webView
//
//{
//
//    [ProgressHUD show:nil];
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//    [ProgressHUD dismiss];
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [ProgressHUD dismiss];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtnClick:(id)sender {


    [ProgressHUD dismiss] ;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark------

- (IBAction)ShareButtonClick:(id)sender {
    
    //NSLog(@"-------%@",_smallLogoStr);
    
    UIImage *image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_smallLogoStr]]];
    NSData *imageData=UIImageJPEGRepresentation(image, 1);
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@",_titleString,_shareURL]
                                       defaultContent:[NSString stringWithFormat:@"%@ %@",_titleString,_shareURL]
                                                image:[ShareSDK imageWithData:imageData fileName:@"cailifang" mimeType:@"image/png"]
                                                title:[NSString stringWithFormat:@"%@ %@",_titleString,_shareURL]
                                                  url:_shareURL
                                          description:_titleString
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess){
                                    YYLog(@"分享成功");
                                }else if (state == SSResponseStateFail){
                                    YYLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    CustomIOS7AlertView *errorAlert = [CustomIOS7AlertView sharedInstace];
                                    [errorAlert popAlert:[NSString stringWithFormat:@"%@",[error errorDescription]]];
                                }}];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

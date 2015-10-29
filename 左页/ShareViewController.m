#import "ShareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "CustomIOS7AlertView.h"
@interface ShareViewController ()

@end

@implementation ShareViewController

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

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnButtonClick:(id)sender {
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ShareButtonClick:(id)sender {
    UIImage *image=[UIImage imageNamed:@"MYFUND_APP.png"];
    NSData *imageData=UIImageJPEGRepresentation(image, 1);
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"展恒基金网 - 买基金免手续费，全国独家，省钱赚钱，11年信誉保障"
                                       defaultContent:@"展恒基金网 - 买基金免手续费，全国独家，省钱赚钱，11年信誉保障"
                                                image:[ShareSDK imageWithData:imageData fileName:@"MYFUND_APP.png" mimeType:@"image/png"]
                                                title:@"展恒基金网"
                                                  url:@"http://www.myfund.com/app/zh_download.html"
                                          description:@"展恒基金网 - 买基金免手续费，全国独家，省钱赚钱，11年信誉保障"
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
@end

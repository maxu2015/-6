//
//  CustomViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 14-10-29.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

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
    self.navigationController.navigationBarHidden = YES ;
    // Do any additional setup after loading the view.
}

//自定义左对齐的alertview
- (void) showAlertWithMessage:(NSString *) message{
    
    UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:@"更新提示"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"以后再说",@"马上更新", nil];
    tmpAlertView.tag = 100;
    
    //如果你的系统大于等于7.0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        CGSize size = [self getSizeOfStr:message font:[UIFont systemFontOfSize:15]];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, size.height)];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.textColor = [UIColor blackColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;//UILineBreakModeWordWrap;
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.text = message;
        [tmpAlertView setValue:textLabel forKey:@"accessoryView"];
        
        //这个地方别忘了把alertview的message设为空
        tmpAlertView.message = @"";
    }
    
    [tmpAlertView show];
}
#pragma mark--提示框
- (void)showAlertView:(NSString *)title message:(NSString *)msg
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
    [alertView show];
}

- (void)showToastWithMessage:(NSString *)message showTime:(float)interval
{
    TipLabel * tip = [[TipLabel alloc] init];
    [tip showToastWithMessage:message showTime:interval];
}


-(HCButton *)createButtonWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleFont:(UIFont *)font withNormalImg:(NSString *)normalImg withLightImg:(NSString *)lightImg withSelect:(SEL)clickBtn

{
    HCButton *btn = [[HCButton alloc] initWithFrame:frame withTitle:title withTitleFont:font withNormalImg:normalImg withLightImg:lightImg withSelect:clickBtn];
    return btn ;
    
    
}
-(HCLabel *)createLableWithframe:(CGRect)frame withtext:(NSString *)text withFont:(UIFont *)textFont withBreakLine:(BOOL)autoBreakLine
{
    
    HCLabel *label = [[HCLabel alloc] initWithframe:frame withtext:text withFont:textFont withBreakLine:autoBreakLine];
    return label ;
    
}
- (UIImageView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.image = image;
    return imageview;
}
//创建UITextField
- (UITextField *)createTextFieldWithFrame:(CGRect)frame text:(NSString *)txt fontSize:(int)size
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    //    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor darkGrayColor];
    textField.font = [UIFont systemFontOfSize:size];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.returnKeyType = UIReturnKeyNext;
    textField.text = txt;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)promptUpData
{
    //获取到当前app的版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"%@",currentVersion);
    
    //获取appstore上得版本号进行对比   土豆url1102466711(原版)
    //    NSString *url = @"http://itunes.apple.com/lookup?id=395898626";
    
    
    NSString *url = @"http://itunes.apple.com/lookup?id=957252192";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc]initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic ; //= [results JSONValue];请求接口http://itunes.apple.com/lookup?id=957252192返回值
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    
    
    
    if ([infoArray count]) {
        NSDictionary *releaseInfo = infoArray[0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        
        NSLog(@"--------%@--------%@",lastVersion,currentVersion);
        
        NSString *versinreleaseNotes = [releaseInfo objectForKey:@"releaseNotes"];
        int result1 = [currentVersion compare:lastVersion options:NSLiteralSearch];//字符串比较
        
        
        
        
        if (result1 == -1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新提示" message:versinreleaseNotes delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"马上更新", nil];
            alert.tag = 100;
            [alert show];
        }
    }
}

//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//返回字体间距
- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 8; //行距
    NSDictionary *attribute = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
    //NSAttributedString *string = [[NSAttributedString alloc]initWithString: str attributes:attribute];
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(300 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    //    CGSize size = [str sizeWithFont:font
    //                  constrainedToSize:CGSizeMake(280 , MAXFLOAT)];
    return rect.size;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

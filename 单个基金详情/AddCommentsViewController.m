//
//  AddCommentsViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "AddCommentsViewController.h"
#import "ZidonAFNetWork.h"
#import "CustomIOS7AlertView.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"

@interface AddCommentsViewController ()<UITextViewDelegate,zidonDelegate>

@end


@implementation AddCommentsViewController {
    UserInfo *_user;

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
    // Do any additional setup after loading the view from its nib.
    _commentsDetail.layer.masksToBounds=YES;
    _commentsDetail.layer.cornerRadius=5;
    _commentsDetail.delegate=self;
    _commentsDetail.autocorrectionType = UITextAutocorrectionTypeNo;
    _user=[UserInfo shareManager];
}
//输入内容时提示还可以再输入多少字
-(void)textViewDidChange:(UITextView *)textView
{
    _wordsLimitLabel.text = [NSString stringWithFormat:@"还可以再输入%d个字",144-textView.text.length];
}
//结束编辑时判断字数是否大于144
-(void)textViewDidEndEditing:(UITextView *)textView
{
    int maxLenth = textView.text.length;
    NSLog(@"字符长度：%d",maxLenth);
    if (maxLenth>144) {
        CustomIOS7AlertView *alert = [CustomIOS7AlertView sharedInstace];
        [alert popAlert:@"字数不能超过144"];
//        textView.text = [textView.text substringToIndex:143];
    }
}
//点击背景回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   // [APP_DELEGATE.rootNav pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>]
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)enterBtn:(id)sender {
    NSString * replaceStr = nil;
    NSString * str = self.commentsDetail.text;
    replaceStr = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    NSLog(@"enterBtn,//=%lu", self.commentsDetail.text.length);
    
    if (replaceStr.length>144) {
        CustomIOS7AlertView *alertView = [CustomIOS7AlertView sharedInstace];
        [alertView popAlert:@"最大字数不能超过144"];
        return;
    }
    else{
        if (replaceStr.length == 0) {
            CustomIOS7AlertView *alert = [CustomIOS7AlertView sharedInstace];
            [alert popAlert:@"评论内容为空"];
            return;
        }
        else{
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            ZidonAFNetWork *zidonAddComments = [ZidonAFNetWork sharedInstace];
            [ProgressHUD show:@"正在提交"];
           
            [zidonAddComments requestWithUrl:[[NSString stringWithFormat:kAddCommentsUrl,LOCAL_URL,[[[_user userInfoDic] objectForKey:@"UserName"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_fundCode,_fundName,_commentsDetail.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] withDelegate:self];
            NSLog(@"提交评论网址 = %@",[NSString stringWithFormat:kAddCommentsUrl,LOCAL_URL,[[[_user userInfoDic] objectForKey:@"UserName"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_fundCode,_fundName,_commentsDetail.text]);
        }
    }
}
-(void)requestFinished:(NSArray *)parmeters
{
    NSDictionary *dic = parmeters[0];
    int staNum = [dic[@"ReturnResult"] intValue];
    if (staNum == 0) {
        [ProgressHUD showSuccess:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)requestFailed:(NSError *)error
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"jjjjjjjjjjj = %@",[NSString stringWithFormat:kAddCommentsUrl,LOCAL_URL,[[_user userInfoDic] objectForKey:@"UserName"],_fundCode,_fundName,_commentsDetail.text]);
}
@end

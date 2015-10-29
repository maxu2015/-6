//
//  PersonMessageViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/20.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "PersonMessageViewController.h"
#import "userInfo.h"
#import "CustomPassWord.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
@interface PersonMessageViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *mobleNum;
@property (weak, nonatomic) IBOutlet UILabel *identfy;
@property (weak, nonatomic) IBOutlet UILabel *email;
- (IBAction)pressFinshedBtn:(id)sender;

@end

@implementation PersonMessageViewController {
    NetManager *_netManager;
    UserInfo *_user;
    
}
- (void)configPersonCenter {
    _user=[UserInfo shareManager];
    NSDictionary *userDic=[_user userInfoDic];
    _userName.text=[userDic objectForKey:@"DisplayName"];
    _account.text=[NSString stringWithFormat:@"个人账号:%@",[userDic objectForKey:@"Mobile"]];
    _sex.text=[userDic objectForKey:@"Sex"];
    _mobleNum.text=[userDic objectForKey:@"Mobile"];
    _identfy.text=[userDic objectForKey:@"IDCard"];
    _email.text=[userDic objectForKey:@"Email"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _netManager=[NetManager shareNetManager];
    [self configPersonCenter];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)setUserSex:(id)sender {
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"先生",@"女士",nil];
    [action showInView:self.view];
    
}
- (IBAction)finshedClicl:(id)sender {
    NSString *urlStr=[NSString stringWithFormat:@""];
    
//    [self requstHttp:<#(NSString *)#> tag:<#(NSInteger)#>]
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        _sex.text=@"男";
    }else if(buttonIndex==1){
          _sex.text=@"女";
    }else{
        _sex.text=@"";
    }

}

- (IBAction)setEmailNumber:(id)sender {
    CustomPassWord *emal=[[CustomPassWord alloc]initWithFrame:MYSCREEN];
    emal.title.text=@"请输入新邮箱";
    emal.passwd.secureTextEntry=NO;
    emal.passwd.placeholder=@"请输入新邮箱";
    [emal show];
    [emal configSureBlock:^(NSString *str) {
        _email.text=str;
        NSLog(@"erewrew-===%@",[_user userInfoDic]);

        
    }];
    
}
- (void)requstHttp:(NSString *)url tag:(NSInteger)tag {

    NSLog(@"# =%@", url);
[_netManager dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
    if (tag=='emil') {
        NSArray * arr =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * returnMessage = @[@"修改成功", @"邮箱格式错误",  @"修改失败"];
        if ([arr isKindOfClass:[NSArray class]]) {
            NSString * ReturnResult = [[arr lastObject] objectForKey:@"ReturnResult"];
            if ([ReturnResult intValue] == 0) {
                [self showalertWithmessage:returnMessage[0]];
                NSMutableDictionary *muserdic=[[NSMutableDictionary alloc]initWithDictionary:[_user userInfoDic]];
                [muserdic setObject:_email.text forKey:@"Email"];
                [muserdic setObject:self.sex.text forKey:@"Sex"];
                [_user syncDataToLocal:UserINfo userInfoDic:muserdic];
            }
            else if ([ReturnResult intValue] == 3){
                [self showalertWithmessage:returnMessage[1]];
                _email.text = @"请输入新邮箱";
            }
            else{
                [self showalertWithmessage:returnMessage[2]];
                _email.text = @"请输入新邮箱";
            }
        }
        else{
            [self showalertWithmessage:@"系统错误"];
        }
    }
} fail:^(id errorMsg, NSInteger tag) {
    
} Tag:tag];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressFinshedBtn:(id)sender {
    if (_email.text.length > 0 && self.sex.text.length > 0) {
        NSDictionary * dic = [_user userInfoDic];
        NSString * path = [NSString stringWithFormat:upemail,apptrade8484, [dic objectForKey:@"UserName"],[dic objectForKey:@"DisplayName"], [dic objectForKey:@"Mobile"], self.sex.text, [dic objectForKey:@"IDCard"], _email.text];
        NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)path, NULL, NULL,  kCFStringEncodingUTF8 ));
    [self requstHttp:encodedString tag:'emil'];
    }
    else if (_email.text.length == 0){
        [self showalertWithmessage:@"请输入邮箱"];
    }
    else if (self.sex.text.length == 0){
        [self showalertWithmessage:@"请选择性别"];
    }
}

-(void)showalertWithmessage:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end

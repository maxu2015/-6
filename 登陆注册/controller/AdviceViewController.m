#import "AdviceViewController.h"
#import "CustomIOS7AlertView.h"
#import "ZidonAFNetWork.h"
#import "IndexFuctionApi.h"
@interface AdviceViewController ()<UITextViewDelegate,zidonDelegate>
{
    CustomIOS7AlertView * _cusomtView;
}
@end
@implementation AdviceViewController

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
    _cusomtView = [CustomIOS7AlertView sharedInstace];
    
    _adviceReview.layer.masksToBounds=YES;
    _adviceReview.layer.cornerRadius=5;
    _adviceReview.delegate=self;
    _adviceReview.autocorrectionType = UITextAutocorrectionTypeNo;
    _adviceReview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}



-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"按钮y值= %f",_enterBtn.frame.origin.y+34);
    NSLog(@"键盘y值 = %f",([UIScreen mainScreen].bounds.size.height-216-64));
    if (_enterBtn.frame.origin.y+34>([UIScreen mainScreen].bounds.size.height-216-64)) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = _bgUIView.frame;
            rect.origin.y = 0;
            _bgUIView.frame = rect;
        }];
    }
    _placeHolderLable.hidden=YES;
    return YES;
}
//限制textView的字数
-(void)textViewDidEndEditing:(UITextView *)textView
{
    int maxLenth = textView.text.length;
    NSLog(@"字符长度：%d",maxLenth);
    if (maxLenth>144) {
        CustomIOS7AlertView *alert = [CustomIOS7AlertView sharedInstace];
        [alert popAlert:@"字数不能超过144"];
        textView.text = [textView.text substringToIndex:143];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0) {
        _placeHolderLable.hidden=NO;
    }else{
        _placeHolderLable.hidden=YES;
    }
    _wordsLimit.text = [NSString stringWithFormat:@"还可以再输入%d个字",144-textView.text.length];
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _placeHolderLable.hidden=NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _bgUIView.frame;
        rect.origin.y = 76;
        _bgUIView.frame = rect;
    }];
    [self.view endEditing:YES];
}

- (IBAction)commit:(UIButton *)sender {
    
    
    NSString * replaceStr = nil;
    NSString * str = self.adviceReview.text;
    replaceStr = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (replaceStr.length < 1) {
        [_cusomtView popAlert:@"意见为空"];
        return;
    }
    if (replaceStr.length > 144) {
        [_cusomtView popAlert:@"最大字数不能超过144"];
        return;
    }
    
    ZidonAFNetWork *zidonUpAdvice = [ZidonAFNetWork sharedInstace];
    [zidonUpAdvice requestWithUrl:[[NSString stringWithFormat:kUpAdviceUrl,LOCAL_URL,_phoneNumTF.text,_adviceReview.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] withDelegate:self];
    [ProgressHUD show:@"正在提交意见反馈"];

}
-(void)requestFinished:(NSArray *)parmeters
{
    NSDictionary *dic = parmeters[0];
    int staNum = [dic[@"ReturnResult"] intValue];
    if (staNum == 0) {
        [ProgressHUD showSuccess:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (staNum == 1) {
        [ProgressHUD showError:@"手机号码不正确"];
    }
    if (staNum == 2) {
        [ProgressHUD showError:@"意见内容不能为空"];
    }
}
-(void)requestFailed:(NSError *)error
{
    
}
- (IBAction)returnButtonClick:(id)sender {
    
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
@end

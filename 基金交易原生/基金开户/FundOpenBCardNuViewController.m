//
//  FundOpenBCardNuViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundOpenBCardNuViewController.h"

@interface FundOpenBCardNuViewController ()

@end

@implementation FundOpenBCardNuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cardTF.returnKeyType =  UIReturnKeyDone ;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)seleBankCard:(bankCardNumber)block{

    if (block) {
        _myBankCardNumber = block ; 
    }
}


-(BOOL)verifyPassWorld:(NSString *)text{

   NSString *myText = @"[^\x00-\xff]";
   NSPredicate *textTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",myText];
    if (![textTest evaluateWithObject:myText]) {
        
        //没有汉字
        NSString *nyText1 = @"\n\s*\r";
        if (![textTest evaluateWithObject:nyText1]) {
            //没有空白
        }
        
    }
    
        return NO;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [super touchesBegan:touches withEvent:event];
    [_cardTF resignFirstResponder];
    
    if (_myBankCardNumber) {
        _myBankCardNumber(_cardTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [_cardTF resignFirstResponder];
    
    if (_myBankCardNumber) {
        _myBankCardNumber(_cardTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
    return YES ;
}
-(IBAction)NacBack:(id)sender{

    if (_cardTF.text.length>0) {
        [_cardTF resignFirstResponder];
        
        if (_myBankCardNumber) {
            _myBankCardNumber(_cardTF.text);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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

//
//  FundOpenBCardNuViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundOpenBCardNuViewController : UIViewController<UITextFieldDelegate>

typedef void(^bankCardNumber)(NSString *bankcardNum);

@property(nonatomic,copy)bankCardNumber myBankCardNumber;
@property(nonatomic,weak)IBOutlet UITextField *cardTF ; 
-(void)seleBankCard:(bankCardNumber)block ;

-(IBAction)NacBack:(id)sender;

@end

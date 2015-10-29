//
//  HDLViewController.h
//  CaiLiFang
//
//  Created by mac on 14-9-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDLViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong)NSString *HDLPageURL  ;//恒得利URL；
@property(nonatomic,strong)NSString *HDLDescription ;
@property(nonatomic,strong)NSString *HDLImageURL ;
@property(nonatomic,strong)NSString *HDLTitle    ;

@property(nonatomic,strong)NSString *urlName;
- (IBAction)returnButtonClick:(id)sender;
- (IBAction)ShareButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)NSString *titleLabelText;
//@property(nonatomic,assign)int webViewCount ;
@end

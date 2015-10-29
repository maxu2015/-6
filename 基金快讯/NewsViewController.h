//
//  NewsViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^msgBlock) (UIButton * btn);

@interface NewsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *headView;


- (IBAction)newButtonClick:(id)sender;
- (IBAction)researchButtonClick:(id)sender;
- (IBAction)returnButtonClick:(id)sender;

@property(nonatomic, copy) msgBlock Msgblock;


@end

//
//  HomeFourViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-5-4.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeFourViewController : UIViewController
@property (nonatomic,copy) NSString *IDCard;
typedef void(^leftComeOut)(void);


@property(nonatomic,strong)UIScrollView  *backScrollView ; 
@property(nonatomic,copy)leftComeOut leftBlock;
-(void)clickLeftBtn:(leftComeOut)block ;
-(IBAction)enterLeftNavication;


-(void)clickMyButton;//点击我的按钮
-(IBAction)setUserInfo;
- (void)ifIdcard;
- (void)IFGuanJiaTong;
    
   
@end

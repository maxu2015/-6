//
//  SearchTVcell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/6/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^seacherCancel)(void);
typedef void(^seachKey)(NSString *searchKey);
@interface SearchTVcell : UIView<UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UITextField *seacherTF;
@property (weak, nonatomic) IBOutlet UIButton *seacherCancelBU;
@property (nonatomic,copy) seacherCancel cancelBlock;
@property (nonatomic,copy) seachKey searchChangeBlock;

@end

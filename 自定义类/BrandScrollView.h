//
//  BrandScrollView.h
//  CaiLiFang
//
//  Created by  展恒 on 14-11-5.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"
@protocol BrandScrollViewDelegate <NSObject>

-(void)clickImageView:(BrandModel *)brandModel;

@end
@interface BrandScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *photoModel;
@property(nonatomic,weak)id <BrandScrollViewDelegate>delegate ;

- (void)reloadData ; 
@end

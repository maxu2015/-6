//
//  ProgressView.h
//  Process
//
//  Created by  展恒 on 14-11-28.
//  Copyright (c) 2014年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

{

    
    
    

}

@property(nonatomic,assign) float Progress ;//进度0------1
@property(nonatomic,assign) float lineWidth ; //线宽

-(void)updateView ; //跟新view ui
@end

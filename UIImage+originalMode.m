//
//  UIImage+originalMode.m
//  CaiLiFang
//
//  Created by 08 on 15/2/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "UIImage+originalMode.h"

@implementation UIImage (originalMode)
+(UIImage *)imageWithOriginalMode:(NSString *)imageNamed
{
    UIImage*image = [UIImage imageNamed:imageNamed];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
@end

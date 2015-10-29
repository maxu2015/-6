//
//  UIImage+DImage.m
//  CaiLiFang
//
//  Created by  展恒 on 14-11-10.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "UIImage+DImage.h"

@implementation UIImage (DImage)

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = newSize.width;
    CGFloat targetHeight = newSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, newSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(newSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

//图片保存相册
+ (void)saveImageToAlbum:(UIImage *)image
{
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 5) {
        ALAssetsLibrary* library = [ALAssetsLibrary new];
        [library saveImage:image toAlbum:@"文件夹" withCompletionBlock:^(NSError *error) {
            if (error) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"保存相册失败"
                                                               message:@"可以去 隐私-照片 设置"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
               
            }
        }];
    }else{
        UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error != NULL){
        NSLog(@"保存图片失败");
    }else{
        NSLog(@"保存图片成功");
    }
    
    //    [self showToastWithMessage:[error localizedDescription] showTime:1];
}

//图片裁剪
-(UIImage *)ClipImage:(UIImage *)clipImage withFrame:(CGRect)frame

{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithCGImage:clipImage.CGImage];
    CIImage *clipCIImage = [image imageByCroppingToRect:frame];
    UIImage *outImage = [UIImage imageWithCGImage:[context createCGImage:clipCIImage fromRect:clipCIImage.extent]];
    return outImage ;
    
    
}
@end

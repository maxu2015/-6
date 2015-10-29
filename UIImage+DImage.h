//
//  UIImage+DImage.h
//  CaiLiFang
//
//  Created by  展恒 on 14-11-10.
//  CopyrightH (c) 2014年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
@interface UIImage (DImage)


//图片压缩
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//图片保存到相册
+ (void)saveImageToAlbum:(UIImage *)image;

//图片裁剪
-(UIImage *)ClipImage:(UIImage *)clipImage withFrame:(CGRect)frame;
@end

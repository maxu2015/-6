//
//  UIView+Image.m
//  FJCourt
//
//  Created by wshaolin on 14-8-20.
//  Copyright (c) 2014年 rnd. All rights reserved.
//

#import "UIView+Image.h"

@implementation UIView (Image)

- (UIImage *)imageWithRect:(CGRect)rect{
    // UIScrollView或者UIWebView的截图
    if([self isKindOfClass:[UIScrollView class]] || [self isKindOfClass:[UIWebView class]]){
        UIScrollView *scrollView = nil;
        if([self isKindOfClass:[UIScrollView class]]){
            scrollView = (UIScrollView *)self;
        }else{
            UIWebView *webView = (UIWebView *)self;
            scrollView = webView.scrollView;
        }
        UIImage *image = nil;
        UIGraphicsBeginImageContext(scrollView.contentSize);
        {
            CGPoint oldContentOffset = scrollView.contentOffset;
            CGRect oldFrame = scrollView.frame;
            scrollView.contentOffset = CGPointZero;
            scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
            
            [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
            image = UIGraphicsGetImageFromCurrentImageContext();
            
            scrollView.contentOffset = oldContentOffset;
            scrollView.frame = oldFrame;
        }
        UIGraphicsEndImageContext();
        return image;
    }
    CGSize size = CGSizeMake(rect.size.width, rect.size.height);
    if(UIGraphicsBeginImageContextWithOptions != NULL){
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    return [[UIImage alloc] initWithCGImage:imageRefRect];
}

@end

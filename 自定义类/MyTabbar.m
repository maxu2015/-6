//
//  MyTabbar.m
//  6.18LimitDemo
//
//  Created by Student on 14-6-18.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "MyTabbar.h"

@implementation MyTabbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        self.alpha=1;
    }
    return self;
}

-(void)createMyTabbarWithBgImageName:(NSString *)bgImageName andItemsArray:(NSArray *)itemsArray andClass:(id)classObject andSEL:(SEL)sel
{
    //1.创建背景图
    
    if (bgImageName.length>0) {
        [self createBgImageViewWithImageName:bgImageName];
    }
    
    //2.创建对应数量的item
    if (itemsArray.count>0) {
        int index;
        for (index=0; index<itemsArray.count; index++) {
            [self createItemsWithItemDict:[itemsArray objectAtIndex:index] andIndex:index andCount:[itemsArray count] andClass:classObject andSEL:sel];
        }
    }
}

-(void)createBgImageViewWithImageName:(NSString*)imageName
{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame=self.bounds;
    [self addSubview:imageView];
}

-(void)createItemsWithItemDict:(NSDictionary*)itemDict andIndex:(int)index andCount:(int)count andClass:(id)classObject andSEL:(SEL)sel
{
    //1.容器
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(self.bounds.size.width/count*index, 0, self.bounds.size.width/count, self.bounds.size.height);
    view.tag=11+index;
    UITapGestureRecognizer *tgr=[[UITapGestureRecognizer alloc]initWithTarget:classObject action:sel];
    [view addGestureRecognizer:tgr];
    
    [self addSubview:view];
    //2.按钮
    UIImage *image=[UIImage imageNamed:[itemDict objectForKey:@"image"]];
    UIImage *imagepress=[UIImage imageNamed:[itemDict objectForKey:@"imagepress"]];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake((view.bounds.size.width-image.size.width)/2, 3, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagepress forState:UIControlStateSelected];
    
//    [button addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
    
    button.tag=index+1;
    button.userInteractionEnabled=NO;
    [view addSubview:button];
    
    //3.label
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0, button.frame.size.height, view.frame.size.width, view.frame.size.height-button.frame.size.height-2);
    label.text=[itemDict objectForKey:@"title"];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:10];
    label.textColor=[UIColor colorWithRed:0.57f green:0.57f blue:0.57f alpha:1.00f];
    [view addSubview:label];
    
    //设置默认选项
    if (index==0) {
        button.selected=YES;
        label.textColor=[UIColor colorWithRed:0.91f green:0.45f blue:0.43f alpha:1.00f];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

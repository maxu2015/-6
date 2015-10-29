//
//  ADScrollView.m
//  CaiLiFang
//
//  Created by mac on 14-7-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ADScrollView.h"
#import "UIImageView+WebCache.h"
#import "BannerModel.h"
#import "DealViewController.h"
@implementation ADScrollView
{
    UIScrollView * _scrollView;
    UILabel * _imageTitleLabel;
    UIPageControl * _pageControl;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    //以下初始化顺序，不可修改
    [self createScrollView];

    [self createPageControl];
}

//创建滚动视图
- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //按页翻动
    _scrollView.pagingEnabled = YES;
    
    //去除水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.bounces=NO;
    
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
}


- (void)createPageControl
{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 215, self.bounds.size.height - 25, 100, 30)];

    _pageControl.pageIndicatorTintColor=[UIColor orangeColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    _pageControl.alpha = 0.5;
    
    //添加事件
    [_pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_pageControl];
}

- (void)valueChanged:(UIPageControl *)pageControl
{
    CGPoint offset = CGPointMake(pageControl.currentPage *  self.bounds.size.width, 0);
    //设置_scrollView的滚动偏移
    [_scrollView setContentOffset:offset animated:YES];
    
}


#pragma mark - 数据

//刷新数据
- (void)reloadData
{
    //设置scrollView的contentSize
    _scrollView.contentSize = CGSizeMake(self.photoModel.count * self.bounds.size.width, self.bounds.size.height);
    
    
    //就是把数组中的图片，添加到滚动视图上
    //数组中是图片的名字
    int i = 0;
    for (BannerModel *model in self.photoModel) {
        
        //创建imageView
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.image=[UIImage imageNamed:@"Banner初始图"];
        NSMutableString *picString=[[NSMutableString alloc]initWithString:model.BannerPic];
        NSMutableString *urlString=[[NSMutableString alloc]initWithString:IMAGE_PREFIX];
        if (picString.length>0) {
            [picString replaceCharactersInRange:NSMakeRange(0, 1) withString:[urlString substringToIndex:21]];
        }
        
        
        [imageView setImageWithURL:[NSURL URLWithString:picString] placeholderImage:nil];
        
   
        
        //设置图片的填充模式 保持比例填满//UIViewContentModeScaleAspectFit会保证图片比例不变，而且全部显示在ImageView中，这意味着ImageView会有部分空白。UIViewContentModeScaleAspectFill也会证图片比例不变，但是是填充整个ImageView的，可能只有部分图片显示出来
       // imageView.contentMode = UIViewContentModeScaleAspectFit;
        //裁剪边界
        imageView.clipsToBounds = YES;
        
        imageView.tag=100+i;
        
        UITapGestureRecognizer *tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnImageView:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:tgr];
        
        
        [_scrollView addSubview:imageView];
        i++;
    }
    
    //有几张图，有几个点
    _pageControl.numberOfPages = self.photoModel.count;
}

-(void)tapOnImageView:(UITapGestureRecognizer*)tgr
{
    DealViewController *dvc=[[DealViewController alloc]init];
    dvc.urlString=[_photoModel[tgr.view.tag-100]BannerURL];
    dvc.bannerInfo=_photoModel[tgr.view.tag-100];
    [self.delegate pushViewController:dvc];
}


#pragma mark - 协议方法 UIScrollViewDelegate

//当减速结束，彻底停下来
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _scrollView.contentOffset.x / self.bounds.size.width;
 
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

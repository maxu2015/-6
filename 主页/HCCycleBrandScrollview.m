//
//  HCCycleBrandScrollview.m
//  MyPersonalLibrary
//
//  Created by  展恒 on 15-3-26.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#define ANIMATION_DURATION    3     //开启定时器的时间间隔

#import "HCCycleBrandScrollview.h"
#import "UIImageView+WebCache.h"
@implementation HCCycleBrandScrollview
{
    UIScrollView  * _scrollView;
    UIPageControl * _pageControl;
    int           _curPage     ;
}

-(id)initWithFrame:(CGRect)frame withStartTimer:(BOOL)startTimer{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createSubViews];
        _startTimer = startTimer;
        //开启定时器
        if (_startTimer) {
            if (ANIMATION_DURATION > 0.0) {
                self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_DURATION
                                                                       target:self
                                                                     selector:@selector(animationTimerDidFired:)
                                                                     userInfo:nil
                                                                      repeats:YES];
                [self.animationTimer resumeTimerAfterTimeInterval:ANIMATION_DURATION];
            }
        }
        
    }
    return self;
}


/*
 *  定时器设置
 */



-(void)timerInvalidate{
    [self.animationTimer invalidate];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createSubViews];
        //
        
//        //开启定时器
//        if (_startTimer) {
//            if (ANIMATION_DURATION > 0.0) {
//                self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_DURATION
//                                                                       target:self
//                                                                     selector:@selector(animationTimerDidFired:)
//                                                                     userInfo:nil
//                                                                      repeats:YES];
//                [self.animationTimer resumeTimerAfterTimeInterval:ANIMATION_DURATION];
//            }
//        }
        
    }
    return self;
}

#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(_scrollView.contentOffset.x + CGRectGetWidth(_scrollView.frame), _scrollView.contentOffset.y);
    [_scrollView setContentOffset:newOffset animated:YES];
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
    
    //_scrollView.bounces=NO;//判断scrollview是否可以超区域滑动
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
}
- (void)createPageControl
{
    _curPage = 0;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 215, self.bounds.size.height - 25, 100, 30)];
    _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
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
    
    _pageControl.numberOfPages = _sourceModel.count;
    _pageControl.currentPage = _curPage;
    //就是把数组中的图片，添加到滚动视图上
    //数组中是图片的名字
    
    
    //NSLog(@"----%@",_scrollView.subviews);
    
    for (UIImageView *v in _scrollView.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    [self getDisplayImagesWithCurpage:_curPage];
    
    int i = 0;
    for (BannerModel *model in self.photoModel) {
        
        //创建imageView
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        NSString *url = model.BannerPic;
        
        NSMutableString *urlString=[[NSMutableString alloc]initWithString:IMAGE_PREFIX];
        NSMutableString *picString=[[NSMutableString alloc]initWithString:url];
        
//        NSLog(@"%@",picString);
        if (picString.length>0) {
            [picString replaceCharactersInRange:NSMakeRange(0, 1) withString:[urlString substringToIndex:21]];
            
        }
        
        [imageView setImageWithURL:[NSURL URLWithString:picString] placeholderImage:[UIImage imageNamed:@"Banner初始图"]];
       // NSLog(@"------%@",imageView);
        //设置图片的填充模式 保持比例填满
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        //裁剪边界
//        imageView.clipsToBounds = YES;
        
        imageView.tag=100+i;
        
        UITapGestureRecognizer *tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnImageView:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:tgr];
        
        
        [_scrollView addSubview:imageView];
        i++;
    }
    
   [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(int)page {
    
    
    int pre = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
    if (_sourceModel.count<last) {
        return;
    }
    if (!_photoModel) {
        _photoModel = [[NSMutableArray alloc] init];
    }
    
    [_photoModel removeAllObjects];
    
    [_photoModel addObject:[_sourceModel objectAtIndex:pre]];
    [_photoModel addObject:[_sourceModel objectAtIndex:_curPage]];
    [_photoModel addObject:[_sourceModel objectAtIndex:last]];
//    NSLog(@"%@",_photoModel);
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _sourceModel.count - 1;
    if(value == _sourceModel.count) value = 0;
    
    return (int)value;
    
}
-(void)tapOnImageView:(UITapGestureRecognizer*)tgr{
    
    BannerModel *model = [_photoModel objectAtIndex:1];
    if (_brandBlock) {
        _brandBlock(model) ;
    }
}

-(void)clickBrandImage:(brandUrl)block{
    
    if (block) {
        _brandBlock = block ;
    }
    
}

#pragma mark - 协议方法 UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_startTimer) {
        [self.animationTimer pauseTimer];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (_startTimer) {
        [self.animationTimer resumeTimerAfterTimeInterval:ANIMATION_DURATION];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
int x = scrollView.contentOffset.x;
    //往下翻一张
    
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self reloadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self reloadData];
    }

}
//当减速结束，彻底停下来
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    //_pageControl.currentPage = _scrollView.contentOffset.x / self.bounds.size.width;
    
//    NSLog(@"------%ld",_pageControl.currentPage);
    
}

@end

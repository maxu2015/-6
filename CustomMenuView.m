//
//  CustomMenuView.m
//  CaiLiFang
//
//  Created by  展恒 on 14-10-29.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "CustomMenuView.h"
#import "GlobalConfig.h"
@interface CustomMenuView()

@property(nonatomic , strong) NSMutableArray * allBtns;
@property(nonatomic , copy)   UIButton * lastSelectedBtn;
@property(nonatomic , strong) NSMutableArray * nomalImgs;
@property(nonatomic , strong) NSMutableArray * selectedImgs;
@end
@implementation CustomMenuView

@synthesize menuDelegate,mType,allBtns;

- (id)initWithFrame:(CGRect)frame type:(MENU_TYPE)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        mType = type;
        allBtns = [[NSMutableArray alloc] init];
        //self.backgroundColor = COLOR_RGBA(51, 61, 70, 0.96f);
        //        self.backgroundColor = [UIColor clearColor];
        switch (mType) {
            case MENU_TYPE_MAIN_MENU:
            {
                //                self.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
            }
                break;
            case MENU_TYPE_MAIN_MENU_DING:
            {
                //                self.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
            }
                break;
            case MENU_TYPE_TAB_BAR_MENU:
            {
                
            }
                break;
            default:
                break;
        }
        
    }
    
    //    [self.layer setBorderColor:[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f].CGColor];
    //    [self.layer setBorderWidth:1];
    
    return self;
}

- (void)addMenuSelectedBlock: (void(^)(CustomMenuView *view,NSInteger selectedIndex,NSInteger lastSelectedIndex)) block
{
    self.menuSelectedBlock = [block copy];
}

- (void)initMenuBtns:(NSArray *)normalImagesArr selected:(NSArray *)selectedImagesArr itemNames:(NSArray *)itemNames
{
    _nomalImgs = [normalImagesArr copy];
    _selectedImgs = [selectedImagesArr copy];
    
    switch (mType) {
        case MENU_TYPE_MAIN_MENU:
        {
            float width = SCREEN_WIDTH / [itemNames count];
            float height = CGRectGetHeight(self.frame);
            
            
            
            for (int i = 0; i < [itemNames count]; i ++) {
#pragma -mark debug
                NSString * name = [itemNames objectAtIndex:i];
                UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                menuBtn.frame = CGRectMake(width * i,0, width, height);
                menuBtn.tag = 1000 + i;
                [menuBtn addTarget:self action:@selector(menuBtnPressed:) forControlEvents:UIControlEventTouchDown];
                [menuBtn setBackgroundImage:[UIImage imageNamed:[normalImagesArr objectAtIndex:i]] forState:UIControlStateNormal];
                
                //[menuBtn setBackgroundImage:[UIImage imageNamed:[selectedImagesArr objectAtIndex:i]] forState:UIControlStateHighlighted];
                menuBtn.adjustsImageWhenHighlighted=NO;
                [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self addSubview:menuBtn];
                
                [menuBtn setTitle:name forState:UIControlStateNormal];
                //                {top, left, bottom, right};
                
                //UIEdgeInsets insets = {top, left, bottom, right};
                menuBtn.contentEdgeInsets = UIEdgeInsetsMake(35,5, 0, 5);
                [menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
                [menuBtn.titleLabel setTextColor:[UIColor blackColor]];
                if (i == 0) {
                    [menuBtn setBackgroundImage:[UIImage imageNamed:[selectedImagesArr objectAtIndex:i]] forState:UIControlStateNormal];
                    [menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [self setLastSelectedBtn:menuBtn];
                }
                
                
            }
            break;
        case MENU_TYPE_MAIN_MENU_DING:
            {
                float width = SCREEN_WIDTH / [itemNames count] ;
                float height = CGRectGetHeight(self.frame);
                
                
                
                for (int i = 0; i < [itemNames count]; i ++) {
                    
                    NSString * name = [itemNames objectAtIndex:i];
                    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    menuBtn.frame = CGRectMake(width * i ,0, width, height);

                    menuBtn.tag = 1000 + i;
                    [menuBtn addTarget:self action:@selector(menuBtnPressed:) forControlEvents:UIControlEventTouchDown];
                    [menuBtn setImage:[UIImage imageNamed:[normalImagesArr objectAtIndex:i]] forState:UIControlStateNormal];
                  
                    [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [self addSubview:menuBtn];
                    
                    [menuBtn setTitle:name forState:UIControlStateNormal];
                    menuBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 22, 15, 22);
//                    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//                    //                {top, left, bottom, right};
//                    
//                    //UIEdgeInsets insets = {top, left, bottom, right};
                    menuBtn.titleEdgeInsets = UIEdgeInsetsMake(25, -17, 0 , 0);
//
//                    
                    [menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
                    menuBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                    
                    [menuBtn.titleLabel setTextColor:[UIColor blackColor]];
                    if (i == 0) {
                        [menuBtn setImage:[UIImage imageNamed:[selectedImagesArr objectAtIndex:i]] forState:UIControlStateNormal];
                        [menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        [self setLastSelectedBtn:menuBtn];
                    }
                    
                    
                }
            }
            break;
        case MENU_TYPE_TAB_BAR_MENU:
            {
                float width = SCREEN_WIDTH / [itemNames count];
                float height = CGRectGetHeight(self.frame);
                
                for (int i = 0; i < [itemNames count]; i ++) {
                    
                    NSString * name = [itemNames objectAtIndex:i];
                    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    float w = width - 0.5f;
                    
                    if (i == 1 || i == [itemNames count] -1) {
                        w = width;
                    }
                    
                    menuBtn.frame = CGRectMake(width * i,0,w, height);
                    menuBtn.tag = 1000 + i;
                    [menuBtn addTarget:self action:@selector(menuBtnPressed:) forControlEvents:UIControlEventTouchDown];
                    [menuBtn setBackgroundImage:[UIImage imageNamed:[normalImagesArr objectAtIndex:i]] forState:UIControlStateNormal];
                    
                    [menuBtn setBackgroundImage:[UIImage imageNamed:[selectedImagesArr objectAtIndex:i]] forState:UIControlStateHighlighted];
                    [self addSubview:menuBtn];
                    
                    [menuBtn setTitle:name forState:UIControlStateNormal];
                    //                {top, left, bottom, right};
                    if (name.length == 2) {
                        menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0,-10, 0, 0);
                    }else{
                        menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
                    }
                    
                    [menuBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                    [menuBtn setTitleColor:COLOR_RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
                    [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
                    if (i == 0) {
                        [menuBtn setBackgroundImage:[UIImage imageNamed:[selectedImagesArr objectAtIndex:i]] forState:UIControlStateNormal];
                        [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        
                        CGRect frame = menuBtn.frame;
                        frame.origin.x --;
                        frame.size.width += 2;
                        menuBtn.frame = frame;
                        
                        [self setLastSelectedBtn:menuBtn];
                    }
                }
                UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 1, SCREEN_WIDTH, 1)];
                line.backgroundColor = [UIColor redColor];
                [self addSubview:line];
            }
            break;
        }
    }
    
}

- (void)setLastSelectedBtn:(UIButton *)btn
{
    if (_lastSelectedBtn) {
        _lastSelectedBtn = nil;
    }
    _lastSelectedBtn = btn;
}


- (void)setSelectedIndex:(int)index
{
    UIButton * sender = (UIButton *)[self viewWithTag:1000 + index];
    [self menuBtnPressed:sender];
}

- (void)refreshMenuBtnTitle:(NSArray *)menuTitles
{
    if ([menuTitles count] != [allBtns count]) return;
    
    for (int i = 0; i < [allBtns count]; i ++) {
        UIButton * btn = [allBtns objectAtIndex:i];
        NSString * title = [menuTitles objectAtIndex:i];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)menuBtnPressed:(UIButton *)sender
{
    int index = sender.tag - 1000;
    int lastIndex = _lastSelectedBtn.tag - 1000;
    NSLog(@"%d",index);
    
    if (index == lastIndex) return;
    
    switch (mType) {
        case MENU_TYPE_MAIN_MENU:
        {
            [sender setBackgroundImage:[UIImage imageNamed:[_selectedImgs objectAtIndex:index]] forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            
            [_lastSelectedBtn setBackgroundImage:[UIImage imageNamed:[_nomalImgs objectAtIndex:lastIndex]] forState:UIControlStateNormal];
            
            [_lastSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
        }
            break;
        case MENU_TYPE_MAIN_MENU_DING:{
            [sender setImage:[UIImage imageNamed:[_selectedImgs objectAtIndex:index]] forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            
            [_lastSelectedBtn setImage:[UIImage imageNamed:[_nomalImgs objectAtIndex:lastIndex]] forState:UIControlStateNormal];
            
            [_lastSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
            
        case MENU_TYPE_TAB_BAR_MENU:
        {
            CGRect frame = sender.frame;
            frame.origin.x --;
            frame.size.width += 2;
            sender.frame = frame;
            
            [sender setBackgroundImage:[UIImage imageNamed:[_selectedImgs objectAtIndex:index]] forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_lastSelectedBtn setBackgroundImage:[UIImage imageNamed:[_nomalImgs objectAtIndex:lastIndex]] forState:UIControlStateNormal];
            [_lastSelectedBtn setTitleColor:COLOR_RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
            
            frame = _lastSelectedBtn.frame;
            frame.origin.x ++;
            frame.size.width -= 2;
            _lastSelectedBtn.frame = frame;
            
            
        }
            break;
        default:
            break;
    }
    
    [self setLastSelectedBtn:sender];
    
    self.menuSelectedBlock(self,index,lastIndex);
    
    if (menuDelegate && [menuDelegate respondsToSelector:@selector(menuSelectedIndex:lastSelectedIndex:menuView:)]) {
        [menuDelegate menuSelectedIndex:index lastSelectedIndex:lastIndex menuView:self];
    }
}





//设置选中_不走代理
-(void)setCurrentIndex:(int)aIndex
{
    UIButton * sender = (UIButton *)[self viewWithTag:1000 + aIndex];
    int index = sender.tag - 1000;
    int lastIndex = _lastSelectedBtn.tag - 1000;
    NSLog(@"%d",index);
    
    if (index == lastIndex) return;
    
    switch (mType) {
        case MENU_TYPE_MAIN_MENU:
        {
            [sender setBackgroundImage:[UIImage imageNamed:[_selectedImgs objectAtIndex:index]] forState:UIControlStateNormal];
            [sender setTitleColor:COLOR_RGBA(36, 164, 202, 1) forState:UIControlStateNormal];
            
            
            [_lastSelectedBtn setBackgroundImage:[UIImage imageNamed:[_nomalImgs objectAtIndex:lastIndex]] forState:UIControlStateNormal];
            
            [_lastSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
        case MENU_TYPE_MAIN_MENU_DING:
        {
            [sender setBackgroundImage:[UIImage imageNamed:[_selectedImgs objectAtIndex:index]] forState:UIControlStateNormal];
            [sender setTitleColor:COLOR_RGBA(36, 164, 202, 1) forState:UIControlStateNormal];
            
            
            [_lastSelectedBtn setBackgroundImage:[UIImage imageNamed:[_nomalImgs objectAtIndex:lastIndex]] forState:UIControlStateNormal];
            
            [_lastSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
            
        case MENU_TYPE_TAB_BAR_MENU:
        {
            CGRect frame = sender.frame;
            frame.origin.x --;
            frame.size.width += 2;
            sender.frame = frame;
            
            [sender setBackgroundImage:[UIImage imageNamed:[_selectedImgs objectAtIndex:index]] forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_lastSelectedBtn setBackgroundImage:[UIImage imageNamed:[_nomalImgs objectAtIndex:lastIndex]] forState:UIControlStateNormal];
            [_lastSelectedBtn setTitleColor:COLOR_RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
            
            frame = _lastSelectedBtn.frame;
            frame.origin.x ++;
            frame.size.width -= 2;
            _lastSelectedBtn.frame = frame;
            
        }
            break;
        default:
            break;
    }
    
    [self setLastSelectedBtn:sender];
    
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

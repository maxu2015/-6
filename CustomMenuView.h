//
//  CustomMenuView.h
//  CaiLiFang
//
//  Created by  展恒 on 14-10-29.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
/*
 自定义的tabbar
 */
typedef enum MENU_TYPE
{
    MENU_TYPE_MAIN_MENU, //主页面菜单
    MENU_TYPE_TAB_BAR_MENU,//选项卡形式
    MENU_TYPE_MAIN_MENU_DING,
}MENU_TYPE;


@protocol CustomMenuViewDelegate;
@interface CustomMenuView : UIView


@property(nonatomic,assign) id<CustomMenuViewDelegate> menuDelegate;
@property(nonatomic,assign) MENU_TYPE mType;


@property(nonatomic,strong) void(^ menuSelectedBlock)(CustomMenuView *view,NSInteger selectedIndex,NSInteger lastSelectedIndex);

- (void)addMenuSelectedBlock:(void(^)(CustomMenuView *view,NSInteger selectedIndex,NSInteger lastSelectedIndex)) block;


- (id)initWithFrame:(CGRect)frame type:(MENU_TYPE)type;

- (void)initMenuBtns:(NSArray *)normalImagesArr selected:(NSArray *)selectedImagesArr itemNames:(NSArray *)itemNames;

//设置当前选择
- (void)setSelectedIndex:(int)index;
//刷新按钮的title
- (void)refreshMenuBtnTitle:(NSArray *)menuTitles;

//设置当前选中_代理不走
-(void)setCurrentIndex:(int)aIndex;
@end

@protocol CustomMenuViewDelegate <NSObject>
@optional

- (void)menuSelectedIndex:(NSInteger)index lastSelectedIndex:(NSInteger)lastIndex menuView:(CustomMenuView *)view;
@end

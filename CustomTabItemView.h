//
//  CustomTabItemView.h
//  baojia
//
//  Created by Zing on 14-8-5.
//  Copyright (c) 2014年 com.baojia.www. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TAB_ITEM_TYPE
{
    TAB_ITEM_TYPE_DEFAULT,
    
}TAB_ITEM_TYPE;

@protocol CustomTabItemViewDelegate;

@interface CustomTabItemView : UIView

@property(nonatomic , assign) id <CustomTabItemViewDelegate> delegate;
@property(nonatomic , assign) TAB_ITEM_TYPE tType;
@property(nonatomic , strong) void(^tabItemSelectedAtIndexBlock)(NSInteger index,CustomTabItemView * view);

- (void)tabItemSelectedAtIndexBlock:(void(^)(NSInteger index,CustomTabItemView * view)) block;

- (id)initWithFrame:(CGRect)frame type:(TAB_ITEM_TYPE)type;

- (void)initWithItemNames:(NSArray *)itemNames;

- (void)setSelectedIndex:(NSInteger)index;

- (void)setItemEnableStatusWithIndex:(NSInteger)index status:(BOOL)status;


@end


@protocol CustomTabItemViewDelegate <NSObject>
@optional
- (void)tabItemSelectedAtIndex:(NSInteger)index tabItem:(CustomTabItemView *)view;

@end
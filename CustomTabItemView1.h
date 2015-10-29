//
//  CustomTabItemView1.h
//  baojia
//
//  Created by Zing on 14-8-5.
//  Copyright (c) 2014年 com.baojia.www. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 下面带导航条的选项卡
 self.itemView = [[CustomTabItemView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 41) type:TAB_ITEM_TYPE_DEFAULT];
 self.itemView.delegate = self;
 [self.itemView initWithItemNames:@[@"申请提现",@"提现记录",@"收款账户"]];
 [self.view addSubview:self.itemView];
 */
typedef enum TAB_ITEM_TYPE1
{
    TAB_ITEM_TYPE_DEFAULT1,
    
}TAB_ITEM_TYPE1;

@protocol CustomTabItemView1Delegate;

@interface CustomTabItemView1 : UIView

@property(nonatomic , assign) id <CustomTabItemView1Delegate> delegate;
@property(nonatomic , assign) TAB_ITEM_TYPE1 tType;
@property(nonatomic , strong) void(^tabItemSelectedAtIndexBlock)(int index,CustomTabItemView1 * view);

- (void)tabItemSelectedAtIndexBlock:(void(^)(int index,CustomTabItemView1 * view)) block;

- (id)initWithFrame:(CGRect)frame type:(TAB_ITEM_TYPE1)type;

- (void)initWithItemNames:(NSArray *)itemNames;

- (void)setSelectedIndex:(int)index;

- (void)setItemEnableStatusWithIndex:(int)index status:(BOOL)status;

-(void)setBtnBackColor:(UIColor *)balocColr withTitleColor:(UIColor *)color;
@end


@protocol CustomTabItemView1Delegate <NSObject>
@optional
- (void)tabItemSelectedAtIndex:(int)index tabItem:(CustomTabItemView1 *)view;

@end
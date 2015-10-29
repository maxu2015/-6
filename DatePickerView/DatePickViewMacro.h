//
//  DatePickViewMacro.h
//  WeiNuo
//
//  Created by wshaolin on 14-8-4.
//
//

#define SYSTEM_VERSION_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define SCREEN_INCH_4 ([UIScreen mainScreen].bounds.size.height == 568)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define DATE_PICKER_VIEW_WIDTH SCREEN_WIDTH
#define DATE_PICKER_VIEW_HEIGHT (SCREEN_INCH_4 ? 260.0 : 200)
#define YARE_MONTH_PICKER_VIEW_HEIGHT 216.0

#define DATE_PICKER_VIEW_TOOLBAR_HEIGHT 44.0
#define DATE_PICKER_VIEW_TOOLBAR_ITEM_WIDTH 50.0

#define DATE_PICKER_VIEW_INTERVAL_CONTROL 0.0

#define TOOLBAR_ITEM_TEXT_COLOR [UIColor colorWithRed:21 / 255.0 green:47 / 255.0 blue:244 / 255.0 alpha:1.0]
#define TOOLBAR_ITEM_BG_COLOR [UIColor colorWithRed:216 / 255.0 green:216 / 255.0 blue:216 / 255.0 alpha:0.8]
#define DATE_PICKER_VIEW_BG_COLOR [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1.0]

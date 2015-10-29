//
//  GlobalConfig.h
//  Forum
//
//  Created by Lei Zhu on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "AppDelegate.h"

#ifndef GLOBAL_CONFIG
#define GLOBAL_CONFIG


#if DEBUG
//#define NSLog(...) NSLog(__VA_ARGS__)
//#define NSLog(s,...) NSLog(@"%s LINE:%d < %@ >",__FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
//#define NSLog(...) {}
#endif

#define ENABLE_APP_DEBUG YES //开启后打开debug模式

#define USEING_NETWORK YES

#define DEVICE_TOKEN @"devicetoken"
#define USER_INFO @"userinfo"

#define IS_4_INCH_SCREEN  (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)

#define IS_IOS_7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? YES : NO)

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height - ((IS_IOS_7) ? 0 : 20))
#define SCROLLVIEW_WIDTH  (830 -SCREEN_WIDTH) 

#define STATUS_HIGHT (IS_IOS_7) ? 20 : 0//状态栏高度

#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define DOCUMENT_DIRECTORY_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define BUNDLE_IDENTIFIER [[NSBundle mainBundle] bundleIdentifier]

#define BUNDLE_DISPLAY_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define BUNDLE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define DB_PATH [DOCUMENT_DIRECTORY_PATH stringByAppendingPathComponent:@"database.db"]

#define BUNDLE_FILE_PATH(filename)  [[NSBundle mainBundle] pathForAuxiliaryExecutable:filename]

#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]

#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a]

//判断字符串是否为nil,如果是nil则设置为空字符串
#define CHECK_STRING_IS_NULL(txt) txt = !txt ? @"" : txt

//判断Server返回数据是否为NSNull 类型 txt为参数 type为类型,like NSString,NSArray,NSDictionary
#define CHECK_DATA_IS_NSNULL(param,type) param = [param isKindOfClass:[NSNull class]] ? [type new] : param

#define NAV_BAR_HEIGHT (IS_IOS_7 ? 64 : 44)

#define TAB_BAR_HEIGHT 52

#define DEFAULT_REQUEST_PAGE_SIZE @"20"

#define NUMBERS @"0123456789\n"

#define DECIMAL_NUMBERS @"0123456789,.\n"



#define MAIN_GRAY_COLOR COLOR_RGBA(152,152,152,1) //主色调-灰色
#define MAIN_BLUE_COLOR COLOR_RGBA(51,188,218,1) //主色调-蓝色
#define MAIN_ORANGE_COLOR COLOR_RGBA(240,133,25,1) //主色调-橘黄色
#define MAIN_BLACK_COLOR COLOR_RGBA(54,54,54,1) //主色调-黑色

//标题字号大小
#define TITLELABEL_FONT 20
//绿色 #72B240;R114 G178 B64
#define GREENCOLOR  COLOR_RGBA(114,178,64,1)


#endif



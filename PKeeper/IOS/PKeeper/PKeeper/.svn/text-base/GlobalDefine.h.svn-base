//
//  define.h
//  mobilevideo
//
//  Created by 田祥根 on 14-5-15.
//  Copyright (c) 2014年 spinshine. All rights reserved.
//

#ifndef prj_mobilevideo_globaldefine_h
#define prj_mobilevideo_globaldefine_h

// Color
#define FONT(font) [UIFont systemFontOfSize:font]
#define RGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB(r,g,b)     RGBA(r,g,b,1.0f)
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IOS7      [[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0
#define IS_IPHONE_5                (fabs([[UIScreen mainScreen] bounds].size.height - 568.f) < DBL_EPSILON)

#define Y_OFFSET (IS_IOS7?20:0)

#define TABBARHEIGHT 49

#define SCREENSCALE [[UIScreen mainScreen] scale]

#define SCREENWIDTH  [[UIScreen mainScreen] bounds].size.width

#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

#define DEFAULTIMAGE [UIImage imageNamed:@"defaultImage"]

#define STRFORMAT(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//空间间距
#define CONTROLSAPCE 5

//系统文件路径
#define DOCUMENTS_DIR     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define IMAGESPACE 10  //图片间距

//NSLog宏
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//username&password沙盒宏
#define USERNAME @"pk_username"
#define PASSWORD @"pk_password"

//单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
    - (__class *)shareInstance; \
    + (__class *)shareInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
    - (__class *)shareInstance \
    { \
        return [__class shareInstance]; \
    } \
    + (__class *)shareInstance \
    { \
        static dispatch_once_t once; \
        static __class * __singleton__; \
        dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
        return __singleton__; \
    }



#endif

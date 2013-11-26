//
//  AppInfo.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/11/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#ifndef BorusanBMW_AppInfo_h
#define BorusanBMW_AppInfo_h

#import "Resources.h"
#import "Colors.h"

// App constant values
#define kStatusBarHeight 20.0f
#define kNavigationBarHeight 44.0f
#define kTextTopScrollGap 10.0f

#define kWindowWidth            ([[UIScreen mainScreen] bounds].size.width)
#define kWindowHeight           ([[UIScreen mainScreen] bounds].size.height)
#define kWindowHeightWithStatus ([[UIScreen mainScreen] bounds].size.height - kStatusBarHeight)
#define kWindowHeightWithNav    ([[UIScreen mainScreen] bounds].size.height - kStatusBarHeight - kNavigationBarHeight)

#define append(A,B) [(A) stringByAppendingString:(B)]
#define kApplicationFontBold(fontSize) [UIFont fontWithName:@"Helvetica-Bold" size:fontSize]
#define kApplicationFont(fontSize) [UIFont fontWithName:@"Helvetica" size:fontSize]
#define kApplicationFontLight(fontSize) [UIFont fontWithName:@"Helvetica-Light" size:fontSize]
#define kApplicationImage(imageName) [UIImage imageNamed:imageName]
#define kFontName @"Helvetica";

#define kTextColorPlaceHolder RGB(146.0f 146.0f 146.0f)
#define kTextColor RGB(61.0f, 61.0f, 61.0f)
#define kTextColorLight RGB(92.0f, 92.0f, 92.0f)
#define kTextboxImage [UIImage imageNamed:kResTextbox];

#define kNotificationList [NSArray arrayWithObjects:@"Hasar Var", @"Araç Çekiliyor", @"Camlar Açık", @"Bagaj Açık", @"Lastik Patlak",nil]

// System Check Macros
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define kCurrentTime [[NSDate date] timeIntervalSince1970]

// TEST CASES
#define TEST_MODE 0

#endif

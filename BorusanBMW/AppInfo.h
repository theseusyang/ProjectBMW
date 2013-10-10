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

#define append(A,B) [(A) stringByAppendingString:(B)]

#define kWindowHeight ([[UIScreen mainScreen] bounds].size.height - kStatusBarHeight)
#define kWindowWidth [[UIScreen mainScreen] bounds].size.width

#define kWindowHeightWithNav ([[UIScreen mainScreen] bounds].size.height - kStatusBarHeight - kNavigationBarHeight)

#define kApplicationFontBold(fontSize) [UIFont fontWithName:@"Helvetica-Bold" size:fontSize]
#define kApplicationFont(fontSize) [UIFont fontWithName:@"Helvetica" size:fontSize]
#define kApplicationFontLight(fontSize) [UIFont fontWithName:@"Helvetica-Light" size:fontSize]
#define kApplicationImage(imageName) [UIImage imageNamed:imageName]
#define kFontName @"Helvetica";

#define kTextColor RGB(61, 61, 61)
#define kTextColorLight RGB(92, 92, 92)
#define kTextboxImage [UIImage imageNamed:kResTextbox];

#define kNotificationList [NSArray arrayWithObjects:@"Hasar Var", @"Araç Çekiliyor", @"Camlar Açık", @"Bagaj Açık", @"Lastik Patlak",nil]

// App constant values
#define kStatusBarHeight 20.0f
#define kNavigationBarHeight 44.0f
#define kTextTopScrollGap 10

#endif

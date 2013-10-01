//
//  AppInfo.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/11/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#ifndef BorusanBMW_AppInfo_h
#define BorusanBMW_AppInfo_h

#define append(A,B) [(A) stringByAppendingString:(B)]

#define kStatusBarHeight 20.0f;
#define kNavigationBarHeight 44.0f;

#define kWindowHeight ([[UIScreen mainScreen] bounds].size.height - kStatusBarHeight)
#define kWindowWidth [[UIScreen mainScreen] bounds].size.width

#define kWindowHeightWithNav ([[UIScreen mainScreen] bounds].size.height - kNavigationBarHeight)

#define kApplicationFontBold(fontSize) [UIFont fontWithName:@"HelveticaNeueLTPro-BdCn" size:fontSize]
#define kApplicationFontMedium(fontSize) [UIFont fontWithName:@"HelveticaNeueLTPro-MdCn" size:fontSize]
#define kApplicationFontLight(fontSize) [UIFont fontWithName:@"HelveticaNeueLTPro-LtCn" size:fontSize]

#endif

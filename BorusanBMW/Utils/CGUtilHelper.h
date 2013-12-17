//
//  CGUtilHelper.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/11/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGUtilHelper : NSObject

+ (void)showAvailableFonts;
+ (NSString*)dateFromJSONStringWith:(NSString*)date;
+ (NSString *)currentDate;
+ (NSDate *)dateFormatFromJSONString:(NSString *)string;
+ (UIImage *)imageWithImage:(UIImage *)image andRect:(CGRect)newRect;
+ (CGRect)imageRectInSquare:(UIImage *)image;
+ (UIImage *)imageMakeSmaller:(UIImage *)image factor:(int)factor;

@end

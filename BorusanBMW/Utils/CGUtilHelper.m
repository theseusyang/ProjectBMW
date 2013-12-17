//
//  CGUtilHelper.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/11/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGUtilHelper.h"

@implementation CGUtilHelper

+ (void)showAvailableFonts
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    
    int indexFamilyName;
    int indexFontName;
    
    for (indexFamilyName = 0; indexFamilyName < [familyNames count]; ++indexFamilyName) {
        
        NSLog(@"Family name = %@", [familyNames objectAtIndex:indexFamilyName]);
        
        fontNames = [[NSArray alloc] initWithArray:
                    [UIFont fontNamesForFamilyName:
                    [familyNames objectAtIndex:indexFamilyName]]];
        
        for (indexFontName = 0; indexFontName < [fontNames count]; ++indexFontName) {
            NSLog(@"       Font name = %@", [fontNames objectAtIndex:indexFontName]);
        }
        
    }
}

+ (NSString*)dateFromJSONStringWith:(NSString*)string;
{
    //TODO: +0300 datası ile kullanınca kaydı 3 saat ilerde yapılmış gösteriyo.
    //Bu geçici çözüm, backend tarafından bunun halledilmesi gerekiyor.
    string = [string stringByReplacingOccurrencesOfString:@"+0300)/" withString:@"+0000)/"];
    
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
        if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:seconds];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *loc = [[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"];
        [dateFormat setDateFormat:@"dd MMM yyyy, hh:mm"];
        [dateFormat setLocale:loc];
        
        return [dateFormat stringFromDate:date];
    }
    return nil;
}

+ (NSString *)currentDate
{
    NSDate* date = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *loc = [[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"];
    [dateFormat setDateFormat:@"dd MMM yyyy, hh:mm"];
    [dateFormat setLocale:loc];
    
    return [dateFormat stringFromDate:date];
}

+ (NSDate *)dateFormatFromJSONString:(NSString *)string
{
    //TODO: +0300 datası ile kullanınca kaydı 3 saat ilerde yapılmış gösteriyo.
    //Bu geçici çözüm, backend tarafından bunun halledilmesi gerekiyor.
    string = [string stringByReplacingOccurrencesOfString:@"+0300)/" withString:@"+0000)/"];
    
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:seconds];
        return date;
    }
    
    return nil;
}

+ (UIImage *)imageWithImage:(UIImage *)image andRect:(CGRect)newRect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, newRect);
    UIImage *newImage   = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    return newImage;
}

+ (CGRect)imageRectInSquare:(UIImage *)image
{
    CGRect square;
    CGPoint cutPoint;
    
    float width = image.size.width;
    float height = image.size.height;
    
    float finalWidth = 0.0;
    float finalHeight = 0.0;
    
    if (width > height)
    {
        int diff = width - height;
        int leftCut = diff / 2;
        
        finalWidth  = height;
        finalHeight = height;
        
        cutPoint = CGPointMake(leftCut, 0);
    }else if(height > width)
    {
        float diff = height - width;
        int topCut = diff / 2;
        
        finalWidth  = width;
        finalHeight = width;
        
        cutPoint = CGPointMake(0, topCut);
    }else
    {
        finalWidth = width;
        finalHeight = height;
        cutPoint = CGPointMake(0, 0);
    }
    
    square = CGRectMake(cutPoint.x, cutPoint.y, finalWidth, finalHeight);
    return square;
}

+ (UIImage *)imageMakeSmaller:(UIImage *)image factor:(int)factor
{
    NSLog(@"width %f height %f", image.size.width, image.size.height);
    
    float widthFloat  = image.size.width/factor;
    float heightFloat = image.size.height/factor;
    
    int width = widthFloat;
    int height = heightFloat;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0,0,width, height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = nil;
    
    return newImage;
}

static inline double radians (double degrees) {return degrees * M_PI/180;}
+ (UIImage *)rotateWithFrame:(UIImage *)src orientation:(UIImageOrientation)orientation
{
    UIGraphicsBeginImageContext(src.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, radians(90));
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, radians(-90));
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, radians(90));
    }
    
    [src drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}

@end


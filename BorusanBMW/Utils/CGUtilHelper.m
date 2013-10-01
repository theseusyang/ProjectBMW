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

@end

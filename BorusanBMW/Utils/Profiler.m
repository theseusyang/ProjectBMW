//
//  Profiler.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/30/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "Profiler.h"

#define kCurrentTime [[NSDate date] timeIntervalSince1970]

@implementation Profiler

static NSString *_profileName = @"";
static NSTimeInterval _currentTime = -1;
static NSTimeInterval _totalTime = 0;

+ (void)start:(NSString *)profileName{
    
    _profileName = profileName;
    _currentTime = kCurrentTime;
}

+ (NSString*)stop{
    
    NSTimeInterval elapsedTime = kCurrentTime - _currentTime;
    _totalTime += elapsedTime;
    NSLog(@"%@ result is: %f", _profileName, elapsedTime);
    return [NSString stringWithFormat:@"%f", elapsedTime];
}

+ (NSString *)totalTime
{
    float total = _totalTime;
    _totalTime = 0;
    return [NSString stringWithFormat:@"%f", total];
}

@end

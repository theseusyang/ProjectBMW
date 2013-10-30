//
//  Profiler.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/30/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profiler : NSObject

+ (void)start:(NSString *)profileName;
+ (NSString*)stop;
+ (NSString *)totalTime;

@end

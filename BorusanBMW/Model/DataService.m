//
//  DataService.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "DataService.h"

@implementation DataService

+ (DataService*)shared
{
    static DataService* instance = nil;
    if (!instance) {
        instance = [[DataService alloc] init];
    }
    
    return instance;
}

- (void)setHash:(NSString*)hash
{
    _hash = hash;
}

- (NSString*)getHash
{
    return _hash;
}

@end

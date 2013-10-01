//
//  DataService.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject
{
    NSString *_hash;
}

+ (DataService*)shared;

- (void)setHash:(NSString*)hash;
- (NSString*)getHash;

@end

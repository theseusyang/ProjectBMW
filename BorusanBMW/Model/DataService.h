//
//  DataService.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/ObjectMapping.h>
#import "Server.h"

@interface DataService : NSObject
{
    NSString *_hash;
    
    NSMutableArray *_vehicleDataList;
    int _vehiclePageIndex;
}

+ (DataService*)shared;

- (void)setHash:(NSString*)hash;
- (NSString*)getHash;

@end

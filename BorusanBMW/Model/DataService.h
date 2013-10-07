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

#define kDataPackageSize 20

@interface DataService : NSObject
{
    NSString *_hash;
    
    NSMutableArray *_vehicleDataList;
}

@property int vehiclePageIndex;
@property BOOL isLastPageReached;

+ (DataService*)shared;

- (NSMutableArray*)getVehicleListWithSuccess:(void (^)(NSArray *vehicleList))success
                                     failure:(void (^)(NSError* error))failure;
- (NSMutableArray*)updateVehicleListWithSuccess:(void (^)(NSArray *vehicleList))success
                                        failure:(void (^)(NSError* error))failure;
- (NSMutableArray*)getVehicleList;
- (void)setHash:(NSString*)hash;
- (NSString*)getHash;

@end

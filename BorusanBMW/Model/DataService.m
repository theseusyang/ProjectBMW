//
//  DataService.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "DataService.h"

#define kMaxVehicleCapacity 600

@implementation DataService

+ (DataService*)shared
{
    static DataService* instance = nil;
    if (!instance) {
        instance = [[DataService alloc] init];
    }
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _vehiclePageIndex = 1;
        
        _vehicleDataList = [[NSMutableArray array] mutableCopy];
        
       self.isLastPageReached = NO;
    }
    
    return self;
}

- (NSMutableArray*)getVehicleListWithSuccess:(void (^)(NSArray *vehicleList))success
                                     failure:(void (^)(NSError* error))failure
{
    [[Server shared] getVehicleListWithHash:[self getHash] pageIndex:_vehiclePageIndex success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

        if (!_vehicleDataList || _vehicleDataList.count <= 0) {
             _vehicleDataList = [NSMutableArray arrayWithArray:[mappingResult array]];
        }
        else{
            NSArray *array = [mappingResult array];
            _vehicleDataList = (NSMutableArray*)[_vehicleDataList arrayByAddingObjectsFromArray:array];
        }
        
        if ([mappingResult array].count < kDataPackageSize) {
            self.isLastPageReached = YES;
        }
        
        _vehiclePageIndex++;
        success(_vehicleDataList);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    return nil;
}

- (NSMutableArray*)updateVehicleListWithSuccess:(void (^)(NSArray *vehicleList))success
                                     failure:(void (^)(NSError* error))failure
{
    [[Server shared] getVehicleListWithHash:[self getHash] pageIndex:_vehiclePageIndex success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        if (!_vehicleDataList || _vehicleDataList.count <= 0) {
            _vehicleDataList = [NSMutableArray arrayWithArray:[mappingResult array]];
        }
        else{
            NSArray *array = [mappingResult array];
            _vehicleDataList = [[_vehicleDataList arrayByAddingObjectsFromArray:array] mutableCopy];
        }
        
        if ([mappingResult array].count < kDataPackageSize) {
            self.isLastPageReached = YES;
        }
        
        _vehiclePageIndex++;
        success(_vehicleDataList);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    return nil;
}

- (void)addRecord:(VehicleListResponse*)vehicleRecord
{
    if (vehicleRecord == nil) {
        NSLog(@"[DataService] addRecord: Vehicle is null!");
        return;
    }
    
    _vehicleDataList = (NSMutableArray*)[_vehicleDataList arrayByAddingObjectsFromArray:@[vehicleRecord]];
}

- (void)deleteRecord:(VehicleListResponse *)vehicleRecord
{
    if (vehicleRecord == nil) {
        NSLog(@"[DataService] addRecord: Vehicle is null!");
        return;
    }
    
    [_vehicleDataList removeObject:vehicleRecord];
}

#pragma mark GETTER & SETTER
- (NSMutableArray*)getVehicleList
{
    return _vehicleDataList;
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

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

- (id)init
{
    self = [super init];
    if (self) {
        
        _vehiclePageIndex = 1;
        
    }
    
    return self;
}

- (NSMutableArray*)getVehicleList
{
    /*
    //Get vehice list
    [[Server shared] getVehicleListWithHash:[self getHash] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

        _vehicleList = [[mappingResult array] mutableCopy];
        _vehicleImageList = [[NSMutableArray alloc] init];
        
        for (VehicleListResponse* vehicle in _vehicleList) {
            if (vehicle.imageList.count <= 0)
                continue;
            
            // Create appropriate image list for each vehicle element in vehicleList
            NSArray *base64List = vehicle.imageList;
            for (int i=0; i < [base64List count]; ++i) {
                
                NSString *imageStr = (NSString*)base64List[i];
                NSData *data = [Base64 decode:imageStr];
                UIImage *image = [UIImage imageWithData:data];
                
                [_vehicleImageList addObject:image];
            }
            
            vehicle.imageList = [NSMutableArray arrayWithArray:_vehicleImageList];
            [_vehicleImageList removeAllObjects];
     
    }];
    */
    return nil;
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

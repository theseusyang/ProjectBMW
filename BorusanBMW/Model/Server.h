//
//  Server.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/18/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/RKObjectManager.h>
#import <RestKit/ObjectMapping.h>

#import "LoginResponse.h"
#import "LoginRequest.h"
#import "RecordResponse.h"
#import "VehicleListResponse.h"
#import "DataService.h"

typedef NS_ENUM(NSInteger, kNotificationType){
    
    kNotificationDamage,
    kNotificationWindows
};

@interface Server : NSObject
{
    RKObjectManager *_manager;
}

+ (Server *)shared;

- (void)insertVehicleWithPlate:(NSString*)plate
                 serviceType:(NSString*)serviceType
            notificationType:(NSNumber*)notificationType
                 description:(NSString*)description
                    location:(NSString*)location
                   imageList:(NSArray*)imageList
                     success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)updateVehicleWithPlate:(NSString*)plate
                   serviceType:(NSString*)serviceType
              notificationType:(NSNumber*)notificationType
                   description:(NSString*)description
                      location:(NSString*)location
                            ID:(NSNumber*)ID
                       success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)loginWithUsername:(NSString*)username
                 password:(NSString*)password
                  success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                  failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)getVehicleWithID:(NSInteger*)ID
                    hash:(NSString*)hash
                 success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)getVehicleListWithHash:(NSString*)hash
                       success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end


//
//  Server.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/18/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "Server.h"

// WEB SERVICE BASE URL
#define kServerPath @"http://wecareservice.ogoodigital.com/Services/Mobile.svc/"

// BACKEND SERVICE
#define kFuncInsertVecihle @"InsertVehicle"
#define kFuncUpdateVecihle @"UpdateVehicle"
#define kFuncLogin @"Login"
#define kFuncGetVehicle @"GetVehicle"
#define kFuncGetVechicleList @"GetVehicleList"

/*Response KeyPaths*/
#define kPathLoginResponse @"LoginResult"
#define kPathGetVehicleListResponse @"GetVehicleListResult"

@implementation Server

+ (Server *)shared
{
    static Server *instance = nil;
    if (instance == nil) {
        instance = [[Server alloc] init];
    }
    
    return instance;
}
                    
- (id)init
{
    self = [super init];
    if (self) {

        _manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kServerPath]];
       
        [RKObjectManager setSharedManager:_manager];
        [[RKObjectManager sharedManager] setRequestSerializationMIMEType:RKMIMETypeJSON];
        [self setResponseDescriptors];
        
        // TODO: Delete later
        NSDictionary *defaultHeaders = [[RKObjectManager sharedManager] defaultHeaders];
        NSLog(@"%@", defaultHeaders);
    }
    
    return self;
}

- (void)setResponseDescriptors
{
    RKResponseDescriptor *loginDesc = [RKResponseDescriptor responseDescriptorWithMapping:[LoginResponse objectMapping]
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:kPathLoginResponse
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *recordDesc = [RKResponseDescriptor responseDescriptorWithMapping:[RecordResponse objectMapping]
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:nil
                                                                                  keyPath:nil
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *getVehicleDesc = [RKResponseDescriptor responseDescriptorWithMapping:[VehicleListResponse objectMapping]
                                                                                        method:RKRequestMethodAny
                                                                                   pathPattern:nil
                                                                                       keyPath:kPathGetVehicleListResponse
                                                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [_manager addResponseDescriptorsFromArray:@[loginDesc, recordDesc, getVehicleDesc]];
}

- (void)insertVehicleWithPlate:(NSString*)plate
                   serviceType:(NSString*)serviceType
              notificationType:(NSNumber*)notificationType
                   description:(NSString*)description
                      location:(NSString*)location
                     imageList:(NSArray*)imageList
                       success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    NSDictionary *recordRequest = @{@"Plate": plate,
                                    @"ServiceType": serviceType,
                                    @"NotificationType": [notificationType stringValue],
                                    @"Explanation": description,
                                    @"Location": location,
                                    @"Hash": [[DataService shared] getHash],
                                    @"ImageList": imageList};
    
    [[RKObjectManager sharedManager] postObject:nil path:kFuncInsertVecihle parameters:recordRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(operation, mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"insertVehicleWithPlate is Failure");
        UIAlertView *alertPopup = [[UIAlertView alloc] initWithTitle:@"Create Record"
                                                             message:@"InsertVehicle request is failed!"
                                                            delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertPopup show];
    }];
}

- (void)updateVehicleWithPlate:(NSString*)plate
                   serviceType:(NSString*)serviceType
              notificationType:(NSNumber*)notificationType
                   description:(NSString*)description
                      location:(NSString*)location
                            ID:(NSNumber*)ID
                       success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    NSDictionary *recordUpdateRequest = @{@"Plate": plate,
                                          @"ServiceType": serviceType,
                                          @"NotificationType": [notificationType stringValue],
                                          @"Explanation": description,
                                          @"Location": location,
                                          @"ID": ID,
                                          @"Hash": [[DataService shared] getHash]};
    
    
    [[RKObjectManager sharedManager] getObject:nil path:kFuncUpdateVecihle parameters:recordUpdateRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(operation, mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"insertVehicleWithPlate is Failure");
    }];
}

- (void)loginWithUsername:(NSString*)username
                 password:(NSString*)password
                  success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                  failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    /* Create LoginRequest object*/
    /* Define LoginRequest class which corresponds to this */
    NSDictionary *loginRequest = @{@"Username" : username,
                                   @"Password" : password};

    [[RKObjectManager sharedManager] getObjectsAtPath:kFuncLogin parameters:loginRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

        
        LoginResponse *loginResponse = (LoginResponse*)[mappingResult array][0];
        [[DataService shared] setHash:loginResponse.hash];
        success(operation, mappingResult);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"loginRequest is Failure");
        failure(operation, error);
    }];
}

- (void)getVehicleWithID:(NSInteger*)ID
                    hash:(NSString*)hash
                 success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    //
}

- (void)getVehicleListWithHash:(NSString*)hash
                     pageIndex:(int)pageIndex
                       success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    NSDictionary *vehicleListRequest = @{@"Hash": hash,
                                         @"PageIndex": [NSNumber numberWithInt:pageIndex]};
    
    [[RKObjectManager sharedManager] getObject:nil path:kFuncGetVechicleList parameters:vehicleListRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(operation, mappingResult);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"vehicleListRequest is Failure");
    }];
}

@end

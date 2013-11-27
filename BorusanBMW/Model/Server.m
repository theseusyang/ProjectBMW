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
#define kFuncLogin @"Login"
#define kFuncInsertVecihle @"InsertVehicle"
#define kFuncUpdateVecihle @"UpdateVehicle"
#define kFuncGetVehicle @"GetVehicle"
#define kFuncGetVechicleList @"GetVehicleList"
#define kFuncGetNotificationTypes @"GetNotificationType"
#define kFuncDeleteVehicle @"DeleteVehicle"

/*Response KeyPaths*/
#define kPathLoginResponse @"LoginResult"
#define kPathGetVehicleListResponse @"GetVehicleListResult"
#define kPathGetNotificationTypeResponse @"GetNotificationTypeResult"
#define kPathUpdateVehicleResponse @"UpdateVehicleResult"
#define kPathInsertVehicleResponse @"InsertVehicleResult"
#define kPathDeleteVehicleResponse @"DeleteVehicleResult"

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
    
    RKResponseDescriptor *recordDesc = [RKResponseDescriptor responseDescriptorWithMapping:[VehicleListResponse objectMapping]
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:nil
                                                                                  keyPath:kPathInsertVehicleResponse
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *getVehicleDesc = [RKResponseDescriptor responseDescriptorWithMapping:[VehicleListResponse objectMapping]
                                                                                        method:RKRequestMethodAny
                                                                                   pathPattern:nil
                                                                                       keyPath:kPathGetVehicleListResponse
                                                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *getVehicleNotificationType = [RKResponseDescriptor responseDescriptorWithMapping:[NotificationTypeResponse objectMapping]
                                                                                                    method:RKRequestMethodAny
                                                                                               pathPattern:nil
                                                                                                   keyPath:kPathGetNotificationTypeResponse
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *deleteRecordDesc = [RKResponseDescriptor responseDescriptorWithMapping:[DeleteResponse objectMapping]
                                                                                                    method:RKRequestMethodAny
                                                                                               pathPattern:nil
                                                                                                   keyPath:kPathDeleteVehicleResponse
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    RKResponseDescriptor *updateResponseDec = [RKResponseDescriptor responseDescriptorWithMapping:[UpdateResponse objectMapping]
                                                                                                    method:RKRequestMethodAny
                                                                                               pathPattern:nil
                                                                                                   keyPath:nil
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [_manager addResponseDescriptorsFromArray:@[loginDesc, recordDesc, getVehicleDesc, getVehicleNotificationType, updateResponseDec, deleteRecordDesc]];
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
    if (location == nil) {
        NSLog(@"Location is nil! Use default location data.");
        location = @"Default Location";
    }
    
    NSDictionary *recordRequest = @{@"Plate": plate,
                                    @"ServiceType": serviceType,
                                    @"NotificationType": notificationType,
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
                                          @"NotificationType": notificationType,
                                          @"Explanation": description,
                                          @"Location": location,
                                          @"ID": ID,
                                          @"Hash": [[DataService shared] getHash]};
    
    
    [[RKObjectManager sharedManager] postObject:nil path:kFuncUpdateVecihle parameters:recordUpdateRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(operation, mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"insertVehicleWithPlate is Failure");
        failure(operation, error);
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
        failure(operation, error);
        NSLog(@"vehicleListRequest is Failure");
    }];
}

- (void)getNotificationTypesWithSuccess:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    [[RKObjectManager sharedManager] getObjectsAtPath:kFuncGetNotificationTypes parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(operation, mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

- (void)deleteVehicleRecordWithHash:(NSString *)hash ID:(NSNumber *)ID
                            success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                            failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    
    NSDictionary *vehicleDeleteRequest = @{@"Hash": hash,
                                         @"ID": ID};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kFuncDeleteVehicle parameters:vehicleDeleteRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(operation, mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

@end

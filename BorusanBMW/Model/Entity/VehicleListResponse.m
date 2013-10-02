//
//  VehicleListResponse.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/24/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "VehicleListResponse.h"

@implementation VehicleListResponse

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* objectMapping = [RKObjectMapping mappingForClass:[self class]];
    [objectMapping addAttributeMappingsFromDictionary:@{@"CreatedDate": @"createdDate",
                                                        @"Explanation": @"description",
                                                        @"ID": @"ID",
                                                        @"Location": @"location",
                                                        @"NotificationType": @"notificationType",
                                                        @"Plate": @"licensePlate",
                                                        @"ServiceType": @"serviceType",
                                                        @"ImageList": @"imageList"}];
    
    return objectMapping;
}

@end

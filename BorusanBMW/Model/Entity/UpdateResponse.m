//
//  UpdateResponse.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "UpdateResponse.h"

@implementation UpdateResponse

+ (RKObjectMapping*)objectMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[self class]];
    [objectMapping addAttributeMappingsFromDictionary:@{@"UpdateVehicleResult": @"updateResult"}];
    
    return objectMapping;
}

@end

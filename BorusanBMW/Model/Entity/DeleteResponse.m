//
//  DeleteResponse.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 11/27/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "DeleteResponse.h"

@implementation DeleteResponse

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{@"DeleteVehicleResult": @"result"}];
    
    return mapping;
}

@end

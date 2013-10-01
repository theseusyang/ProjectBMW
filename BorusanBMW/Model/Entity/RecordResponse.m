//
//  RecordResponse.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "RecordResponse.h"

@implementation RecordResponse

+ (RKObjectMapping*)objectMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[self class]];
    [objectMapping addAttributeMappingsFromDictionary:@{@"InsertVehicleResult": @"recordResult"}];
    
    return objectMapping;
}

@end

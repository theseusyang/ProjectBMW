//
//  LoginResponse.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    
    return self;
}

+ (RKObjectMapping*)objectMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[LoginResponse class]];
    [objectMapping addAttributeMappingsFromDictionary:@{@"ErrorCode": @"errorCode",
                                                        @"ErrorMessage": @"errorMessage",
                                                        @"Hash": @"hash",
                                                        @"Status": @"status"}];
    
    return objectMapping;
}

@end

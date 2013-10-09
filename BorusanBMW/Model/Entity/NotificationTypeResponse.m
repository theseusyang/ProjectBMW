//
//  NotificationTypeResponse.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/8/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "NotificationTypeResponse.h"

@implementation NotificationTypeResponse

+ (RKObjectMapping*)objectMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[NotificationTypeResponse class]];
    [objectMapping addAttributeMappingsFromDictionary:@{@"ID": @"ID",
                                                        @"NotificationType": @"notificationType"}];
    
    return objectMapping;
}

@end

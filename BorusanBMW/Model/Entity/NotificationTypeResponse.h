//
//  NotificationTypeResponse.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/8/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/ObjectMapping.h>

@interface NotificationTypeResponse : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *notificationType;

+ (RKObjectMapping*)objectMapping;

@end

//
//  VehicleListResponse.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/24/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/ObjectMapping.h>

@interface VehicleListResponse : NSObject

@property (nonatomic, strong) NSString* createdDate;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSNumber* ID;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSNumber* notificationType;
@property (nonatomic, strong) NSString* licensePlate;
@property (nonatomic, strong) NSString* serviceType;
@property (nonatomic, retain) NSMutableArray*  imageList;

+ (RKObjectMapping *)objectMapping;

@end

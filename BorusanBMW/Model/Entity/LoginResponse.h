//
//  LoginResponse.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/ObjectMapping.h>

@interface LoginResponse : NSObject

@property (nonatomic, strong) NSString* errorCode;
@property (nonatomic, strong) NSString* errorMessage;
@property (nonatomic, strong) NSString* hash;
@property (nonatomic) NSNumber* status;

+ (RKObjectMapping*)objectMapping;

@end

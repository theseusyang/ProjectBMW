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
{
    NSString* _errorCode;
}

@property (nonatomic, copy) NSString* errorCode;
@property (nonatomic, copy) NSString* errorMessage;
@property (nonatomic, copy) NSString* hash;
@property (nonatomic) NSNumber* status;

+ (RKObjectMapping*)objectMapping;

@end

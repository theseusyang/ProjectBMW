//
//  DeleteResponse.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 11/27/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface DeleteResponse : NSObject

@property (nonatomic, strong) NSString *result;

+ (RKObjectMapping *)objectMapping;

@end

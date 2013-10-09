//
//  UpdateResponse.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface UpdateResponse : NSObject

@property (nonatomic, assign) BOOL updateResult;

+ (RKObjectMapping*)objectMapping;

@end

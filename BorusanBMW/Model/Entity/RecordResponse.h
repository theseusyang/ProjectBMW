//
//  RecordResponse.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/20/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/ObjectMapping.h>

@interface RecordResponse : NSObject

@property (nonatomic) BOOL recordResult;

+ (RKObjectMapping*)objectMapping;

@end

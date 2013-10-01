//
//  CGLabel.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/11/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGLabel.h"

@implementation CGLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textColor         = kTextColor;
        self.font              = kApplicationFontBold(15.0f);
        self.backgroundColor   = kColorClear;
    }
    return self;
}


@end

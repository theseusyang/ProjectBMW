//
//  CGTextField.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/5/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGTextField.h"

@implementation CGTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.paddingX = 10.0f;
        self.paddingY = 10.0f;
        
        self.clearsOnInsertion = true;
        self.textColor         = kTextColor;
        self.font              = kApplicationFont(19.0f);
        self.placeholder       = @"Default PlaceHolder.";
        self.background        = kTextboxImage;
        self.text              = @"";
    }
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.paddingX, self.paddingY);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    UIView *leftView = self.leftView;
    
    if (leftView)
        return CGRectMake(leftView.frame.origin.x, leftView.frame.origin.y, leftView.frame.size.width, leftView.frame.size.height);
    
    return bounds;
}

@end

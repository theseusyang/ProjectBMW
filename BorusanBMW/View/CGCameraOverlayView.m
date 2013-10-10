//
//  CGCameraOverlayView.m
//  BorusanBMW
//
//  Created by Bahadır Böge on 10/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGCameraOverlayView.h"

@implementation CGCameraOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //_footerImage = [[UIImageView alloc] initWithImage:kApplicationImage(kResContentFooter)];
        //_footerImage.frame = CGRectMake(0, 0, 320, 55);
        //[self addSubview:_footerImage];

        
        _newButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 366, 93, 48)];
        [_newButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
        [_newButton setTitle:@"Yeni" forState:UIControlStateNormal];
        [_newButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_newButton addTarget:self action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_newButton];
        
        _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 333, 110, 83)];
        [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapture) forState:UIControlStateNormal];
        [_captureButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_captureButton];
        
        _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(221, 366, 93, 48)];
        [_continueButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
        [_continueButton setTitle:@"Devam" forState:UIControlStateNormal];
        [_continueButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_continueButton];
    }
    return self;
}

- (id) init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 460)];
    if (self) {
        _footerImage = [[UIImageView alloc] initWithImage:kApplicationImage(kResContentFooter)];
        _footerImage.frame = CGRectMake(0, 425, 320, 55);
        [self addSubview:_footerImage];
        
        _newButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 430, 93, 48)];
        [_newButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
        [_newButton setTitle:@"Yeni" forState:UIControlStateNormal];
        [_newButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_newButton addTarget:self action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_newButton];
        
        _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 397, 110, 83)];
        [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapture) forState:UIControlStateNormal];
        [_captureButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_captureButton];
        
        _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(221, 430, 93, 48)];
        [_continueButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
        [_continueButton setTitle:@"Devam" forState:UIControlStateNormal];
        [_continueButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_continueButton];
        
    }
    return self;
}

-(IBAction) takePhoto : (id)sender
{
    if (self.delegate) {
        [self.delegate takeOverlayPhoto];
    }
    
}

-(IBAction) newAction :(id)sender
{
    if (self.delegate) {
        [self.delegate takeOverlayPhoto];
    }

}

-(IBAction) continueAction :(id)sender
{
    if (self.delegate) {
        [self.delegate continueToMenu];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

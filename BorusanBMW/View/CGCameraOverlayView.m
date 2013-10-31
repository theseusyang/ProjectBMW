//
//  CGCameraOverlayView.m
//  BorusanBMW
//
//  Created by Bahadır Böge on 10/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGCameraOverlayView.h"

@implementation CGCameraOverlayView


@synthesize _useImageProcessSwitch;


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
        
        _captureGuide = [[UIView alloc] initWithFrame:CGRectMake(0, 190, 460, 80)];
        [_captureGuide setBackgroundColor:[UIColor colorWithRed:0.9 green:0.3 blue:0.3 alpha:0.3]];
        [self addSubview:_captureGuide];
        
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
        
        _useImageProcessSwitch = [[UISwitch alloc] initWithFrame:CGRectMake( 10, 20, 40, 40)];
        [_useImageProcessSwitch setOn:NO];
        useImageProcessing = NO;
        _captureGuide.hidden = YES;
        [_useImageProcessSwitch addTarget:self action:@selector(switchValueChanged) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_useImageProcessSwitch];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oriantationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
        
        
        
        
    }
    return self;
}

-(IBAction) takePhoto : (id)sender
{
    NSLog(@"Photo taken %hhd", useImageProcessing);
    if (self.delegate) {
        [self.delegate takeOverlayPhotoWithImageProcessing: useImageProcessing];
        [self setSwitchTo:NO];
    }
    
}

-(IBAction) newAction :(id)sender
{
    NSLog(@"Photo taken %hhd", useImageProcessing);
    if (self.delegate) {
        [self.delegate takeOverlayPhotoWithImageProcessing: useImageProcessing];
        [self setSwitchTo:NO];
    }

}

-(IBAction) continueAction :(id)sender
{
    if (self.delegate) {
        [self setSwitchTo:NO];
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

-(IBAction)switchValueChanged
{
    if(_useImageProcessSwitch.on){
        useImageProcessing = YES;
        _captureGuide.hidden = NO;
    }else{
        useImageProcessing = NO;
        _captureGuide.hidden = YES;
    }
    NSLog(@"%hhd", useImageProcessing);
}

-(void) oriantationChanged:(NSNotification*) note
{
    UIDevice *device = note.object;
    
    switch (device.orientation) {
        case UIDeviceOrientationPortrait:
            NSLog(@"Portrait");
            _captureGuide.frame = CGRectMake(0, 200, 320, 60);
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"Portrait");
            _captureGuide.frame = CGRectMake(0, 200, 320, 60);
            break;
        
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"Landscape");
            _captureGuide.frame = CGRectMake( 106, 0, 108, 480);
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"Landscape");
            _captureGuide.frame = CGRectMake( 106, 0, 108, 480);
            break;
            
        default:
            break;
    }
}

-(void) setSwitchTo:(BOOL)state
{
    _captureGuide.hidden = !state;
    _useImageProcessSwitch.on = state;
    useImageProcessing = state;
}
@end

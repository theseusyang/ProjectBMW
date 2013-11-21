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
        [_newButton setBackgroundImage:kApplicationImage(@"ButtonSmallDeactive.png") forState:UIControlStateNormal];
        [_newButton setTitle:@"Yeni" forState:UIControlStateNormal];
        [_newButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_newButton addTarget:self action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_newButton];
        
        _captureGuide = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlateCaptureGuideVertical.png"]];
        _captureGuide.frame = CGRectMake(0, 0, 320, 425);
        [self addSubview:_captureGuide];
        
        _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 397, 110, 83)];
        [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapture) forState:UIControlStateNormal];
        [_captureButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_captureButton];
        
        _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(221, 430, 93, 48)];
        [_continueButton setBackgroundImage:kApplicationImage(@"ButtonSmallDeactive.png") forState:UIControlStateNormal];
        [_continueButton setTitle:@"Devam" forState:UIControlStateNormal];
        [_continueButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_continueButton];
        
        _useFlashButton = [[UIButton alloc] initWithFrame:CGRectMake(231, 20, 79, 28)];
        [_useFlashButton setImage:[UIImage imageNamed:@"SwitchButtonFlashOff.png"] forState:UIControlStateNormal];
        [_useFlashButton addTarget:self action:@selector(changeFlashState:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_useFlashButton];
        
        _useImageProcessButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 79, 28)];
        [_useImageProcessButton setImage:[UIImage imageNamed:@"SwitchButtonCar.png"] forState:UIControlStateNormal];
        [_useImageProcessButton addTarget:self action:@selector(changeImageProcessState:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_useImageProcessButton];
        
        //_useImageProcessSwitch = [[UISwitch alloc] initWithFrame:CGRectMake( 10, 20, 40, 40)];
        //[_useImageProcessSwitch setOn:NO];
        //_useImageProcessSwitch.onImage = [UIImage imageNamed:@"IconPlateMode.png"];
        //_useImageProcessSwitch.offImage = [UIImage imageNamed:@"IconCarMode.png"];
        
        //[_useImageProcessSwitch addTarget:self action:@selector(switchValueChanged) forControlEvents:UIControlEventValueChanged];
        //[self addSubview:_useImageProcessSwitch];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oriantationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
        
        useImageProcessing = NO;
        _captureGuide.hidden = YES;
        useFlash = NO;
        
    }
    return self;
}

-(IBAction) takePhoto : (id)sender
{
    NSLog(@"Photo taken %hhd", useImageProcessing);
    if (self.delegate) {
        //FLASHADD
        [self.delegate takeOverlayPhotoWithImageProcessing: useImageProcessing and: useFlash];
        [self setSwitchTo:NO];
    }
    
}

-(IBAction) newAction :(id)sender
{
    //Disabled
    /*
    NSLog(@"Photo taken %hhd", useImageProcessing);
    if (self.delegate) {
        [self.delegate takeOverlayPhotoWithImageProcessing: useImageProcessing];
        [self setSwitchTo:NO];
    }
    */

}

-(IBAction) continueAction :(id)sender
{
    //Disabled
    /*
    if (self.delegate) {
        [self setSwitchTo:NO];
        [self.delegate continueToMenu];
    }
    */
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
            _captureGuide.image = [UIImage imageNamed:@"PlateCaptureGuideVertical.png"];
            _captureGuide.frame = CGRectMake(0, 0, 320, 425);
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"Portrait");
            _captureGuide.image = [UIImage imageNamed:@"PlateCaptureGuideVertical.png"];
            //_captureGuide.frame = CGRectMake(0, 0, 320, 425);
            break;
        
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"Landscape");
            _captureGuide.image = [UIImage imageNamed:@"PlateCaptureGuideHorizontal.png"];
            //_captureGuide.frame = CGRectMake( 0, 0, 108, 480);
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"Landscape");
            _captureGuide.image = [UIImage imageNamed:@"PlateCaptureGuideHorizontal.png"];
            //_captureGuide.frame = CGRectMake( 106, 0, 108, 480);
            break;
            
        default:
            break;
    }
}


//This function was supposed to be for state changes but by changing switch structure with button
//and adding flash option I needed another function just to set states right on exit.
//Instead of adding a new function I changed this one. Needs testing 20.11.13
-(void) setSwitchTo:(BOOL)state
{
    _captureGuide.hidden = !state;
    useImageProcessing = state;
    if(state)
    {
        [_useImageProcessButton setImage:[UIImage imageNamed:@"SwitchButtonCar.png"] forState:UIControlStateNormal];
        [_useFlashButton setImage:[UIImage imageNamed:@"SwitchButtonFlashOff.png"] forState:UIControlStateNormal];
    }
        
}

-(IBAction)changeFlashState:(id)sender
{
    if(useFlash)
    {
        useFlash = NO;
        [_useFlashButton setImage:[UIImage imageNamed:@"SwitchButtonFlashOff.png"] forState:UIControlStateNormal];
    }
    else
    {
        useFlash = YES;
        [_useFlashButton setImage:[UIImage imageNamed:@"SwitchButtonFlashOn.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)changeImageProcessState:(id)sender
{
    if(useImageProcessing)
    {
        useImageProcessing = NO;
        _captureGuide.hidden = YES;
        [_useImageProcessButton setImage:[UIImage imageNamed:@"SwitchButtonCar.png"] forState:UIControlStateNormal];
    }
    else{
        useImageProcessing = YES;
        _captureGuide.hidden = NO;
        [_useImageProcessButton setImage:[UIImage imageNamed:@"SwitchButtonPlate.png"] forState:UIControlStateNormal];
    }
}
@end

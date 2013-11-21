//
//  CGCameraOverlayView.h
//  BorusanBMW
//
//  Created by Bahadır Böge on 10/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"

@protocol CGCameraOverlayProtocol <NSObject>

- (void)takeOverlayPhoto;
- (void)takeOverlayPhotoWithImageProcessing:(BOOL) used;
- (void)takeOverlayPhotoWithImageProcessing:(BOOL) used and: (BOOL) flash;
- (void)continueToMenu;

@end

@interface CGCameraOverlayView : UIView
{
    UIView *_footerImage;
    UIImageView *_captureGuide;
    
    UIButton *_useFlashButton;
    UIButton *_useImageProcessButton;
    //UISwitch *_useImageProcessSwitch;
    
    BOOL useImageProcessing;
    BOOL useFlash;
    UIButton *_newButton;
    UIButton *_captureButton;
    UIButton *_continueButton;
    
    UIActivityIndicatorView *_loadingProgress;
}

-(void) setSwitchTo:(BOOL) state;
- (void)stopSpinner;
- (void)startSpinner;

@property (nonatomic, strong) id<CGCameraOverlayProtocol> delegate;
@property (nonatomic, retain) IBOutlet UISwitch *_useImageProcessSwitch;

@end

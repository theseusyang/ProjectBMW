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
- (void)continueToMenu;

@end

@interface CGCameraOverlayView : UIView
{
    UIView *_footerImage;
    UIView *_captureGuide;
    
    UISwitch *_useImageProcessSwitch;
    BOOL useImageProcessing;
    
    UIButton *_newButton;
    UIButton *_captureButton;
    UIButton *_continueButton;
    
    
}


-(void) setSwitchTo:(BOOL) state;

@property (nonatomic, strong) id<CGCameraOverlayProtocol> delegate;
@property (nonatomic, retain) IBOutlet UISwitch *_useImageProcessSwitch;

@end

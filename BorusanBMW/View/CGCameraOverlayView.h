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
- (void)continueToMenu;

@end

@interface CGCameraOverlayView : UIView
{
    UIView *_footerImage;
    UIImageView *_captureGuide;
    
    UIButton *_newButton;
    UIButton *_captureButton;
    UIButton *_continueButton;
}

@property (nonatomic, strong) id<CGCameraOverlayProtocol> delegate;

@end

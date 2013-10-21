//
//  CGTakePhotoViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/5/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGMenuViewController.h"
#import "CGCameraOverlayView.h"
#import "Tesseract.h"

@interface CGTakePhotoViewController : CGBaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CGCameraOverlayProtocol>
{
    UIView *_photoView;
    UIImageView *_captureGuide;
    
    //MBB
    NSMutableArray *_imageList;
    //Plate
    NSString *_plateNumber;
    
    //Footer
    UIView *_footerView;
    UIImageView *_footerImage;
    UIButton *_newButton;
    UIButton *_continueButton;
    UIButton *_captureButton;
    
    //Photo Picker
    UIImagePickerController *_imagePicker;
}
@end

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

#import "ImageProcessingImplementation.h"
#import "UIImage+operation.h"
#import "UIImage+Resize.h"
#import "Profiler.h"
#import "CGUtilHelper.h"

#define kSizeFactor 20

@interface CGTakePhotoViewController : CGBaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CGCameraOverlayProtocol>
{
    UIView *_photoView;
    UIImageView *_captureGuide;
    
    UIImageView *imageView;
    
    //Gizmos
    BOOL useImageProcessing;
    UIImageView *_processedImage;
    UITextView *_plate;
    UITextView *_totalCost;
    UITextView *_ocrCost;
    UITextView *_imageProcessingCost;
    
    UIImageView *_rotated;
    UIImageView *_corped;
    UIImageView *_processed;
    
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
    
    //Image Processer
    id <ImageProcessingProtocol> imageProcessor;
    
    BOOL enablePhotoPicker;
}
@end

//
//  CGTakePhotoViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/5/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGTakePhotoViewController.h"
#import "CGPhotoManagementViewController.h"

#define IMAGE_OFFSET_Y 540.0
#define IMAGE_OFFSET_X 200.0//244.0

#define PIMAGE_OFFSET_Y 1270.0
#define PIMAGE_OFFSET_Y_IOS6 1474.0

#define PIMAGE_OFFSET_X 280.0

#define IMAGE_CROP_HEIGHT 1140.0
#define PIMAGE_CROP_HEIGHT 580.0

#define PIMAGE_CROP_WIDTH 10.0

@interface CGTakePhotoViewController ()

@end

@implementation CGTakePhotoViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _photoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
    _photoView.backgroundColor = kColorBlack;
    //[_photoView addSubview:[[UIImageView alloc] initWithImage:kApplicationImage(@"TakePhoto.png")]];
    [self.view addSubview:_photoView];
    
    //_captureGuide = [[UIImageView alloc] initWithFrame:CGRectMake(80, 89, 153, 153)];
    //[_captureGuide setImage:kApplicationImage(kResCaptureGuide)];
    //[self.view addSubview:_captureGuide];
    
    _footerImage = [[UIImageView alloc] initWithImage:kApplicationImage(kResContentFooter)];
    _footerImage.frame = CGRectMake(0, 361, 320, 55);
    [self.view addSubview:_footerImage];
    
    _newButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 366, 93, 48)];
    [_newButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
    [_newButton setTitle:@"Yeni" forState:UIControlStateNormal];
    [_newButton.titleLabel setFont:kApplicationFontBold(17.0f)];
    [_newButton addTarget:self action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newButton];

    _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(221, 366, 93, 48)];
    [_continueButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
    [_continueButton setTitle:@"Kullan" forState:UIControlStateNormal];
    [_continueButton.titleLabel setFont:kApplicationFontBold(17.0f)];
    [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_continueButton];
    
    _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 333, 110, 83)];
    [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapture) forState:UIControlStateNormal];
    [_captureButton addTarget:self action:@selector(capture:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_captureButton];
    
    _imageList =  [NSMutableArray new];
    
    //Gizmos
    _processedImage = [[UIImageView alloc]init];
    [_processedImage setFrame:CGRectMake(180, 80, 138, 96)];
    _totalCost = [[UITextView alloc] init];
    [_totalCost setFrame:CGRectMake(10, 80, 138, 30)];
    _ocrCost = [[UITextView alloc] init];
    [_ocrCost setFrame:CGRectMake(10, 120, 138, 30)];
    _imageProcessingCost = [[UITextView alloc] init];
    [_imageProcessingCost setFrame:CGRectMake(10, 160, 138, 30)];
    _plate = [[UITextView alloc] init];
    [_plate setFrame:CGRectMake(180, 220, 138, 30)];
    
    _rotated = [[UIImageView alloc]init];
    [_rotated setFrame:CGRectMake(10, 80, 120, 120)];
    [self.view addSubview:_rotated];
    _corped = [[UIImageView alloc]init];
    [_corped setFrame:CGRectMake(10, 210, 120, 120)];
    [self.view addSubview:_corped];
    _processed = [[UIImageView alloc]init];
    [_processed setFrame:CGRectMake(10, 210, 120, 120)];
    [self.view addSubview:_processed];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageProcessor = [ImageProcessingImplementation new];
    
    UIImagePickerControllerSourceType sourceType;
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        sourceType = UIImagePickerControllerSourceTypeCamera;
    else
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker = [[UIImagePickerController alloc] init];
    //[_imagePicker setAllowsEditing:YES];
    
    _imagePicker.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        _imagePicker.showsCameraControls = NO; // To provide our own custom controls
        _imagePicker.cameraOverlayView = [[CGCameraOverlayView alloc] init];
        ((CGCameraOverlayView*)(_imagePicker.cameraOverlayView)).delegate = self;
    }
    _imagePicker.navigationBarHidden = YES;
    _imagePicker.wantsFullScreenLayout = YES;
    [_imagePicker setDelegate:self];
    
#if TEST_MODE == 1
    // Test Case code Block
#endif
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
    [self presentViewController:_imagePicker animated:NO completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setLeftButtonHidden:YES];
    [self setCancelButton];
    
    if(enablePhotoPicker){
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
        [self presentViewController:_imagePicker animated:NO completion:nil];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)continueAction:(id)sender
{
    /*
    UIImageView *imageView = _imageList[0];
    UIGraphicsBeginImageContext(CGSizeMake(70, 70));
    [imageView.image drawInRect:CGRectMake(0,0,70,70)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView.image = newImage;
    */
    //Enable Taking photo for next call to this VC
    enablePhotoPicker = YES;
    
    UIViewController *vc = [[CGPhotoManagementViewController alloc] initWithImageList:_imageList andPlateNumber:_plateNumber];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)newAction:(id)sender
{
    //
    [self presentViewController:_imagePicker animated:YES completion:^{
        
    }];
    // Refrest the photo
}

-(void)capture:(id)sender
{
    
    [self presentViewController:_imagePicker animated:YES completion:^{
        
    }];
}

// Override
- (void)rightAction:(id)sender
{
    [self backToController:[CGMenuViewController class]];
}

#pragma mark UIImagePickerControlDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    /*
     UIImage *rotatedCorrectly;
     if (originalImage.imageOrientation != UIImageOrientationUp)
     rotatedCorrectly = [originalImage rotate:originalImage.imageOrientation];
     else
     rotatedCorrectly = originalImage;
     
     CGImageRef ref = CGImageCreateWithImageInRect(rotatedCorrectly.CGImage, croppedRect);
     rotatedCorrectly = [UIImage imageWithCGImage:ref];
     
     #if TEST_MODE == 1
     [Profiler start:@"Image Processing"];
     
     UIImage *processedImage = [self imageProcess:rotatedCorrectly];
     
     _imageProcessingCost.text = [[Profiler stop] stringByAppendingString:@" Image Process"];
     
     [Profiler start:@"OCR Process"];
     
     _plateNumber = [self OCR:processedImage];
     
     _ocrCost.text = [[Profiler stop] stringByAppendingString:@" OCR Process"];
     
     _totalCost.text = [[Profiler totalTime] stringByAppendingString:@" Total"];
     
     [self.view addSubview:_imageProcessingCost];
     [self.view addSubview:_ocrCost];
     [self.view addSubview:_totalCost];
     #endif
     
     NSLog(@"%@", _plateNumber);
     
     NSLog(@"Total Time: %@", [Profiler totalTime]);
     
     #if TEST_MODE == 1
     //Gizmos
     _plate.text = _plateNumber;
     _processedImage.image = processedImage;
     _processedImage.contentMode = UIViewContentModeScaleAspectFit;
     [self.view addSubview:_plate];
     [self.view addSubview:_processedImage];
     #endif
     
     UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
     imageView.image = rotatedCorrectly;
     imageView.contentMode = UIViewContentModeScaleAspectFit;
     
     [_photoView addSubview:imageView];
     [_imageList addObject:imageView.image];
     
     //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); // If you wanna save pic to Lib, uncomment this line

    */
    [self dismissViewControllerAnimated:YES completion:nil];
    enablePhotoPicker = NO;

    UIImage *originalImage= [info objectForKey: UIImagePickerControllerOriginalImage];
    
    //corpedRect must use rotatedCorrectly instead of originalImage
    CGRect croppedRect;
   
    NSLog(@"Height %f", originalImage.size.height);
    NSLog(@"Width %f", originalImage.size.width);
    
    UIImage *rotatedCorrectly;
    if (originalImage.imageOrientation != UIImageOrientationUp){
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            croppedRect = CGRectMake(PIMAGE_OFFSET_X, PIMAGE_OFFSET_Y, originalImage.size.width - PIMAGE_OFFSET_X + PIMAGE_CROP_WIDTH, PIMAGE_CROP_HEIGHT); //Portrait
        }
        else{
            croppedRect = CGRectMake(PIMAGE_OFFSET_X, PIMAGE_OFFSET_Y_IOS6, originalImage.size.width - PIMAGE_OFFSET_X + PIMAGE_CROP_WIDTH, PIMAGE_CROP_HEIGHT); //Portrait
        }
        
        rotatedCorrectly = [originalImage rotate:originalImage.imageOrientation];
        
    }
    
    else{
        rotatedCorrectly = originalImage;
        croppedRect = CGRectMake(IMAGE_OFFSET_X, IMAGE_OFFSET_Y, originalImage.size.width - IMAGE_OFFSET_X, IMAGE_CROP_HEIGHT); //Landscape
    }
    
    if(useImageProcessing)
    {
        //Below 2 lines was put here to correct corped image bug
        CGImageRef ref = CGImageCreateWithImageInRect(rotatedCorrectly.CGImage, croppedRect);
        rotatedCorrectly = [UIImage imageWithCGImage:ref];
        
#if TEST_MODE == 1
        [Profiler start:@"Image Processing"];
#endif
        UIImage *processedImage = [self imageProcess:rotatedCorrectly];
#if TEST_MODE == 1
        _imageProcessingCost.text = [[Profiler stop] stringByAppendingString:@" Image Process"];
        
        [Profiler start:@"OCR Process"];
#endif
        _plateNumber = [self OCR:processedImage];
#if TEST_MODE == 1
        _ocrCost.text = [[Profiler stop] stringByAppendingString:@" OCR Process"];
        
        _totalCost.text = [[Profiler totalTime] stringByAppendingString:@" Total"];
        
        [self.view addSubview:_imageProcessingCost];
        [self.view addSubview:_ocrCost];
        [self.view addSubview:_totalCost];
#endif
        
        NSLog(@"%@", _plateNumber);
#if TEST_MODE == 1
        NSLog(@"Total Time: %@", [Profiler totalTime]);
        

        //Gizmos
        _plate.text = _plateNumber;
        _processedImage.image = rotatedCorrectly;
        _processedImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_plate];
        [self.view addSubview:_processedImage];
#endif
    }
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
    imageView.image = rotatedCorrectly;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_photoView addSubview:imageView];
    [_imageList addObject:imageView.image];
    
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); // If you wanna save pic to Lib, uncomment this line
    
    /*
    if(useImageProcessing){
            UIImage *rotatedCorrectly;
        
        NSLog(@"%d", rotatedCorrectly.imageOrientation);
            if (originalImage.imageOrientation!=UIImageOrientationRight)
                rotatedCorrectly = [originalImage rotate:originalImage.imageOrientation];
            else
                rotatedCorrectly = originalImage;
        
        UIImage *processImage = [UIImage imageWithCGImage:rotatedCorrectly.CGImage];
        
            CGImageRef ref = CGImageCreateWithImageInRect(processImage.CGImage, croppedRect);
            processImage = [UIImage imageWithCGImage:ref];
            //CGImageRelease(ref);
        
            //NSLog(@"Size of JPG image: %ul", imageData.length);
            
            
            
        ////////Test
        #if TEST_MODE == 1
            [Profiler start:@"Image Processing"];
        #endif
            UIImage *processedImage = [self imageProcess:processImage];
        #if TEST_MODE == 1

            _imageProcessingCost.text = [[Profiler stop] stringByAppendingString:@" Image Process"];
                    [Profiler start:@"OCR Process"];
        #endif
                _plateNumber = [self OCR:processedImage];
        #if TEST_MODE == 1
            _ocrCost.text = [[Profiler stop] stringByAppendingString:@" OCR Process"];
            
            _totalCost.text = [[Profiler totalTime] stringByAppendingString:@" Total"];
        
            [self.view addSubview:_imageProcessingCost];
            [self.view addSubview:_ocrCost];
            [self.view addSubview:_totalCost];
        #endif
            
            
            
            NSLog(@"%@", _plateNumber);
            
            NSLog(@"Total Time: %@", [Profiler totalTime]);
            
        #if TEST_MODE == 1
            //Gizmos
            _plate.text = _plateNumber;
            _processedImage.image = processedImage;
            _processedImage.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:_plate];
            [self.view addSubview:_processedImage];
        #endif
        
        _rotated.image = rotatedCorrectly;
        _rotated.contentMode = UIViewContentModeScaleAspectFit;
        _processed.image = processImage;
        _processed.contentMode = UIViewContentModeScaleAspectFit;
        
        
        imageView.image = originalImage;
    }
    else
    {
        imageView.image = originalImage;
    }
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    [_photoView addSubview:imageView];
    [_imageList addObject:imageView.image];
    */
     //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); // If you wanna save pic to Lib, uncomment this line
}

- (UIImage *)imageProcess:(UIImage *)image
{
    // Make small the pic - UIGraphics~
    /*
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width / 5, image.size.height / 5));
    [image drawInRect:CGRectMake(0,0,image.size.width / 5, image.size.height / 5)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    
    UIImage *takenImage = image;
    UIImage *processedImage;

    processedImage = [imageProcessor processImage:takenImage];

    return processedImage;
}

- (NSString *)OCR: (UIImage *)processedImage
{
   return [imageProcessor OCRImage:processedImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark CGTakePhotoViewController
- (void) takeOverlayPhoto
{
    [_imagePicker takePicture];
}

- (void) takeOverlayPhotoWithImageProcessing: (BOOL) used
{
    useImageProcessing = used;
    [_imagePicker takePicture];
}

-(void)takeOverlayPhotoWithImageProcessing:(BOOL)used and:(BOOL) flash
{
    useImageProcessing = used;
    if(flash)
        _imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    else
        _imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    [_imagePicker takePicture];
}

- (void) continueToMenu
{
    //Enable Taking photo for next call to this VC
    enablePhotoPicker = YES;
    
    UIViewController *vc = [[CGPhotoManagementViewController alloc] initWithImageList:_imageList andPlateNumber:_plateNumber];
    [self.navigationController pushViewController:vc animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

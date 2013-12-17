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
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _photoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
    _photoView.backgroundColor = kColorBlack;
    _photoView.contentMode = UIViewContentModeScaleAspectFit;
    [_photoView addSubview:imageView];
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
    [_newButton setTitle:@"Tekrar" forState:UIControlStateNormal];
    [_newButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_newButton setTitle:@"Tekrar" forState:UIControlStateHighlighted];
    [_newButton.titleLabel setFont:kApplicationFontBold(17.0f)];
    [_newButton addTarget:self action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newButton];

    _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(221, 366, 93, 48)];
    [_continueButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
    [_continueButton setTitle:@"Kullan" forState:UIControlStateNormal];
    [_continueButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_continueButton setTitle:@"Kullan" forState:UIControlStateHighlighted];
    [_continueButton.titleLabel setFont:kApplicationFontBold(17.0f)];
    [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_continueButton];
    
    _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 333, 110, 83)];
    [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapture) forState:UIControlStateNormal];
    [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapturePressed) forState:UIControlStateHighlighted];
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

    _imagePicker = [[UIImagePickerController alloc] init];
    
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

    //[self presentViewController:_imagePicker animated:NO completion:nil];
    
    enablePhotoPicker = true;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setLeftButtonHidden:YES];
    [self setCancelButton];
    
    if(enablePhotoPicker){
        //imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
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
    [Profiler start:@"Make my photo smaller"];
    UIImage *originalImage = imageView.image;
    UIImage *scaledImage   = [CGUtilHelper imageMakeSmaller:originalImage factor:kSizeFactor];
    CGRect frame           = [CGUtilHelper imageRectInSquare:scaledImage];
    UIImage *croppedImage  = [CGUtilHelper imageWithImage:scaledImage andRect:frame];
    [Profiler stop];
    
    //Enable Taking photo for next call to this VC
    enablePhotoPicker = YES;
    if(croppedImage)
        [_imageList addObject:croppedImage];
    
    UIViewController *vc = [[CGPhotoManagementViewController alloc] initWithImageList:_imageList andPlateNumber:_plateNumber];
    
    imageView.image = nil;
    croppedImage    = nil;
    originalImage   = nil;
    scaledImage     = nil;
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
    enablePhotoPicker = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *originalImage= [info objectForKey: UIImagePickerControllerOriginalImage];
    
    //corpedRect must use rotatedCorrectly instead of originalImage
    CGRect croppedRect;
    UIImage *rotatedCorrectly;
    if(useImageProcessing)
    {
        CGCameraOverlayView *overlay = ((CGCameraOverlayView*)(_imagePicker.cameraOverlayView));
        
        /* Image operations */
        if (originalImage.imageOrientation != UIImageOrientationUp){
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                croppedRect = CGRectMake(PIMAGE_OFFSET_X, PIMAGE_OFFSET_Y - 200, originalImage.size.width - PIMAGE_OFFSET_X + PIMAGE_CROP_WIDTH, PIMAGE_CROP_HEIGHT); //Portrait
            }
            else{
                croppedRect = CGRectMake(PIMAGE_OFFSET_X, PIMAGE_OFFSET_Y_IOS6 - 200, originalImage.size.width - PIMAGE_OFFSET_X + PIMAGE_CROP_WIDTH, PIMAGE_CROP_HEIGHT); //Portrait
            }
            
            rotatedCorrectly = [originalImage rotate:originalImage.imageOrientation]; // Bellek sıçramasına neden olan buymuş!
        }
        
        else{
            rotatedCorrectly = originalImage;
            croppedRect = CGRectMake(IMAGE_OFFSET_X, IMAGE_OFFSET_Y, originalImage.size.width - IMAGE_OFFSET_X, IMAGE_CROP_HEIGHT); //Landscape
        }

        //Below 2 lines was put here to correct corped image bug
        CGImageRef ref = CGImageCreateWithImageInRect(rotatedCorrectly.CGImage, croppedRect);
        rotatedCorrectly = [UIImage imageWithCGImage:ref];
        CGImageRelease(ref);
        
        [Profiler start:@"Image Processing"];
        UIImage *processedImage = [self imageProcess:rotatedCorrectly];
        _imageProcessingCost.text = [[Profiler stop] stringByAppendingString:@" Image Process"];
        
        [Profiler start:@"OCR Process"];
        _plateNumber = [self OCR:processedImage];
        _ocrCost.text = [[Profiler stop] stringByAppendingString:@" OCR Process"];
        _totalCost.text = [[Profiler totalTime] stringByAppendingString:@" Total"];
        
        NSLog(@"%@", _plateNumber);
        NSLog(@"Total Time: %@", [Profiler totalTime]);

        CGImageRelease(ref);
        
        [overlay stopSpinner];
    }
    else
    {
        rotatedCorrectly = originalImage;
    }
    
    imageView.image = rotatedCorrectly;
}

- (UIImage *)imageProcess:(UIImage *)image
{
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

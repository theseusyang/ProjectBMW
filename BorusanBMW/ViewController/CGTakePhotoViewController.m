//
//  CGTakePhotoViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/5/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGTakePhotoViewController.h"
#import "CGPhotoManagementViewController.h"


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
    [_photoView addSubview:[[UIImageView alloc] initWithImage:kApplicationImage(@"TakePhoto.png")]];
    [self.view addSubview:_photoView];
    
    _captureGuide = [[UIImageView alloc] initWithFrame:CGRectMake(80, 89, 153, 153)];
    [_captureGuide setImage:kApplicationImage(kResCaptureGuide)];
    [self.view addSubview:_captureGuide];
    
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
    [_continueButton setTitle:@"Devam" forState:UIControlStateNormal];
    [_continueButton.titleLabel setFont:kApplicationFontBold(17.0f)];
    [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_continueButton];
    
    _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 333, 110, 83)];
    [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapture) forState:UIControlStateNormal];
    [_captureButton addTarget:self action:@selector(capture:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_captureButton];
    
    _imageList =  [NSMutableArray new];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    if([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)])
    {
        NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        
        
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        _imagePicker.mediaTypes = [NSArray arrayWithArray:availableMediaTypes];
        _imagePicker.showsCameraControls = NO;
        _imagePicker.navigationBarHidden = YES;
        _imagePicker.wantsFullScreenLayout = YES;
        _imagePicker.delegate = self;
        

        _imagePicker.cameraOverlayView = [[CGCameraOverlayView alloc] init];
        ((CGCameraOverlayView*)(_imagePicker.cameraOverlayView)).delegate = self;
        _imagePicker.delegate = self;
        
        //MBB
        /*
        UIView *_newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 365) ];
        
        _newButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 366, 93, 48)];
        [_newButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
        [_newButton setTitle:@"Yeni" forState:UIControlStateNormal];
        [_newButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_newButton addTarget:self action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
        [_newView addSubview:_newButton];
        
        _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(221, 366, 93, 48)];
        [_continueButton setBackgroundImage:kApplicationImage(kResButtonSmall) forState:UIControlStateNormal];
        [_continueButton setTitle:@"Devam" forState:UIControlStateNormal];
        [_continueButton.titleLabel setFont:kApplicationFontBold(17.0f)];
        [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
        [_newView addSubview:_continueButton];
        
        _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 333, 110, 83)];
        [_captureButton setBackgroundImage:kApplicationImage(kResButtonCapture) forState:UIControlStateNormal];
        [_newView addSubview:_captureButton];
        
        _imagePicker.cameraOverlayView = _newView;
        */
        //[[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
        
        [self presentViewController:_imagePicker animated:NO completion:^{
            NSLog(@"LOGLOG");
        }];
        /*
        [self presentViewController:_imagePicker animated:YES completion:^{
            NSLog(@"LOGLOG");
        }];
        */

    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setLeftButtonHidden:YES];
    [self setCancelButton];
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
    
    UIImage *image = [[UIImage alloc] init];
    image = [info objectForKey:	UIImagePickerControllerOriginalImage];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
    imageView.image =image;
    
    // Make small the pic
    UIGraphicsBeginImageContext(CGSizeMake(400, 400));
    [image drawInRect:CGRectMake(0,0,400,400)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Tesseract needs opencv image preprocessing
    Tesseract *tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setImage:newImage];
    if([tesseract recognize]){
        NSLog(@"%@",[tesseract recognizedText]);
        if( !_plateNumber ){
            //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@" options:<#(NSRegularExpressionOptions)#> error:<#(NSError *__autoreleasing *)#>]
            _plateNumber = [tesseract recognizedText];
        }
    } else {
        NSLog(@"Couldnt read.");
    }
    [tesseract clear];
    //End of tesseract
    
    [_photoView addSubview:imageView];
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    //MBB
    [_imageList addObject:imageView.image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //NSLog(@"Took Picture");
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    
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

- (void) continueToMenu
{
    UIViewController *vc = [[CGPhotoManagementViewController alloc] initWithImageList:_imageList andPlateNumber:_plateNumber];
    [self.navigationController pushViewController:vc animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

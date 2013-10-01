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
    [self.view addSubview:_captureButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    UIViewController *vc = [[CGPhotoManagementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)newAction:(id)sender
{
    // Refrest the photo
}

// Override
- (void)rightAction:(id)sender
{
    [self backToController:[CGMenuViewController class]];
}

@end

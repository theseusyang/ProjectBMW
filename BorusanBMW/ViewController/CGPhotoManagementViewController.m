//
//  CGCreateRecordViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGPhotoManagementViewController.h"
#import "CGCreateRecordViewController.h"

@interface CGPhotoManagementViewController ()

@end

@implementation CGPhotoManagementViewController

- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageList:(NSMutableArray*)imageLlist
{
    self = [super init];
    if (self) {
        
        // Just send the reference
        _imageList = imageLlist;
        
    }
    
    return self;
}

- (id)initWithImageList:(NSMutableArray*)imageList andPlateNumber: (NSString*)plateNumber
{
    self = [super init];
    if (self) {
        
        //_imageList = [NSArray arrayWithArray:imageList];
        _imageList = imageList;
        _plateNumber = plateNumber;
        
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _photoGallery = [[CGPhotoGalleryView alloc] initWithPoint:CGPointMake(0, 53) andList:_imageList andViewController:self isDeleteActive:YES];
    [self.view addSubview:_photoGallery];
    
    _addPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 243 + 36, 258, 53)];
    [_addPhotoButton setBackgroundImage:kApplicationImage(kResButtonBlue) forState:UIControlStateNormal];
    [_addPhotoButton setTitle:@"Bir Fotograf Daha Ekle" forState:UIControlStateNormal];
    [_addPhotoButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_addPhotoButton setTitle:@"Bir Fotograf Daha Ekle" forState:UIControlStateHighlighted];
    [_addPhotoButton.titleLabel setFont:kApplicationFontBold(19.0f)];
    [_addPhotoButton addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addPhotoButton];
    
    _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 300 + 36, 258, 53)];
    [_continueButton setBackgroundImage:kApplicationImage(kResButtonDark) forState:UIControlStateNormal];
    [_continueButton setTitle:@"Devam Et" forState:UIControlStateNormal];
    [_continueButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_continueButton setTitle:@"Devam Et" forState:UIControlStateHighlighted];
    [_continueButton.titleLabel setFont:kApplicationFontBold(19.0f)];
    [_continueButton addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_continueButton];

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
    [self setCancelButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override
- (void)rightAction:(id)sender
{
    [self backToController:[CGMenuViewController class]];
}

#pragma mark Button Actions
- (void)addPhotoAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)continueAction:(id)sender
{
    _imageList = _photoGallery.currentImageList;
    UIViewController *vc = [[CGCreateRecordViewController alloc] initWithImageList:_imageList andPlateNumber:_plateNumber];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

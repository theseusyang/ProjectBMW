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

- (void)loadView
{
    [super loadView];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Photo1.png"]];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Photo2.png"]];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Photo3.png"]];
    
    _photoGallery = [[CGPhotoGalleryView alloc] initWithImageList:@[imageView, imageView1, imageView2]];
    [self.view addSubview:_photoGallery];
    
    /*
    _photoListView = [[UIView alloc] initWithFrame:CGRectMake(160 - 80, 58, 160, 160)];
    [_photoListView addSubview:[[UIImageView alloc] initWithImage:kApplicationImage(@"Photo1.png")]];
    [self.view addSubview:_photoListView];
    */
    
    _addPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 243 + 36, 258, 53)];
    [_addPhotoButton setBackgroundImage:kApplicationImage(kResButtonBlue) forState:UIControlStateNormal];
    [_addPhotoButton setTitle:@"Bir Fotograf Daha Ekle" forState:UIControlStateNormal];
    [_addPhotoButton.titleLabel setFont:kApplicationFontBold(19.0f)];
    [_addPhotoButton addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addPhotoButton];
    
    _continueButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 300 + 36, 258, 53)];
    [_continueButton setBackgroundImage:kApplicationImage(kResButtonDark) forState:UIControlStateNormal];
    [_continueButton setTitle:@"Devam Et" forState:UIControlStateNormal];
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
    UIViewController *vc = [[CGCreateRecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

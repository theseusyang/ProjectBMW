//
//  CGMenuViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/5/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGMenuViewController.h"
#import "CGTakePhotoViewController.h"
#import "CGInformHistoryViewController.h"

@interface CGMenuViewController ()

@end

@implementation CGMenuViewController

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

    _contentImageView = [[UIImageView alloc] initWithImage:kApplicationImage(kResContentImage)];
    [self.view addSubview:_contentImageView];
    
    _logoView = [[UIImageView alloc] initWithImage:kApplicationImage(kResLogo)];
    _logoView.frame = CGRectMake(91, 135, 140, 165);
    [self.view addSubview:_logoView];
    
    _newInformButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 326, 258, 53)];
    [_newInformButton setBackgroundImage:kApplicationImage(kResButtonBlue) forState:UIControlStateNormal];
    [_newInformButton setTitle:@"Yeni Bildirim" forState:UIControlStateNormal];
    [_newInformButton.titleLabel setFont:kApplicationFontBold(19.0f)];
    [self.view addSubview:_newInformButton];
    
    [_newInformButton addTarget:self action:@selector(newInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _informHistory = [[UIButton alloc] initWithFrame:CGRectMake(31, 382, 258, 53)];
    [_informHistory setBackgroundImage:kApplicationImage(kResButtonDark)  forState:UIControlStateNormal];
    [_informHistory setTitle:@"Bildirim Geçmişi" forState:UIControlStateNormal];
    [_informHistory.titleLabel setFont:kApplicationFontBold(19.0f)];
    [self.view addSubview:_informHistory];
    
    [_informHistory addTarget:self action:@selector(informHistory:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Actions
- (void)newInformationAction:(id)sender
{
    UIViewController *vc = [[CGTakePhotoViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark Button Actions
- (void)informHistory:(id)sender
{
    UIViewController *vc = [[CGInformHistoryViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end

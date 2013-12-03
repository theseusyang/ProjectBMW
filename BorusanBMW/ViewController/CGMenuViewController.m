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
        
        [[DataService shared] getVehicleListWithSuccess:^(NSArray *vehicleList) {
            
            NSLog(@"Application is opening and getting first packet of data package whose size is 20.");
            
        } failure:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Server is not responding.." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            [alert show];
        }];
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
    
    //_informHistoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconNew"]]
    
    _newInformButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 326, 258, 53)];
    [_newInformButton setBackgroundImage:kApplicationImage(kResButtonBlue) forState:UIControlStateNormal];
    [_newInformButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_newInformButton setTitle:@"Yeni Bildirim" forState:UIControlStateHighlighted];
    [_newInformButton setTitle:@"Yeni Bildirim" forState:UIControlStateNormal];
    [_newInformButton.titleLabel setFont:kApplicationFontBold(19.0f)];
    [self.view addSubview:_newInformButton];
    
    [_newInformButton addTarget:self action:@selector(newInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _informHistory = [[UIButton alloc] initWithFrame:CGRectMake(31, 382, 258, 53)];
    [_informHistory setBackgroundImage:kApplicationImage(kResButtonDark)  forState:UIControlStateNormal];
    [_informHistory setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_informHistory setTitle:@"Bildirim Geçmişi" forState:UIControlStateHighlighted];
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
    
     NSArray *viewControllerList =  self.navigationController.viewControllers;
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

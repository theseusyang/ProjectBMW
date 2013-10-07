//
//  CGCreateRecordViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGCreateRecordViewController.h"
#import "CGTransitionViewController.h"

#define kTextFieldPaddingX 48.0f;
#define kScrollBar

@interface CGCreateRecordViewController ()

@end

@implementation CGCreateRecordViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageList:(NSArray *)imageList
{
    self = [super init];
    if (self) {
        _imageList = [NSArray arrayWithArray:imageList];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    NSString* currentDateString = [CGUtilHelper currentDate];
    NSString* currentLocation = [[LocationManager shared] location];
    
    _groupScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeightWithNav)];
    _groupScrollView.contentSize = CGSizeMake(kWindowWidth, kWindowHeightWithNav + 200);
    _groupScrollView.scrollEnabled = NO;
    [self.view addSubview:_groupScrollView];
    
    _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLocationDarkLarge.png"]];
    _locationIcon.frame = CGRectMake(35, 37, 61, 46);
    [_groupScrollView addSubview:_locationIcon];

    _dataLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 45, 100, 20)];
    [_dataLabel setText:currentDateString];
    [_dataLabel sizeToFit];
    [_groupScrollView addSubview:_dataLabel];
    
    _addressLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 63, 220, 60)];
    
    _addressLabel.font = kApplicationFont(13.0f);
    _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _addressLabel.numberOfLines = 0;
    _addressLabel.backgroundColor = kColorRed;
    [_addressLabel setText:currentLocation];
    [_addressLabel sizeToFit];
    [_groupScrollView addSubview:_addressLabel];
    
    // UITextFields
    _licensePlate = [[CGTextField alloc] initWithFrame:CGRectMake(35, 98, 250, 46)];
    _licensePlate.placeholder = @"34 UM 55"; //TODO: Dummy data
    _licensePlate.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLicensePlateDark.png"]];
    _licensePlate.leftView.frame  = CGRectMake(14, 14, 24, 19);
    _licensePlate.leftViewMode = UITextFieldViewModeAlways;
    _licensePlate.paddingX = kTextFieldPaddingX;
    _licensePlate.backgroundColor = kColorBlue;
    [_licensePlate setDelegate:self];
    [_groupScrollView addSubview:_licensePlate];
    
    _serviceName = [[CGTextField alloc] initWithFrame:CGRectMake(35, 148, 250, 46)];
    _serviceName.placeholder = @"Servis Adı"; //TODO: Dummy data
    _serviceName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconServiceNameDark.png"]];
    _serviceName.leftView.frame  = CGRectMake(14, 10, 24, 26);
    _serviceName.leftViewMode = UITextFieldViewModeAlways;
    _serviceName.paddingX = kTextFieldPaddingX;
    [_serviceName setDelegate:self];
    [_groupScrollView addSubview:_serviceName];
    
    _notificationType = [[CGTextField alloc] initWithFrame:CGRectMake(35, 200, 250, 46)];
    _notificationType.placeholder = @"Bildirim Tipi"; //TODO: Dummy data
    _notificationType.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconNotificationTypeDark.png"]];
    _notificationType.leftView.frame  = CGRectMake(14, 10, 20, 24);
    _notificationType.leftViewMode = UITextFieldViewModeAlways;
    _notificationType.paddingX = kTextFieldPaddingX;
    [_notificationType setDelegate:self];
    [_groupScrollView addSubview:_notificationType];
    
    _description = [[CGTextField alloc] initWithFrame:CGRectMake(35, 248, 250, 86)];
    _description.placeholder = @"Açıklama"; //TODO: Dummy data
    _description.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconCommentDark.png"]];
    _description.leftView.frame  = CGRectMake(14, 12, 20, 19);
    _description.leftViewMode = UITextFieldViewModeAlways;
    _description.paddingX = kTextFieldPaddingX;
    [_description setDelegate:self];
    [_groupScrollView addSubview:_description];
    
    _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(28, 350, 258, 52)];
    _sendButton.titleLabel.font = kApplicationFontBold(19.0f);
    [_sendButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue"] forState:UIControlStateNormal];
    [_sendButton setTitle:@"Gönder" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupScrollView addSubview:_sendButton];
    
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

#pragma mark UITextFieldDelegete
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _groupScrollView.scrollEnabled = YES;
    [_groupScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _groupScrollView.scrollEnabled = NO;
    [_groupScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark Button Actions
- (void)sendAction:(id)sender
{
    [_sendButton removeTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray *imageList = [[NSMutableArray alloc] init];
    for (int i=0; i < [_imageList count]; ++i) {
        
        UIImageView *imageView = [_imageList objectAtIndex:i];
        
        // Make small the pic
        UIGraphicsBeginImageContext(CGSizeMake(70, 70));
        [imageView.image drawInRect:CGRectMake(0,0,70,70)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(newImage);
        NSString *imageEncoded = [Base64 encode:imageData];
        [imageList addObject:imageEncoded];
    }
    
    NSArray *imageListFinal = [NSArray arrayWithArray:imageList];
    // Set data that will be send to backend
    NSString *location         = _addressLabel.text;
    NSString *licencePlate     = _licensePlate.text;
    NSString *serviceName      = _serviceName.text;
    NSNumber *notificationType = [NSNumber numberWithInteger:[_notificationType.text integerValue]];
    NSString *description      = _description.text;
    
    [[Server shared] insertVehicleWithPlate:licencePlate
                                serviceType:serviceName
                           notificationType:notificationType
                                description:description
                                   location:location
                                  imageList:imageListFinal
                                    success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        
                                        UIViewController *vc = [[CGTransitionViewController alloc] initWith:[CGMenuViewController class]];
                                        [self.navigationController pushViewController:vc animated:YES];

                                    }
                                    failure:^(RKObjectRequestOperation *operation, NSError *error)
                                    {
                                        NSLog(@"sendAction is Failure!");
                                    }];
    
    
}

@end

//
//  CGInformEditViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/10/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGInformEditViewController.h"

@interface CGInformEditViewController ()

@end

#define kTextFieldPaddingX 48.0f;

@implementation CGInformEditViewController

- (id)initWithVehicle:(VehicleListResponse*)vehicle
{
    self = [super init];
    if (self) {
        _vehicle = vehicle;
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    _groupView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    _groupView.contentSize = CGSizeMake(320, 600);
    [self.view addSubview:_groupView];
    
    _photoListView = [[UIView alloc] initWithFrame:CGRectMake(160 - 80, 38, 160, 160)];
    [_photoListView addSubview:[[UIImageView alloc] initWithImage:kApplicationImage(@"Photo1.png")]];
    [_groupView addSubview:_photoListView];
    
    _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLocationDarkLarge.png"]];
    _locationIcon.frame = CGRectMake(35, 228, 61, 46);
    [_groupView  addSubview:_locationIcon];
    
    _dataLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 236, 100, 20)];
    [_dataLabel setText:[CGUtilHelper dateFromJSONStringWith:_vehicle.createdDate]];
    [_dataLabel sizeToFit];
    [_groupView addSubview:_dataLabel];
    
    _addressLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 256, 100, 20)];
    _addressLabel.font = kApplicationFont(13.0f);
    [_addressLabel setText:_vehicle.location];
    [_addressLabel sizeToFit];
    [_groupView  addSubview:_addressLabel];
    
    // UITextFields
    _licensePlate = [[CGTextField alloc] initWithFrame:CGRectMake(35, 289, 250, 46)];
    [_licensePlate setText:_vehicle.licensePlate];
    [_licensePlate setDelegate:self];
    _licensePlate.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLicensePlateDark.png"]];
    _licensePlate.leftView.frame  = CGRectMake(14, 14, 24, 19);
    _licensePlate.leftViewMode = UITextFieldViewModeAlways;
    _licensePlate.paddingX = kTextFieldPaddingX;
    [_groupView  addSubview:_licensePlate];
    
    _serviceName = [[CGTextField alloc] initWithFrame:CGRectMake(35, 339, 250, 46)];
    [_serviceName setText:_vehicle.serviceType];
    [_serviceName setDelegate:self];
    _serviceName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconServiceNameDark.png"]];
    _serviceName.leftView.frame  = CGRectMake(14, 10, 24, 26);
    _serviceName.leftViewMode = UITextFieldViewModeAlways;
    _serviceName.paddingX = kTextFieldPaddingX;
    [_groupView  addSubview:_serviceName];
    
    NSArray *notificationList = kNotificationList;
    _notificationType = [[CGTextField alloc] initWithFrame:CGRectMake(35, 389, 250, 46)];
    [_notificationType setText:[notificationList objectAtIndex:[_vehicle.notificationType integerValue]]];
    [_notificationType setDelegate:self];
    _notificationType.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconNotificationTypeDark.png"]];
    _notificationType.leftView.frame  = CGRectMake(14, 10, 20, 24);
    _notificationType.leftViewMode = UITextFieldViewModeAlways;
    _notificationType.paddingX = kTextFieldPaddingX;
    [_groupView addSubview:_notificationType];
    
    _description = [[CGTextField alloc] initWithFrame:CGRectMake(35, 439, 250, 86)];
    [_description setText:_vehicle.description];
    [_description setDelegate:self];
    _description.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconCommentDark.png"]];
    _description.leftView.frame  = CGRectMake(14, 12, 20, 19);
    _description.leftViewMode = UITextFieldViewModeAlways;
    _description.paddingX = kTextFieldPaddingX;
    [_groupView  addSubview:_description];
    
    _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 540, 258, 52)];
    _saveButton.titleLabel.font = kApplicationFontBold(19.0f);
    [_saveButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue"] forState:UIControlStateNormal];
    [_saveButton setTitle:@"Kaydet" forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupView addSubview:_saveButton];
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
    [self setLeftButtonHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Override
- (void)rightAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITextFieldDelegete
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _groupView.scrollEnabled = YES;
    [_groupView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _groupView.scrollEnabled = NO;
    [_groupView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark Button Actionsx
- (void)saveAction:(id)sender
{
    NSArray *notificationList = kNotificationList;
    int notificationIndex = 0;
    
    //TODO: Delete later
    for (int i=0; i < notificationList.count; ++i) {
        NSString *notification = (NSString*)[notificationList objectAtIndex:i];
        if ([notification isEqualToString:_notificationType.text]) {
            notificationIndex = i;
            break;
        }
        
    }
    
    [[Server shared] updateVehicleWithPlate:_licensePlate.text
                                serviceType:_serviceName.text
                           notificationType:[NSNumber numberWithInt:notificationIndex]
                                description:_description.text
                                   location:_addressLabel.text
                                         ID:_vehicle.ID
                                    success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        
                                        UIViewController *vc = [[CGTransitionViewController alloc] initWith:[CGInformHistoryViewController class]];
                                        [self.navigationController pushViewController:vc animated:YES];
                                        
                                    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                        //
                                    }];
    
    
}

@end

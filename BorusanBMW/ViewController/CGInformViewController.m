//
//  CGInformViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/10/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGInformViewController.h"

#define kPhotoGalleryHeightGap 20

@interface CGInformViewController ()

@end

@implementation CGInformViewController

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
    _groupView.contentSize = CGSizeMake(320, 480);
    [self.view addSubview:_groupView];
    
    _textGroupView = [[UIView alloc] initWithFrame:CGRectMake(17, 217, 320, 205)];
    [_groupView addSubview:_textGroupView];
    
    _photoGallery = [[CGPhotoGalleryView alloc] initWithPoint:CGPointMake(0, kPhotoGalleryHeightGap) andList:[NSArray arrayWithArray:_vehicle.imageList]];
    [_groupView addSubview:_photoGallery];

    // Labels
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 250, 45)];
    _addressLabel.text = _vehicle.location;
    _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _addressLabel.numberOfLines = 0;
    _addressLabel.backgroundColor = [UIColor clearColor];
    [_addressLabel sizeToFit];
    [_textGroupView addSubview:_addressLabel];
    
    _licensePlateLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 51, 250, 20)];
    _licensePlateLabel.text = _vehicle.licensePlate;
    _licensePlateLabel.backgroundColor = [UIColor clearColor];
    [_textGroupView addSubview:_licensePlateLabel];
    
    _serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 87, 250, 20)];
    _serviceLabel.text = _vehicle.serviceType;
    _serviceLabel.backgroundColor = [UIColor clearColor];
    [_textGroupView addSubview:_serviceLabel];

    _notificationType = [[UILabel alloc] initWithFrame:CGRectMake(37, 121, 200, 20)];
    NSArray *_list = [DataService shared].notificationTypeList;
    for (NotificationTypeResponse* notif in _list) {
        if ([_vehicle.notificationType isEqual:notif.ID]) {
            _notificationType.text = notif.notificationType;
            NSLog(@"NotificationType=%@", _notificationType.text);
            break;
        }
    }
    _notificationType.lineBreakMode = NSLineBreakByWordWrapping;
    _notificationType.numberOfLines = 0;
    _notificationType.backgroundColor = [UIColor clearColor];
    [_textGroupView addSubview:_notificationType];
    
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 154, 250, 70)];
    _descriptionLabel.text = _vehicle.description;
    //_descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.backgroundColor = [UIColor clearColor];
    [_descriptionLabel sizeToFit];
    [_textGroupView addSubview:_descriptionLabel];
    
    // Icons
    _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLocationLight.png"]];
    _locationIcon.frame = CGRectMake(0, 0, 25, 19);
    [_textGroupView addSubview:_locationIcon];
    
    _licencePlateIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLicensePlateLight.png"]];
    _licencePlateIcon.frame = CGRectMake(1, 52, 24, 19);
    [_textGroupView addSubview:_licencePlateIcon];
    
    _serviceIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconServiceNameLight.png"]];
    _serviceIcon.frame = CGRectMake(1, 82, 24, 26);
    [_textGroupView addSubview:_serviceIcon];
    
    _notificationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconNotificationTypeLight.png"]];
    _notificationIcon.frame = CGRectMake(3, 118, 20, 24);
    [_textGroupView addSubview:_notificationIcon];
    
    _descriptionIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconCommentLight.png"]];
    _descriptionIcon.frame = CGRectMake(3, 155, 20, 19);
    [_textGroupView addSubview:_descriptionIcon];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override
- (void)rightAction:(id)sender
{
    UIViewController *vc = [[CGInformEditViewController alloc] initWithVehicle:_vehicle];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

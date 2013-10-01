//
//  CGInformViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/10/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBaseViewController.h"
#import "CGInformEditViewController.h"
#import "CGMenuViewController.h"
#import "CGLabel.h"
#import "VehicleListResponse.h"

@interface CGInformViewController : CGBaseViewController
{
    UIView *_photoListView;
    
    UIScrollView *_groupView;
    UIView *_textGroupView;
    
    UIImageView *_locationIcon;
    UIImageView *_licencePlateIcon;
    UIImageView *_serviceIcon;
    UIImageView *_notificationIcon;
    UIImageView *_descriptionIcon;
    
    UILabel *_addressLabel;
    UILabel *_licensePlateLabel;
    UILabel *_serviceLabel;
    UILabel *_notificationType;
    UILabel *_descriptionLabel;
    
    // Dynamic data
    VehicleListResponse *_vehicle;
}

- (id)initWithVehicle:(VehicleListResponse*)vehicle;

@end

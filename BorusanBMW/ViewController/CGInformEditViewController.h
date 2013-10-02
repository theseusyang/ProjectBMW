//
//  CGInformEditViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/10/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBaseViewController.h"
#import "CGTransitionViewController.h"
#import "CGTextField.h"
#import "CGLabel.h"
#import "CGInformHistoryViewController.h"
#import "CGUtilHelper.h"

@interface CGInformEditViewController : CGBaseViewController<UITextFieldDelegate, UIScrollViewDelegate>
{
    UIView *_photoListView;
    
    UIScrollView *_groupView;
    UIImageView *_locationIcon;
    CGLabel     *_dataLabel;
    CGLabel     *_addressLabel;
    
    CGTextField *_licensePlate;
    CGTextField *_serviceName;
    CGTextField *_notificationType;
    CGTextField *_description;
    
    UIButton    *_saveButton;
    
    // Dynamic data
    VehicleListResponse *_vehicle;
    
}

- (id)initWithVehicle:(VehicleListResponse*)vehicle;

@end
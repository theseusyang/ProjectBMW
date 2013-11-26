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
#import "CGUIView.h"
#import "CGUIView.h"
#import "CGLabel.h"
#import "CGInformHistoryViewController.h"
#import "CGUtilHelper.h"
#import "CGPhotoGalleryView.h"

@interface CGInformEditViewController : CGBaseViewController<UITextFieldDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate>
{
    CGPhotoGalleryView *_photoGallery;
    UIView *_photoListView;
    
    UIScrollView *_groupView;
    UIImageView *_locationIcon;
    CGLabel     *_dataLabel;
    CGLabel     *_addressLabel;
    
    CGTextField *_licensePlate;
    CGTextField *_serviceName;
    CGTextField *_notificationType;
    //CGTextField *_description;
    CGUIView *_description;
    
    UIButton    *_saveButton;
    UIButton    *_deleteButton;
    
    // Dynamic data
    VehicleListResponse *_vehicle;
    
    //Photo Picker
    UIPickerView *_imagePicker;
    NSArray* _notificationTypeList;
    
}

- (id)initWithVehicle:(VehicleListResponse*)vehicle;

@end

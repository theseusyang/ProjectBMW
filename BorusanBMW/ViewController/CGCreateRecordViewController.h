//
//  CGCreateRecordViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGMenuViewController.h"
#import "CGTransitionViewController.h"
#import "CGTextField.h"
#import "CGUIView.h"
#import "CGLabel.h"
#import "CGUtilHelper.h"
#import "LocationManager.h"
#import "Base64.h"
#import "RecordEntity.h"

@interface CGCreateRecordViewController : CGBaseViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>
{
    NSArray *_imageList;
    //Tesseract Plate Number
    NSString *_plateNumber;
    
    UIScrollView *_groupScrollView;
    
    UIImageView *_locationIcon;
    CGLabel     *_dateLabel;
    CGLabel     *_addressLabel;
    
    CGTextField *_licensePlate;
    CGTextField *_serviceName;
    CGTextField *_notificationType;
    CGUIView   *_description;
    
    //Photo Picker
    UIPickerView *_imagePicker;
    NSArray* _notificationTypeList;
    UIButton    *_sendButton;
}

- (id)initWithImageList:(NSArray *)imageList;
- (id)initWithImageList:(NSArray *)imageList andPlateNumber: (NSString*)plateNumber;

@end

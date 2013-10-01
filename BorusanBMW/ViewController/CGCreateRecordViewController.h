//
//  CGCreateRecordViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGMenuViewController.h"
#import "CGTextField.h"
#import "CGLabel.h"
#import "CGUtilHelper.h"
#import "LocationManager.h"
#import "Base64.h"

@interface CGCreateRecordViewController : CGBaseViewController<UITextFieldDelegate>
{
    UIImageView *_locationIcon;
    CGLabel     *_dataLabel;
    CGLabel     *_addressLabel;
    
    CGTextField *_licensePlate;
    CGTextField *_serviceName;
    CGTextField *_notificationType;
    CGTextField *_description;
    
    UIButton    *_sendButton;
}
@end

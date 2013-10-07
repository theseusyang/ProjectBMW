//
//  CGMainViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/3/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Security/Security.h>
#import <Foundation/Foundation.h>
#import "CGBaseViewController.h"
#import "CGLabel.h"
#import "LoginResponse.h"
#import "Base64.h"

@interface CGMainViewController : CGBaseViewController<UITextFieldDelegate>
{
    
    
    UIScrollView *_groupScrollView;
    UIImageView *_logoView;
    UITextField *_emailTextField;
    UITextField *_passwordTextField;
    CGLabel     *_errorLabel;
    UIButton    *_enteranceButton;
}

@end
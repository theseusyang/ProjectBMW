//
//  CGMainViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/3/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGBaseViewController.h"
#import "CGLabel.h"
#import "LoginResponse.h"

@interface CGMainViewController : CGBaseViewController<UITextFieldDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_logoView;
    UITextField *_emailTextField;
    UITextField *_passwordTextField;
    CGLabel     *_errorLabel;
    UIButton    *_enteranceButton;
}

@end
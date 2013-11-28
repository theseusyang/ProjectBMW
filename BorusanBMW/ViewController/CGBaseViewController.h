//
//  CGBaseViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/4/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#import "AppInfo.h"
#import "Resources.h"
#import "Server.h"
#import "Events.h"

@interface CGBaseViewController : UIViewController
{
    UIImageView *_bg;
    UIActivityIndicatorView *_spinner;
    
    UIButton *_leftButton;
    UIView *_leftButtonView;
    
    UIButton *_rightButton;
    UIView *_rightButtonView;
}

- (void)setCancelButton;
- (void)setEditButton;
- (void)setRightButtonHidden:(BOOL)state;
- (void)setLeftButtonHidden:(BOOL)state;
- (void)startSpinner;
- (void)stopSpinner;
- (void)leftAction:(id)sender;
- (void)rightAction:(id)sender;
- (void)backToController:(Class)classType;
@end

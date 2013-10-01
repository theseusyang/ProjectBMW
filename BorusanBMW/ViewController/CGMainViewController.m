//
//  CGMainViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/3/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGMainViewController.h"
#import "CGMenuViewController.h"
#import "CGTextField.h"
#import "CGUtilHelper.h"

@implementation CGMainViewController

-(id) init
{
    self = [super init];
    if (self) {
        NSLog(@"Init the BMW project.");
    }
    
    return self;
}

-(void) loadView
{
    [super loadView];

    _logoView = [[UIImageView alloc] initWithImage:kApplicationImage(kResLogo)];
    _logoView.frame = CGRectMake(91, 40, 140, 165);
    [self.view addSubview:_logoView];
    
    _emailTextField = [[CGTextField alloc] initWithFrame:CGRectMake(35, 235, 250, 46)];
    _emailTextField.placeholder = @"ePosta Adresi";
    _emailTextField.delegate    = self;
    [self.view addSubview:_emailTextField];
    
    _passwordTextField = [[CGTextField alloc] initWithFrame:CGRectMake(35, 291, 250, 46)];
    _passwordTextField.placeholder = @"Şifre";
    _passwordTextField.delegate    = self;
    [self.view addSubview:_passwordTextField];
    
    _errorLabel = [[CGLabel alloc] initWithFrame:CGRectMake(80, 336, 250, 46)];
    _errorLabel.textColor = kColorRed;
    _errorLabel.text = @"Yanlış email veya şifre girdiniz!";
    _errorLabel.hidden = YES;
    [self.view addSubview:_errorLabel];
    
    _enteranceButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 377, 258, 53)];
    [_enteranceButton setBackgroundImage:kApplicationImage(kResButtonBlue) forState:UIControlStateNormal];
    [_enteranceButton setTitle:@"Giriş Yap" forState:UIControlStateNormal];
    [_enteranceButton.titleLabel setFont:kApplicationFontBold(19.0f)];
    [_enteranceButton addTarget:self action:@selector(enterance_button:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enteranceButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES];
}

- (void)loadingHiddenState:(BOOL)hidden
{
    _emailTextField.hidden    = hidden;
    _passwordTextField.hidden = hidden;
    _errorLabel.hidden        = hidden;
    _enteranceButton.hidden   = hidden;
}

- (BOOL)checkUserWithErrorCode:(NSString*)errorCode errorMessage:(NSString*)errorMessage
{
    if ([errorCode isEqualToString:@"00"])
        return TRUE;
    
    _errorLabel.text = errorMessage;
    return FALSE;
}
    
#pragma mark Actions
-(void) enterance_button:(id)sender
{
    [self loadingHiddenState:YES];
    
    // Set data that will be send to backend
    NSString *username = _emailTextField.text;
    NSString *password = _passwordTextField.text;
    
    [self startSpinner];
    
    [[Server shared] loginWithUsername:username password:password success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        LoginResponse *loginResponse = (LoginResponse*)[mappingResult array][0];
        if([self checkUserWithErrorCode:loginResponse.errorCode errorMessage:loginResponse.errorMessage])
        {
            CGMenuViewController *vc = [CGMenuViewController new];
            [self.navigationController pushViewController:vc  animated:YES];
            [self startSpinner];
        }
        else
        {
            [self loadingHiddenState:NO];
            [self stopSpinner];
        }
        
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self loadingHiddenState:NO];
        [self stopSpinner];
    }];
    
}

#pragma mark UITextFieldDelegete
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end

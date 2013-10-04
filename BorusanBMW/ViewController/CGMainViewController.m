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
#import "AppInfo.h"

#define kEmailTextGap -100
#define kPasswordTextGap -100

#define kScrollHeight 400

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

    _groupScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight)];
    _groupScrollView.contentSize = CGSizeMake(kWindowWidth, kWindowWidth + kScrollHeight);
    _groupScrollView.scrollEnabled = FALSE;
    [self.view addSubview:_groupScrollView];
    
    _logoView = [[UIImageView alloc] initWithImage:kApplicationImage(kResLogo)];
    
    _logoView.frame = CGRectMake(91, 40, 140, 165);
    [_groupScrollView addSubview:_logoView];
    
    _emailTextField = [[CGTextField alloc] initWithFrame:CGRectMake(35, 235, 250, 46)];
    _emailTextField.placeholder = @"ePosta Adresi";
    _emailTextField.delegate    = self;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    [_groupScrollView addSubview:_emailTextField];
    
    _passwordTextField = [[CGTextField alloc] initWithFrame:CGRectMake(35, 291, 250, 46)];
    _passwordTextField.placeholder = @"Şifre";
    _passwordTextField.delegate    = self;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    [_groupScrollView addSubview:_passwordTextField];
    
    _errorLabel = [[CGLabel alloc] initWithFrame:CGRectMake(80, 336, 250, 46)];
    _errorLabel.textColor = kColorRed;
    _errorLabel.text = @"Yanlış email veya şifre girdiniz!";
    _errorLabel.hidden = YES;
    [_groupScrollView addSubview:_errorLabel];
    
    _enteranceButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 377, 258, 53)];
    [_enteranceButton setBackgroundImage:kApplicationImage(kResButtonBlue) forState:UIControlStateNormal];
    [_enteranceButton setTitle:@"Giriş Yap" forState:UIControlStateNormal];
    [_enteranceButton.titleLabel setFont:kApplicationFontBold(19.0f)];
    [_enteranceButton addTarget:self action:@selector(enterance_button:) forControlEvents:UIControlEventTouchUpInside];
    [_groupScrollView addSubview:_enteranceButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init Base64 starting point of the app.
    [Base64 initialize];
}

- (void)viewWillAppear:(BOOL)animated
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
        _errorLabel.hidden = TRUE;
        [self stopSpinner];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Server is not responding.." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}

#pragma mark UITextFieldDelegete
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    _groupScrollView.scrollEnabled = YES;
    [_groupScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap) animated:YES];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    [_groupScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    _groupScrollView.scrollEnabled = NO;
}

@end

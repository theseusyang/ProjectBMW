//
//  CGCreateRecordViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGCreateRecordViewController.h"
#import "CGTransitionViewController.h"

#define kTextFieldPaddingX 48.0f;
#define kScrollBar

#define kPickerViewWidth 320
#define kPickerViewHeight 217
#define kPickerViewRowWidth 320
#define kPickerViewRowHeight 45

#define kLabelPaddingX 70
#define kCheckIconPaddingX 32
#define kCheckIconSize 24
#define kCheckIconHeight (kPickerViewRowHeight - kCheckIconSize) / 2

@interface CGCreateRecordViewController ()

@end

@implementation CGCreateRecordViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageList:(NSArray *)imageList
{
    self = [super init];
    if (self) {
        _imageList = [NSArray arrayWithArray:imageList];
    }
    return self;
}

- (id)initWithImageList:(NSArray *)imageList andPlateNumber: (NSString*)plateNumber
{
    self = [super init];
    if (self) {
        _imageList = [NSArray arrayWithArray:imageList];
        _plateNumber = plateNumber;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    NSString* currentDateString = [CGUtilHelper currentDate];
    NSString* currentLocation = [[LocationManager shared] location];
    _notificationTypeList = [DataService shared].notificationTypeList;
    
    _groupScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeightWithNav)];
    _groupScrollView.contentSize = CGSizeMake(kWindowWidth, kWindowHeightWithNav + 200);
    _groupScrollView.scrollEnabled = NO;
    [self.view addSubview:_groupScrollView];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [_groupScrollView addGestureRecognizer:_tap];
    
    _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLocationDarkLarge.png"]];
    _locationIcon.frame = CGRectMake(35, 37, 61, 46);
    [_groupScrollView addSubview:_locationIcon];

    _dateLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 45, 100, 20)];
    [_dateLabel setText:currentDateString];
    [_dateLabel sizeToFit];
    _dateLabel.font = kApplicationFontBold(13.0);
    _dateLabel.textColor = kTextColor;
    [_groupScrollView addSubview:_dateLabel];

    _addressLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 65, 180, 40)];
    
    _addressLabel.font = kApplicationFont(13.0f);
    _addressLabel.textColor = kTextColor;
    _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _addressLabel.numberOfLines = 2;
    _addressLabel.backgroundColor = [UIColor clearColor];
    [_addressLabel setText:currentLocation];
    [_addressLabel sizeToFit];
    [_groupScrollView addSubview:_addressLabel];
    
    // UITextFields
    _licensePlate = [[CGTextField alloc] initWithFrame:CGRectMake(35, 98, 250, 46)];
    _licensePlate.text = _plateNumber;

    _licensePlate.font = kApplicationFontBold(16.0);
    _licensePlate.textColor = kTextColor;
    _licensePlate.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLicensePlateDark.png"]];
    _licensePlate.leftView.frame  = CGRectMake(14, 14, 24, 19);
    _licensePlate.defaultPlaceholder = @"Araç Plakası";
    _licensePlate.placeholder = _licensePlate.defaultPlaceholder;
    _licensePlate.leftViewMode = UITextFieldViewModeAlways;
    _licensePlate.paddingX = kTextFieldPaddingX;
    _licensePlate.backgroundColor = kColorClear;
    [_licensePlate addTarget:self action:@selector(didSellectCGTextView:) forControlEvents:UIControlEventEditingDidBegin];
    [_licensePlate setDelegate:self];
    [_groupScrollView addSubview:_licensePlate];
    
    _serviceName = [[CGTextField alloc] initWithFrame:CGRectMake(35, 148, 250, 46)];
    _serviceName.font = kApplicationFontBold(16.0);
    _serviceName.textColor = kTextColor;
    _serviceName.defaultPlaceholder = @"Servis Adı";
    _serviceName.placeholder = _serviceName.defaultPlaceholder;
    _serviceName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconServiceNameDark.png"]];
    _serviceName.leftView.frame  = CGRectMake(14, 10, 24, 26);
    _serviceName.leftViewMode = UITextFieldViewModeAlways;
    _serviceName.paddingX = kTextFieldPaddingX;
    [_serviceName addTarget:self action:@selector(didSellectCGTextView:) forControlEvents:UIControlEventEditingDidBegin];
    [_serviceName setDelegate:self];
    [_groupScrollView addSubview:_serviceName];
    
    // TODO: When touched, UIPickerWheel should appear.
    _notificationType = [[CGTextField alloc] initWithFrame:CGRectMake(35, 200, 250, 46)];
    _notificationType.font = kApplicationFontBold(16.0);
    _notificationType.textColor = kTextColor;
    _notificationType.defaultPlaceholder = @"Bildirim Tipi";
    _notificationType.placeholder = _notificationType.defaultPlaceholder;
    _notificationType.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconNotificationTypeDark.png"]];
    _notificationType.leftView.frame  = CGRectMake(14, 10, 20, 24);
    _notificationType.leftViewMode = UITextFieldViewModeAlways;
    _notificationType.paddingX = kTextFieldPaddingX;
    [_notificationType addTarget:self action:@selector(didSellectCGTextView:) forControlEvents:UIControlEventEditingDidBegin];
    [_notificationType setDelegate:self];
    [_groupScrollView addSubview:_notificationType];
    
    _description = [[CGUIView alloc] initWithFrame:CGRectMake(35, 248, 230, 86) andBackground:@"TextArea.png" andIcon:@"IconCommentDark.png" andText:Nil];
    [_description.textView setDelegate:self];
    //Return for fix
    _description.textView.font = kApplicationFontBold(16.0);
    _description.textView.textColor = kTextColor;
    _defaultDescription = @"Açıklama";
    _defaultDescriptionTextColor = [UIColor colorWithCGColor:_description.textView.textColor.CGColor];
    _placeholderDescriptionTextColor =[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:1];
    _description.textView.textColor = _placeholderDescriptionTextColor;
    _description.textView.text = _defaultDescription;
    [_groupScrollView addSubview:_description];
    
    _errorLabel = [[CGLabel alloc] initWithFrame:CGRectMake(35, 330, 250, 46)];
    _errorLabel.textColor = kColorRed;
    _errorLabel.text = @"Lütfen bütün kısımları doldurunuz.";
    _errorLabel.hidden = YES;
    [_groupScrollView addSubview:_errorLabel];
    
    _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(28, 350, 258, 52)];
    _sendButton.titleLabel.font = kApplicationFontBold(19.0f);
    [_sendButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue"] forState:UIControlStateNormal];
    [_sendButton setTitle:@"Gönder" forState:UIControlStateNormal];
    [_sendButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_sendButton setTitle:@"Gönder" forState:UIControlStateHighlighted];
    [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupScrollView addSubview:_sendButton];
    
    _imagePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kWindowHeightWithNav, kPickerViewWidth, kPickerViewHeight)];
    _imagePicker.delegate = self;
    _imagePicker.dataSource = self;
    _imagePicker.showsSelectionIndicator = YES;
    _imagePicker.hidden = NO;
    
    _errorAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"Lütfen bütün kısımları doldurun." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];    
    [_groupScrollView addSubview:_errorAlert];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    UIImage *pickerViewBackgroundImage = kApplicationImage(@"PickerViewBackground.png");
    _pickerViewBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, screenHeight - pickerViewBackgroundImage.size.height,
                                                                         pickerViewBackgroundImage.size.width,
                                                                         pickerViewBackgroundImage.size.height)];
    
    _pickerViewBackground.image = pickerViewBackgroundImage;
    _pickerViewBackground.hidden = YES;
    [_groupScrollView addSubview:_pickerViewBackground];

    
    

    [self.view addSubview:_imagePicker];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setCancelButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override
- (void)rightAction:(id)sender
{
    [self backToController:[CGMenuViewController class]];
}

-(void)dismissKeyboard
{
    [_licensePlate resignFirstResponder];
    [_serviceName resignFirstResponder];
    [self hidePickerWheel];
    [_description.textView resignFirstResponder];
}


#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Açıklama"])
    {
        _description.textView.text = @"";
        _description.textView.textColor = _defaultDescriptionTextColor;
    }
    
    _groupScrollView.scrollEnabled = YES;
    [_groupScrollView setContentOffset:CGPointMake(0, textView.superview.frame.origin.y - kTextTopScrollGap) animated:YES];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if( [textView.text isEqualToString:@""])
     {
         _description.textView.textColor = _placeholderDescriptionTextColor;
         _description.textView.text = _defaultDescription;
     }
    [self instantHidePickerWheel];
    [_groupScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    _groupScrollView.scrollEnabled = NO;
    
    
    //
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)didSellectCGTextView:(id)sender
{
    //((CGTextField*)sender).placeholder = nil;
}

#pragma mark UITextFieldDelegete
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self instantHidePickerWheel];
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if( [textField isEqual:_notificationType] )
    {
        [_licensePlate resignFirstResponder];
        [_serviceName resignFirstResponder];
        [_description.textView resignFirstResponder];
        [_groupScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap ) animated:YES];
        _groupScrollView.scrollEnabled = NO;
        [self showPickerWheel];
        if( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            _pickerViewBackground.frame = CGRectMake( 0, textField.frame.origin.y - kTextTopScrollGap + _pickerViewBackground.frame.size.height, _pickerViewBackground.frame.size.width, _pickerViewBackground.frame.size.height );
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self instantHidePickerWheel];
    textField.placeholder = nil;
    
    _groupScrollView.scrollEnabled = YES;
    [_groupScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap) animated:YES];
}
 
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqual:@""])
        if(![((CGTextField*)textField).defaultPlaceholder  isEqual: @"Bildirim Tipi"] )
            textField.placeholder = ((CGTextField*)textField).defaultPlaceholder;
    
    _groupScrollView.scrollEnabled = NO;
    //Check
    [_groupScrollView setContentOffset:CGPointMake(0, 0) animated:YES];

}

#pragma mark Button Actions
- (void)sendAction:(id)sender
{
    [_sendButton removeTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray *imageList = [[NSMutableArray alloc] init];
    UIImage  *originalImage;
    NSData   *imageData;
    NSString *imageEncoded;
    for (int i=0; i < [_imageList count]; ++i) {
        
        originalImage = [_imageList objectAtIndex:i];
        imageData     = UIImagePNGRepresentation(originalImage);
        imageEncoded  = [Base64 encode:imageData];
        // Zip Base64 data
        
        [imageList addObject:imageEncoded];
    }
    
    NSArray *imageListFinal = [NSArray arrayWithArray:imageList];
    // Set data that will be send to backend
    NSString *location         = _addressLabel.text;
    NSString *licencePlate     = _licensePlate.text;
    NSString *serviceName      = _serviceName.text;
    NSString *description      = _description.textView.text;
    
    if( [location isEqualToString:@""] || [licencePlate isEqualToString:@""] || [serviceName isEqualToString:@""] || [description isEqualToString:@""] || [location isEqualToString:Nil] || [licencePlate isEqualToString:Nil] || [serviceName isEqualToString:Nil] || [description isEqualToString:Nil])
    {
        [_errorAlert show];
        return;
        
    }
    
    NSNumber *notifID;
    
    for (NotificationTypeResponse* notif in _notificationTypeList) {
        if ([_notificationType.text isEqualToString:notif.notificationType]) {
            notifID = notif.ID;
            break;
        }
    }
    
    RecordEntity *insertRecord = [RecordEntity new];
    insertRecord.licencePlate = licencePlate;
    insertRecord.serviceName = serviceName;
    insertRecord.notificationID = notifID;
    insertRecord.description = description;
    insertRecord.location = location;
    insertRecord.imageList = imageListFinal;
    insertRecord.ID = [NSNumber numberWithInt:-1]; // Not used for this data.
    
    UIViewController *vc = [[CGTransitionViewController alloc] initWith:[CGMenuViewController class] recordEntity:insertRecord andObject:self];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _notificationTypeList.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kPickerViewRowHeight;
}

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NotificationTypeResponse* notificationType = (NotificationTypeResponse*)[_notificationTypeList objectAtIndex:row];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kLabelPaddingX, 0, kPickerViewWidth, kPickerViewRowHeight)];
    label.textColor         = kTextColorLight;
    label.font              = kApplicationFontBold(26.0f);
    label.backgroundColor   = kColorClear;
    label.textAlignment     = NSTextAlignmentLeft;
    label.text = notificationType.notificationType;
    
    UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPickerViewWidth, kPickerViewRowHeight)];
    [rowView addSubview:label];
    
    return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UIView *view = [pickerView viewForRow:row forComponent:component];
    UILabel *label = view.subviews[0];
    _notificationType.text = label.text;
    
    [self hidePickerWheel];
}
     
#pragma mark
- (void)showPickerWheel
{
    [UIView animateWithDuration:0.1f animations:^{
        _imagePicker.frame = CGRectMake(0, kWindowHeightWithNav - kPickerViewHeight, kPickerViewWidth, kPickerViewHeight);
    } completion:^(BOOL finished) {
        _imagePicker.hidden = NO;
        if( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            _pickerViewBackground.hidden = NO;
    }];
}

- (void)hidePickerWheel
{
    _pickerViewBackground.hidden = YES;
    [UIView animateWithDuration:0.5f animations:^{
        _imagePicker.frame = CGRectMake(0, kWindowHeightWithNav, kPickerViewWidth, kPickerViewHeight);
        [_groupScrollView setContentOffset:CGPointMake(0, 0)];
    } completion:^(BOOL finished) {
        _imagePicker.hidden = YES;
    }];
    
}

- (void)instantHidePickerWheel
{
    _pickerViewBackground.hidden = YES;
    [UIView animateWithDuration:0.1f animations:^{
        _imagePicker.frame = CGRectMake(0, kWindowHeightWithNav, kPickerViewWidth, kPickerViewHeight);
    } completion:^(BOOL finished) {
        _imagePicker.hidden = YES;
    }];
    _groupScrollView.scrollEnabled = YES;
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
}


@end

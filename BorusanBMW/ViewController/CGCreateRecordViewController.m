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
    
    _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLocationDarkLarge.png"]];
    _locationIcon.frame = CGRectMake(35, 37, 61, 46);
    [_groupScrollView addSubview:_locationIcon];

    _dateLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 45, 100, 20)];
    [_dateLabel setText:currentDateString];
    [_dateLabel sizeToFit];
    [_groupScrollView addSubview:_dateLabel];
    
    _addressLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 58, 180, 40)];
    
    _addressLabel.font = kApplicationFont(13.0f);
    _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _addressLabel.numberOfLines = 2;
    _addressLabel.backgroundColor = [UIColor clearColor];
    [_addressLabel setText:currentLocation];
    [_addressLabel sizeToFit];
    [_groupScrollView addSubview:_addressLabel];
    
    // UITextFields
    _licensePlate = [[CGTextField alloc] initWithFrame:CGRectMake(35, 98, 250, 46)];
    if( !_plateNumber )
        _licensePlate.placeholder = @"Plaka giriniz"; //TODO: Dummy data
    else
    {
        _licensePlate.text = _plateNumber;
        _licensePlate.placeholder = _plateNumber;
    }
    _licensePlate.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLicensePlateDark.png"]];
    _licensePlate.leftView.frame  = CGRectMake(14, 14, 24, 19);
    _licensePlate.leftViewMode = UITextFieldViewModeAlways;
    _licensePlate.paddingX = kTextFieldPaddingX;
    _licensePlate.backgroundColor = kColorBlue;
    [_licensePlate setDelegate:self];
    [_groupScrollView addSubview:_licensePlate];
    
    _serviceName = [[CGTextField alloc] initWithFrame:CGRectMake(35, 148, 250, 46)];
    _serviceName.placeholder = @"Servis Adı"; //TODO: Dummy data
    _serviceName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconServiceNameDark.png"]];
    _serviceName.leftView.frame  = CGRectMake(14, 10, 24, 26);
    _serviceName.leftViewMode = UITextFieldViewModeAlways;
    _serviceName.paddingX = kTextFieldPaddingX;
    [_serviceName setDelegate:self];
    [_groupScrollView addSubview:_serviceName];
    
    // TODO: When touched, UIPickerWheel should appear.
    _notificationType = [[CGTextField alloc] initWithFrame:CGRectMake(35, 200, 250, 46)];
    _notificationType.placeholder = @"Bildirim Tipi"; //TODO: Dummy data
    _notificationType.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconNotificationTypeDark.png"]];
    _notificationType.leftView.frame  = CGRectMake(14, 10, 20, 24);
    _notificationType.leftViewMode = UITextFieldViewModeAlways;
    _notificationType.paddingX = kTextFieldPaddingX;
    [_notificationType setDelegate:self];
    [_groupScrollView addSubview:_notificationType];
    
    _description = [[CGUIView alloc] initWithFrame:CGRectMake(35, 248, 240, 86) andBackground:@"TextArea.png" andIcon:@"IconCommentDark.png" andText:Nil];
    [_description.textView setDelegate:self];
    [_groupScrollView addSubview:_description];
    
    /*
    _description = [[CGTextField alloc] initWithFrame:CGRectMake(35, 248, 250, 86)];
    _description.placeholder = @"Açıklama"; //TODO: Dummy data
    
    _description.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconCommentDark.png"]];
    _description.leftView.frame  = CGRectMake(14, 12, 20, 19);
    _description.leftViewMode = UITextFieldViewModeAlways;
    //_description.paddingX = kTextFieldPaddingX;
    [_description setDelegate:self];
    [_groupScrollView addSubview:_description];
    */
    
    /*
    _description = [[UITextView alloc] initWithFrame:CGRectMake(35, 248, 250, 86)];
    _description.text = @"Açıklama"; //TODO: Dummy data
    UIImageView *icon =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconCommentDark.png"]];
    UIImageView *textBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TextArea@2x.png"]];
    icon.frame = CGRectMake(14, 12, 20, 19);
    textBackground.frame = CGRectMake(35, 248, 250, 86);
    [_description addSubview:icon];
    [_groupScrollView addSubview:textBackground];
    _description.backgroundColor = [UIColor clearColor];
    
    [_description setDelegate:self];
    [_groupScrollView addSubview:_description];
    */
     
    _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(28, 350, 258, 52)];
    _sendButton.titleLabel.font = kApplicationFontBold(19.0f);
    [_sendButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue"] forState:UIControlStateNormal];
    [_sendButton setTitle:@"Gönder" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupScrollView addSubview:_sendButton];
    
    _imagePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kWindowHeightWithNav, kPickerViewWidth, kPickerViewHeight)];
    _imagePicker.delegate = self;
    _imagePicker.dataSource = self;
    _imagePicker.showsSelectionIndicator = YES;
    _imagePicker.hidden = NO;
    

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

#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _groupScrollView.scrollEnabled = YES;
    [_groupScrollView setContentOffset:CGPointMake(0, textView.superview.frame.origin.y - kTextTopScrollGap) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    _groupScrollView.scrollEnabled = NO;
    [_groupScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
/*
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(){
        return YES;
    } else {
        return NO;
    }
}
*/

#pragma mark UITextFieldDelegete
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self instantHidePickerWheel];
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_notificationType]) {
        [self performSelector:@selector(hideKeyboard:) withObject:textField afterDelay:0.1f];
    }
    
    _groupScrollView.scrollEnabled = YES;
    [_groupScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap) animated:YES];
}

//TODO: Saçma sapan bir çözüm, nedenini araştır!
-(void)hideKeyboard:(id)sender
{
    [self showPickerWheel];
    UITextField *text = (UITextField*)sender;
    [self.view endEditing:YES];
    [text resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _groupScrollView.scrollEnabled = NO;
    [_groupScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark Button Actions
- (void)sendAction:(id)sender
{
    [_sendButton removeTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray *imageList = [[NSMutableArray alloc] init];
    for (int i=0; i < [_imageList count]; ++i) {
        
        UIImage *image = [_imageList objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        

        // Make small the pic - UIGraphics~
        UIGraphicsBeginImageContext(CGSizeMake(70, 70));
            [imageView.image drawInRect:CGRectMake(0,0,70,70)];
            UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(newImage);
        NSString *imageEncoded = [Base64 encode:imageData];
        [imageList addObject:imageEncoded];
    }
    
    NSArray *imageListFinal = [NSArray arrayWithArray:imageList];
    // Set data that will be send to backend
    NSString *location         = _addressLabel.text;
    NSString *licencePlate     = _licensePlate.text;
    NSString *serviceName      = _serviceName.text;
    NSString *description      = _description.textView.text;
    
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
    
    UIViewController *vc = [[CGTransitionViewController alloc] initWith:[CGMenuViewController class] recordEntity:insertRecord];
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
    }];
}

- (void)hidePickerWheel
{
    [UIView animateWithDuration:1.0f animations:^{
        _imagePicker.frame = CGRectMake(0, kWindowHeightWithNav, kPickerViewWidth, kPickerViewHeight);
    } completion:^(BOOL finished) {
        _imagePicker.hidden = YES;
    }];
}

- (void)instantHidePickerWheel
{
    [UIView animateWithDuration:0.1f animations:^{
        _imagePicker.frame = CGRectMake(0, kWindowHeightWithNav, kPickerViewWidth, kPickerViewHeight);
    } completion:^(BOOL finished) {
        _imagePicker.hidden = YES;
    }];
}

@end

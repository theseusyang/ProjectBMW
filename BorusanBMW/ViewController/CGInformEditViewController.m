//
//  CGInformEditViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/10/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGInformEditViewController.h"

@interface CGInformEditViewController ()

@end

#define kTextFieldPaddingX 48.0f;
#define kPhotoGalleryHeightGap 20

#define kPickerViewWidth 320
#define kPickerViewHeight 217
#define kPickerViewRowWidth 320
#define kPickerViewRowHeight 45

#define kLabelPaddingX 70
#define kCheckIconPaddingX 32
#define kCheckIconSize 24
#define kCheckIconHeight (kPickerViewRowHeight - kCheckIconSize) / 2

@implementation CGInformEditViewController

- (id)initWithVehicle:(VehicleListResponse*)vehicle
{
    self = [super init];
    if (self) {
        _vehicle = vehicle;
        _notificationTypeList = [DataService shared].notificationTypeList;
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    _groupView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    _groupView.contentSize = CGSizeMake(320, 660);
    [self.view addSubview:_groupView];
    
    _photoGallery = [[CGPhotoGalleryView alloc] initWithPoint:CGPointMake(0, kPhotoGalleryHeightGap) andList:[NSArray arrayWithArray:_vehicle.imageList] andViewController:self isDeleteActive:NO];
    [_groupView addSubview:_photoGallery];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [_groupView addGestureRecognizer:_tap];
    
    _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLocationDarkLarge.png"]];
    _locationIcon.frame = CGRectMake(35, 228, 61, 46);
    [_groupView  addSubview:_locationIcon];
    
    _dataLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 236, 100, 20)];
    _dataLabel.font = kApplicationFontBold(16.0);
    _dataLabel.textColor = kTextColor;
    [_dataLabel setText:[CGUtilHelper dateFromJSONStringWith:_vehicle.createdDate]];
    [_dataLabel sizeToFit];
    [_groupView addSubview:_dataLabel];
    
    _addressLabel = [[CGLabel alloc] initWithFrame:CGRectMake(107, 256, 200, 20)];
    _addressLabel.backgroundColor = [UIColor clearColor];
    _addressLabel.font = kApplicationFont(13.0f);
    _addressLabel.textColor = kTextColor;
    [_addressLabel setNumberOfLines:2];
    [_addressLabel setText:_vehicle.location];
    [_addressLabel sizeToFit];
    [_groupView  addSubview:_addressLabel];
    
    // UITextFields
    _licensePlate = [[CGTextField alloc] initWithFrame:CGRectMake(35, 289, 250, 46)];
    [_licensePlate setText:_vehicle.licensePlate];
    [_licensePlate setDelegate:self];
    _licensePlate.font = kApplicationFontBold(16.0f);
    _licensePlate.textColor = kTextColor;
    _licensePlate.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLicensePlateDark.png"]];
    _licensePlate.leftView.frame  = CGRectMake(14, 14, 24, 19);
    _licensePlate.leftViewMode = UITextFieldViewModeAlways;
    _licensePlate.paddingX = kTextFieldPaddingX;
    [_groupView  addSubview:_licensePlate];
    
    _serviceName = [[CGTextField alloc] initWithFrame:CGRectMake(35, 339, 250, 46)];
    [_serviceName setText:_vehicle.serviceType];
    [_serviceName setDelegate:self];
    _serviceName.font = kApplicationFontBold(16.0);
    _serviceName.textColor = kTextColor;
    _serviceName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconServiceNameDark.png"]];
    _serviceName.leftView.frame  = CGRectMake(14, 10, 24, 26);
    _serviceName.leftViewMode = UITextFieldViewModeAlways;
    _serviceName.paddingX = kTextFieldPaddingX;
    [_groupView  addSubview:_serviceName];

    _notificationType = [[CGTextField alloc] initWithFrame:CGRectMake(35, 389, 250, 46)];
    _notificationType.font = kApplicationFontBold(16.0);
    _notificationType.textColor = kTextColor;
    [_notificationType setDelegate:self];
    NSArray *_list = [DataService shared].notificationTypeList;
    for (NotificationTypeResponse* notif in _list) {
        if ([_vehicle.notificationType isEqual:notif.ID]) {
            _notificationType.text = notif.notificationType;
            break;
        }
    }
    _notificationType.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconNotificationTypeDark.png"]];
    _notificationType.leftView.frame  = CGRectMake(14, 10, 20, 24);
    _notificationType.leftViewMode = UITextFieldViewModeAlways;
    _notificationType.paddingX = kTextFieldPaddingX;
    _notificationType.allowsEditingTextAttributes = NO;
    
    [_groupView addSubview:_notificationType];
    
    
    _description = [[CGUIView alloc] initWithFrame:CGRectMake(35, 439, 230, 86) andBackground:@"TextArea.png" andIcon:@"IconCommentDark.png" andText:Nil];
    [_description.textView setDelegate:self];
    _description.textView.font = kApplicationFontBold(16.0);
    _description.textView.textColor = kTextColor;
    _description.textView.text = _vehicle.description;
    [_groupView addSubview:_description];
     
    _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 540, 258, 52)];
    _saveButton.titleLabel.font = kApplicationFontBold(19.0f);
    [_saveButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue"] forState:UIControlStateNormal];
    [_saveButton setTitle:@"Kaydet" forState:UIControlStateNormal];
    [_saveButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_saveButton setTitle:@"Kaydet" forState:UIControlStateHighlighted];
    [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupView addSubview:_saveButton];
    
    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 600, 258, 53)];
    _deleteButton.titleLabel.font = kApplicationFontBold(19.0f);
    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"ButtonRed"] forState:UIControlStateNormal];
    [_deleteButton setTitle:@"Sil" forState:UIControlStateNormal];
    [_deleteButton setBackgroundImage:kApplicationImage(kResButtonPressed) forState:UIControlStateHighlighted];
    [_deleteButton setTitle:@"Sil" forState:UIControlStateHighlighted];
    [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupView addSubview:_deleteButton];
    
    _imagePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kWindowHeightWithNav, kPickerViewWidth, kPickerViewHeight)];
    _imagePicker.delegate = self;
    _imagePicker.dataSource = self;
    _imagePicker.showsSelectionIndicator = YES;
    _imagePicker.hidden = NO;
    _imagePicker.backgroundColor = kColorClear;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    UIImage *pickerViewBackgroundImage = kApplicationImage(@"PickerViewBackground.png");
    _pickerViewBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, screenHeight - pickerViewBackgroundImage.size.height,
        pickerViewBackgroundImage.size.width,
        pickerViewBackgroundImage.size.height)];
    
    _pickerViewBackground.image = pickerViewBackgroundImage;
    _pickerViewBackground.hidden = YES;
    [_groupView addSubview:_pickerViewBackground];
    
    
    _deleteAlert = [[UIAlertView alloc]initWithTitle:Nil message:@"Bildiriyi silmek istediğinizden eminmisiniz?" delegate:self cancelButtonTitle: @"Evet" otherButtonTitles:@"Hayır", nil];
    
    
    [self.view addSubview:_imagePicker];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if( _addressLabel.frame.size.height > 20)
    {
        [self moveView:_licensePlate verticallyFor:10.0];
        [self moveView:_serviceName verticallyFor:10.0];
        [self moveView:_notificationType verticallyFor:10.0];
        [self moveView:_description verticallyFor:10.0];
        //Since we will add another button didn't moved this button
        [self moveView:_saveButton verticallyFor:0.0];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setCancelButton];
    [self setLeftButtonHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveView:(UIView*) view verticallyFor:(float) y
{
    
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + y, view.frame.size.width, view.frame.size.height);
}
//Override
- (void)rightAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissKeyboard
{
    [_licensePlate resignFirstResponder];
    [_serviceName resignFirstResponder];
    [self hidePickerWheel];
    [_description.textView resignFirstResponder];
}

#pragma mark UIAlertView
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        //Delete
        RecordEntity *deleteRecord = [RecordEntity new];
        deleteRecord.ID = _vehicle.ID;
        
        UIViewController *vc = [[CGTransitionViewController alloc] initWith:[CGInformHistoryViewController class] deleteEntity:deleteRecord vehicleResponse:_vehicle andObject:self];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if(buttonIndex == 1)
    {
        //Cancel
    }
}

#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{

    [_groupView setContentOffset:CGPointMake(0, textView.superview.frame.origin.y - kTextTopScrollGap) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    [_groupView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
        [_groupView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap ) animated:YES];
        _groupView.scrollEnabled = NO;
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
    
    _groupView.scrollEnabled = YES;
    [_groupView setContentOffset:CGPointMake(0, textField.frame.origin.y - kTextTopScrollGap) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqual:@""])
        if(![((CGTextField*)textField).defaultPlaceholder  isEqual: @"Bildirim Tipi"] )
            textField.placeholder = ((CGTextField*)textField).defaultPlaceholder;
    
    _groupView.scrollEnabled = YES;
    //Check
    [_groupView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark Button Actionsx
- (void)saveAction:(id)sender
{
    NSNumber *notifID;
    
    NSLog(@"NotificationType: %@", _notificationType.text);
    
    for (NotificationTypeResponse* notif in _notificationTypeList) {
        if ([_notificationType.text isEqualToString:notif.notificationType]) {
            notifID = notif.ID;
            break;
        }
    }
    
    RecordEntity *editRecord = [RecordEntity new];
    editRecord.licencePlate = _licensePlate.text;
    editRecord.serviceName = _serviceName.text;
    editRecord.notificationID = notifID;
    editRecord.description = _description.textView.text;
    editRecord.location = _addressLabel.text;
    editRecord.ID = _vehicle.ID;
    
    UIViewController *vc = [[CGTransitionViewController alloc] initWith:[CGInformHistoryViewController class] editEntity:editRecord vehicleResponse:_vehicle andObject:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteAction:(id)sender
{
    [_deleteAlert show];
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
    label.textColor         = kTextColor;
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

#pragma mark PickerWheel
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
        [_groupView setContentOffset:CGPointMake(0, 0)];
    } completion:^(BOOL finished) {
        _imagePicker.hidden = YES;
        _groupView.scrollEnabled = YES;
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
    _groupView.scrollEnabled = YES;
}

- (void)updateClientData:(NSNumber*)notifID
{
    // Update the client-side vehicle data
    _vehicle.licensePlate = _licensePlate.text;
    _vehicle.serviceType = _serviceName.text;
    _vehicle.notificationType = [NSNumber numberWithInteger:[notifID integerValue]];
    _vehicle.description = _description.textView.text;
}

@end

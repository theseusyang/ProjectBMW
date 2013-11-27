//
//  CGTransitionViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGTransitionViewController.h"
#import "CGMenuViewController.h"

@interface CGTransitionViewController ()

@end

@implementation CGTransitionViewController

- (id)initWith:(Class)classType
{
    self = [super init];
    if (self) {
        _classTypeToTurnBack = classType;
    }
    
    return self;
}

- (id)initWith:(Class)classType recordEntity:(RecordEntity *)entity andObject :(id)object
{
    self = [super init];
    if (self) {
        _classTypeToTurnBack = classType;
        _entity = entity;
        _transitionType = TransitionTypeInsert;
        _object = object;
        
    }
    
    return self;
}

- (id)initWith:(Class)classType editEntity:(RecordEntity *)entity vehicleResponse:(VehicleListResponse *)response andObject:(id)object
{
    self = [super init];
    if (self) {
        _classTypeToTurnBack = classType;
        _entity = entity;
        _vehicle = response;
        _transitionType = TransitionTypeEdit;
        _object = object;
    }
    
    return self;
}

- (id)initWith:(Class)classType deleteEntity:(RecordEntity *)entity vehicleResponse:(VehicleListResponse *)response andObject:(id)object
{
    self = [super init];
    if (self) {
        _classTypeToTurnBack = classType;
        _entity = entity;
        _vehicle = response;
        _transitionType = TransitionTypeDelete;
        _object = object;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _centerX = (320 - 84) / 2;
    _centerY = (416 - 84) / 2;
    
    _loadingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Loader.png"]];
    _loadingImage.frame = CGRectMake(118, 130, 84, 84);
    
    [self.view addSubview:_loadingImage];
    
    _iconSucceededImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconSucceeded.png"]];
    _iconSucceededImage.frame = CGRectMake(130, 147, 60, 47);
    [_iconSucceededImage setHidden:YES];
    [self.view addSubview:_iconSucceededImage];
    
    _topLabel = [[CGLabel alloc] initWithFrame:CGRectMake(10, _centerY + 80, 300, 16)];
    if( [_object isKindOfClass:[CGCreateRecordViewController class]])
        _topLabel.text = @"Bildiri Gönderiliyor...";
    else
        _topLabel.text = @"Bildiri Güncelleniyor...";
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLabel.font = kApplicationFontBold(16.0);
    _topLabel.textColor = kTextColor;
    //[_topLabel sizeToFit];
    [self.view addSubview:_topLabel];
    
    _bottomLabel = [[CGLabel alloc] initWithFrame:CGRectMake( 10, _centerY + 100, 300, 14)];
    _bottomLabel.text = @"Lütfen bekleyin.";
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.font = kApplicationFont(13.0f);
    _bottomLabel.textColor = kTextColor;
    //[_bottomLabel sizeToFit];
    [self.view addSubview:_bottomLabel];
    
    if( !_timer.isValid ){
        _timer = [NSTimer timerWithTimeInterval:0.06f target:self selector:(@selector(rotateImage:)) userInfo:(nil) repeats:YES];
    }

    NSRunLoop *runner =[NSRunLoop currentRunLoop];
    [runner addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    if (_transitionType == TransitionTypeInsert) {
        [self insertRecord];
    }else if(_transitionType == TransitionTypeEdit){
        [self editRecord];
    }else if (_transitionType == TransitionTypeDelete){
        [self deleteRecord];
    }
    
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
    [self setRightButtonHidden:YES];
    [self setLeftButtonHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertRecord
{
    [[Server shared] insertVehicleWithPlate:_entity.licencePlate
                                serviceType:_entity.serviceName
                           notificationType:_entity.notificationID
                                description:_entity.description
                                   location:_entity.location
                                  imageList:_entity.imageList
                                    success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        
                                        VehicleListResponse *vehicle = [mappingResult array][0];
                                        [[DataService shared] addRecord:vehicle];
                                        [self changeTransitionState:TransitionStateSucceeded];
                                        
                                    }
                                    failure:^(RKObjectRequestOperation *operation, NSError *error)
                                    {
                                        NSLog(@"sendAction is Failure!");
                                    }];
}

- (void)editRecord
{

    [[Server shared] updateVehicleWithPlate:_entity.licencePlate
                                serviceType:_entity.serviceName
                           notificationType:_entity.notificationID
                                description:_entity.description
                                   location:_entity.location
                                         ID:_entity.ID
                                    success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        
                                        [self updateClientData];
                                        [self changeTransitionState:TransitionStateSucceeded];

                                    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                        NSLog(@"Failure");
                                    }];

}

- (void)deleteRecord
{
    [[Server shared] deleteVehicleRecordWithHash:[[DataService shared] getHash] ID:_entity.ID success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [[DataService shared] deleteRecord:_vehicle];
        [self changeTransitionState:TransitionStateSucceeded];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"deleteRecord is failed!");
    }];
}

- (void)rotateImage:(id)sender
{
    _loadingImage.transform = CGAffineTransformMakeRotation(_count * M_PI/6);
    _count++;
}

- (void)updateClientData
{
    // Update the client-side vehicle data
    _vehicle.licensePlate     = _entity.licencePlate;
    _vehicle.serviceType      = _entity.serviceName;
    _vehicle.notificationType = _entity.notificationID;
    _vehicle.description      = _entity.description;
    //_vehicle.imageList        = [_entity.imageList copy];
}

#pragma mark Change Transition State
- (void)changeTransitionState:(TransitionState)transitionState
{
    
    if (transitionState == TransitionStateSucceeded) {
        //_topLabel.frame = CGRectMake(_centerX - 30, _centerY + 80, 120, 16);
        if( [_object isKindOfClass:[CGCreateRecordViewController class]])
            _topLabel.text = @"Bildiri Gönderildi!";
        else
            _topLabel.text = @"Bildiri Güncellendi!";
        //_bottomLabel.frame = CGRectMake(_centerX - 30, _centerY + 100, 140, 14);
        _bottomLabel.text = @"Teşekkürler";
        //[_topLabel sizeToFit];
        //[_bottomLabel sizeToFit];
        //_topLabel.textAlignment = NSTextAlignmentCenter;
        //_bottomLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        //_topLabel.frame = CGRectMake(_centerX - 20, _centerY + 80, 120, 16);
        _topLabel.text = @"Bir Hata Oluştu!";
        //_bottomLabel.frame = CGRectMake(_centerX + 10, _centerY + 104, 140, 14);
        _bottomLabel.text = @"Daha Sonra Tekrar Deneyiniz.";
        //[_topLabel sizeToFit];
        //[_bottomLabel sizeToFit];
    }
    
    [_timer invalidate];
    _timer = nil;
    
    [_loadingImage setHidden:!_loadingImage.isHidden];
    [_iconSucceededImage setHidden:!_iconSucceededImage.isHidden];
    
    [self performSelector:@selector(backToMenu) withObject:nil afterDelay:2.0f];
}

- (void)backToMenu
{
    NSLog(@"Back to the future...");
    //[self.navigationController popToViewController:_viewControllerToReturn animated:YES];
    [self backToController:_classTypeToTurnBack];
}

@end

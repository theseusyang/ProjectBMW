//
//  CGInformHistoryViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGInformHistoryViewController.h"

@interface CGInformHistoryViewController ()

@end

@implementation CGInformHistoryViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _vehicleList = [NSMutableArray array];
    _vehicleList = [[DataService shared] getVehicleList];
    
    _loadingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Loader.png"]];
    _loadingImage.frame = CGRectMake(118, 130, 84, 84);
    [self.view addSubview:_loadingImage];
    
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 300, 14)];
    _topLabel.text = @"Bildiriler Yükleniyor...";
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLabel.font = kApplicationFontBold(16.0);
    _topLabel.textColor = kTextColor;
    //[_topLabel sizeToFit];
    [self.view addSubview:_topLabel];
    
    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake( 10, 240, 300, 14)];
    _bottomLabel.text = @"Lütfen bekleyin";
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.font = kApplicationFont(13.0f);
    _bottomLabel.textColor = kTextColor;
    //[_bottomLabel sizeToFit];
    [self.view addSubview:_bottomLabel];
    
    if( !_timer.isValid ){
        _timer = [NSTimer timerWithTimeInterval:0.06f target:self selector:(@selector(rotateImage)) userInfo:(nil) repeats:YES];
    }
    
    
    NSRunLoop *runner =[NSRunLoop currentRunLoop];
    [runner addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    if (![self isLastPageReached]) {
        _moreCell = [[CGMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreCellIdentifier"];
        _moreCell.textLabel.text = @"daha fazla öğe...";
       // _moreCell.textLabel.frame = CGRectMake(_moreCell.frame.origin.x, _moreCell.frame.origin.y, _moreCell.frame.size.width, _moreCell.frame.size.height+30);
        _moreCell.textLabel.font = kApplicationFontBold(12.5f);
    }
    
    //Custom Spinner
    
    
    /*
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setRightButtonHidden:YES];
    
    //Delete below after try
    //[self startSpinner];
    
    if (_vehicleList.count <= 0) {
        // New Get List Method
        [[DataService shared] getVehicleListWithSuccess:^(NSMutableArray *vehicleList) {
            
            _vehicleImageList = [NSMutableArray array];
            _vehicleList = [NSMutableArray arrayWithArray:vehicleList];
            
            [self sortListWithDate];
            [self setVehicleImageList];
            
            [_loadingImage removeFromSuperview];
            //Delete below after try
            //[self stopSpinner];
            if(_timer.isValid)
            {
                [_timer invalidate];
                _timer = Nil;
            }
            
            [self createTableView];
            
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }else
    {
        if (_vehicleImageList == nil) {
            _vehicleImageList = [NSMutableArray array];
        }
        // Data is already in DataService
        [self sortListWithDate];
        [self setVehicleImageList]; // ?
        //[self stopSpinner];
        
        
        if(_timer.isValid)
        {
            [_timer invalidate];
            _timer = Nil;
        }
        
        [self createTableView];
    }
    
    // Sadece ilk açıldığında data ilklenmemiş ise notification aracılığıyla haberdar ediliyor. Daha sonra notif kaldırılıyor.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVehicleList:) name:kEventGetVehicleList object:nil];
}

- (void)updateVehicleList:(id)object
{
    _vehicleList = [[DataService shared] getVehicleList];
    
    if (_vehicleImageList == nil) {
        _vehicleImageList = [NSMutableArray array];
    }
    
    [self setVehicleImageList];
    [_moreCell stopAnimation];
    if (_informHistoryTableView) {
        [_informHistoryTableView reloadData];
    }
    else
    {
        [self setVehicleImageList];
        [self createTableView];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kEventGetVehicleList object:nil];
}

- (void)setVehicleImageList
{
    for (VehicleListResponse* vehicle in _vehicleList) {
        if (vehicle.imageList.count <= 0)
            continue;
        
        // Create appropriate image list for each vehicle element in vehicleList
        NSArray *base64List = vehicle.imageList;
        if([base64List[0] isKindOfClass:[UIImage class]]){
            for (int i=0; i < [base64List count]; ++i)
                [_vehicleImageList addObject:base64List[i]];
        }
        else{
            for (int i=0; i < [base64List count]; ++i) {
                
                NSString *imageStr = (NSString*)base64List[i];
                NSData *data = [Base64 decode:imageStr];
                UIImage *image = [UIImage imageWithData:data];
                
                [_vehicleImageList addObject:image];
            }
        }
        
        vehicle.imageList = [NSMutableArray arrayWithArray:_vehicleImageList];
        [_vehicleImageList removeAllObjects];
    }

}

- (void)createTableView
{
    _informHistoryTableView = [[CGInformHistoryTableView alloc] initWithFrame:CGRectMake(0, 33, 320,  416 - 33)];
    _informHistoryTableView.delegate = self;
    _informHistoryTableView.dataSource = self;
    [self.view addSubview:_informHistoryTableView];
}

- (void)rotateImage
{
    _loadingImage.transform = CGAffineTransformMakeRotation(_count * M_PI/6);
    _count++;
}

#pragma mark UITableViewDataSource
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int additionalCell = 0;
    if (![self isLastPageReached]) {
        additionalCell++;
    }
    // Rows number in section
    return (_vehicleList.count + additionalCell);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isMoreCell:indexPath]) {
        return _moreCell;
    }
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    VehicleListResponse *vehicle = (VehicleListResponse*)[_vehicleList objectAtIndex:[indexPath row]];
    
    CGInformHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {

        cell = [[CGInformHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier vehicleListResponse:vehicle];

    }
    
    [cell setCellWith:vehicle];
    
    if ([vehicle.imageList count] > 0) {
        
        UIImage *image = vehicle.imageList[0];
        /*
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 70, 70);
        */
        cell.pic.image = image;
        
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Number of section in table
    return 1.0f;
}

- (BOOL)isMoreCell:(NSIndexPath *)indexPath
{
    if (indexPath.row == (_vehicleList.count)) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isLastPageReached
{
    if ([DataService shared].isLastPageReached) {
        return YES;
    }
    
    return NO;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isMoreCell:indexPath]) {
        // Height for More row
        return 45.0f;
    }
    // Height for row
    return 92.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // Height for header
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isMoreCell:indexPath]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setSelected:NO animated:YES];
        [self moreCellTouched];
        
        return;
    }
    
    // selected row by index path
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VehicleListResponse *vehicle = (VehicleListResponse*)[_vehicleList objectAtIndex:[indexPath row]];
    
    UIViewController *vc = [[CGInformViewController alloc] initWithVehicle:vehicle];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark MoreCellTouched
- (void)moreCellTouched
{
    [_moreCell startAnimation];
    [self updateData];
}
    
- (void)updateData
{
    [[DataService shared] updateVehicleListWithSuccess:^(NSMutableArray *vehicleList) {
        
        _vehicleList = [[DataService shared] getVehicleList];
        
        [self sortListWithDate];
        [self setVehicleImageList];
        [_moreCell stopAnimation];
        [_informHistoryTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)sortListWithDate
{
    for (int i = 0; i < _vehicleList.count; ++i) {
        
        VehicleListResponse *vehicle = _vehicleList[i];
        NSDate *vehicleRecordDate = [CGUtilHelper dateFormatFromJSONString:vehicle.createdDate];
        
        for (int j = i + 1; j < _vehicleList.count; ++j) {
            
            VehicleListResponse *nextVehicle = _vehicleList[j];
            NSDate *nextVehicleRecordDate = [CGUtilHelper dateFormatFromJSONString:nextVehicle.createdDate];
            
            if ([vehicleRecordDate compare:nextVehicleRecordDate] == NSOrderedAscending) {
                
                if(![_vehicleList respondsToSelector:@selector(exchangeObjectAtIndex:withObjectAtIndex:)])
                {
                    NSLog(@"Not responding to exchange method");
                    return;
                }else{
                    [_vehicleList exchangeObjectAtIndex:i withObjectAtIndex:j];
                    vehicle = _vehicleList[i];
                }
                
                
            }
        }
        
    }
}

@end

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

// Dummy Data - Resources for table list pic
#define kCarList [[NSArray alloc] initWithObjects:@"Element1.png", @"Element2.png", @"Element3.png", nil]

@implementation CGInformHistoryViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
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
    
    _vehicleList = [[DataService shared] getVehicleList];
    
    if (![self isLastPageReached]) {
        _moreCell = [[CGMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreCellIdentifier"];
        _moreCell.textLabel.text = @"See More...";
    }
    
    /*
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
     */
}

- (void)refreshTable
{
    // Will be implemented after this class is subclassed from UITableViewController
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setRightButtonHidden:YES];
    [self startSpinner];
    
    if (_vehicleList.count <= 0) {
        // New Get List Method
        [[DataService shared] getVehicleListWithSuccess:^(NSArray *vehicleList) {
            
            _vehicleImageList = [NSMutableArray array];
            _vehicleList = [NSArray arrayWithArray:vehicleList];
            
            [self setVehicleImageList];
            [self stopSpinner];
            [self createTableView];
            
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }else
    {
        // Data is already in DataService
        [self stopSpinner];
        [self createTableView];
    }
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
    cell = [[CGInformHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier vehicleListResponse:vehicle];

    if ([vehicle.imageList count] > 0) {
       
        UIImage *image = vehicle.imageList[0];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 70, 70);
        
        [cell.pic addSubview:imageView];
    }
    else
        NSLog(@"[CGInformHistoryViewController] tableView: There is no photo for row %d", [indexPath row]+1);

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
    [self performSelector:@selector(updateData) withObject:nil afterDelay:1.5f];
}
    
- (void)updateData
{
    [[DataService shared] updateVehicleListWithSuccess:^(NSArray *vehicleList) {
        
        _vehicleList = [[DataService shared] getVehicleList];
        
        [self setVehicleImageList];
        [_moreCell stopAnimation];
        [_informHistoryTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
     
@end

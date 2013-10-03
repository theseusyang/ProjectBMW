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
    
    //Get vehice list
    [[Server shared] getVehicleListWithHash:[[DataService shared] getHash] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        _vehicleList = [mappingResult array];
        
        [self stopSpinner];
        [self createTableView];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //
    }];
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
    // Rows number in section
    return [_vehicleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    VehicleListResponse *vehicle = (VehicleListResponse*)[_vehicleList objectAtIndex:[indexPath row]];
    
    CGInformHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[CGInformHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier vehicleListResponse:vehicle];

    if ([vehicle.imageList count] > 0) {
        NSString *str = [NSString stringWithString:vehicle.imageList[0]];
        
        NSData *imageDecoded = [Base64 decode:str];
        UIImage *image = [UIImage imageWithData:imageDecoded];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.image = image;
        
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
    // selected row by index path
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VehicleListResponse *vehicle = (VehicleListResponse*)[_vehicleList objectAtIndex:[indexPath row]];
    
    UIViewController *vc = [[CGInformViewController alloc] initWithVehicle:vehicle];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

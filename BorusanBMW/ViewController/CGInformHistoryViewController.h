//
//  CGInformHistoryViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGInformHistoryTableView.h"
#import "CGInformHistoryCell.h"
#import "CGInformViewController.h"
#import "CGMenuViewController.h"
#import "VehicleListResponse.h"

#import "Server.h"
#import "Base64.h"

@interface CGInformHistoryViewController : CGBaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    CGInformHistoryTableView *_informHistoryTableView;
    NSArray *_vehicleList;
    UIRefreshControl *_refreshControl;
}

@end

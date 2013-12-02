//
//  CGInformHistoryCell.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGUtilHelper.h"
#import "CGLabel.h"
#import "VehicleListResponse.h"

@interface CGInformHistoryCell : UITableViewCell
{
    UIView *_groupView;
    
    UIImageView *_picBg;
    UIImageView *_checkIcon;
    UIImageView *_locationIcon;
    
    UITextView *_dateView;
    UITextView *_addressView;
    UITextView *_cityView;
    
    VehicleListResponse *_vehicleData;
}

@property (nonatomic, strong) UIImageView *pic;

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSNumber       *notificationType;
@property (nonatomic, strong) NSString *licensePlate;
@property (nonatomic, strong) NSString *serviceType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
vehicleListResponse:(VehicleListResponse*)vehicleListResponse;

- (void)setCellWith:(VehicleListResponse*)vehicleListResponse;
@end

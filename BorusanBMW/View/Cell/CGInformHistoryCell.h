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
    UIImageView *_pic;
    UIImageView *_checkIcon;
    UIImageView *_locationIcon;
    
    UITextView *_dateView;
    UITextView *_addressView;
}

@property (nonatomic, strong) UIImageView *pic;

@property (nonatomic, copy) NSString *createdDate;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *location;
@property (nonatomic) NSNumber       *notificationType;
@property (nonatomic, copy) NSString *licensePlate;
@property (nonatomic, copy) NSString *serviceType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
vehicleListResponse:(VehicleListResponse*)vehicleListResponse;

@end

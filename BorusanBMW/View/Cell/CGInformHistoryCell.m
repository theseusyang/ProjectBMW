//
//  CGInformHistoryCell.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/9/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGInformHistoryCell.h"

@implementation CGInformHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    vehicleListResponse:(VehicleListResponse*)vehicleListResponse
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _vehicleData = vehicleListResponse;
        //[self setCellWith:vehicleListResponse];
        
        // Create Date Format
        self.backgroundColor = [UIColor clearColor];
        
        // Init attributes
        _groupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 92)];
        [self addSubview:_groupView];
        
        _picBg = [[UIImageView alloc] initWithImage:kApplicationImage(kResThumbnailContainer)];
        [_groupView addSubview:_picBg];
        
        self.pic = [[UIImageView alloc] initWithFrame:CGRectMake(23, 11, 70, 70)];
        [_groupView addSubview:self.pic];
        
        _checkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 4, 30, 30)];
        _checkIcon.image = [UIImage imageNamed:@"BadgePending"];
        [_groupView addSubview:_checkIcon];
        
        _locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(111, 50, 24, 18)];
        _locationIcon.image = [UIImage imageNamed:@"IconLocationDark"];
        [_groupView addSubview:_locationIcon];
        
        _dateView = [[UITextView alloc] initWithFrame:CGRectMake(100, 15, 190, 25)];
        _dateView.font = kApplicationFontBold(15.0f);
        [_dateView setUserInteractionEnabled:NO];
        [_groupView addSubview:_dateView];
        
        _addressView = [[UITextView alloc] initWithFrame:CGRectMake(135,40,155,20)]; //height was 40
        _addressView.backgroundColor = [UIColor clearColor];
        _addressView.font = kApplicationFont(12.5f);
        [_addressView setUserInteractionEnabled:NO];
        [_groupView addSubview:_addressView];
        
        _cityView = [[UITextView alloc] initWithFrame:CGRectMake(135, 53, 155, 20)];
        _cityView.backgroundColor = [UIColor clearColor];
        _cityView.font =kApplicationFontBold(12.5f);
        [_cityView setUserInteractionEnabled:NO];
        [_groupView addSubview:_cityView];
        
        
        
        
        self.accessoryView = [[UIImageView alloc] initWithImage:kApplicationImage(kResIconArrowDark)];
    }
    
    return self;
}

- (void)setCellWith:(VehicleListResponse*)vehicleListResponse
{
    // Just reset datas, do not recreate them.
    _picBg.frame = CGRectMake(18, 6, 80, 80);
    _dateView.text = [CGUtilHelper dateFromJSONStringWith:_vehicleData.createdDate];
    
    NSArray *location = [_vehicleData.location componentsSeparatedByString:@", "];
    
    switch (location.count) {
        case 2:
            _addressView.text = [location objectAtIndex:0];
            _cityView.text = [location objectAtIndex:1];
            break;
        case 1:
            _addressView.text = [location objectAtIndex:0];
            break;
        case 0:
            break;
        default:
            _addressView.text = [location objectAtIndex:0];
            break;
    }
    

    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

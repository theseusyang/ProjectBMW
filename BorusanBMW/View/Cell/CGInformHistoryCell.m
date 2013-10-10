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

        // Create Date Format
        
        
        self.backgroundColor = [UIColor clearColor];
        
        _groupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 92)];
        [self addSubview:_groupView];
        
        _picBg = [[UIImageView alloc] initWithImage:kApplicationImage(kResThumbnailContainer)];
        _picBg.frame = CGRectMake(18, 6, 80, 80);
        [_groupView addSubview:_picBg];
        
        self.pic = [[UIImageView alloc] initWithFrame:CGRectMake(23, 11, 70, 70)];
        [_groupView addSubview:self.pic];
        
        _checkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 4, 30, 30)];
        _checkIcon.image = [UIImage imageNamed:@"BadgePending"];
        [_groupView addSubview:_checkIcon];
        
        _locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(111, 50, 24, 18)];
        _locationIcon.image = [UIImage imageNamed:@"IconLocationDark"];
        [_groupView addSubview:_locationIcon];
        
        // Dynamic data
        /*
        _dateLabel = [[CGLabel alloc] initWithFrame:CGRectMake(111, 21, 0, 0)];
        _dateLabel.font = kApplicationFontBold(15.0f);
        _dateLabel.text = [CGUtilHelper dateFromJSONStringWith:vehicleListResponse.createdDate];
        _dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _dateLabel.numberOfLines = 2;
        [_dateLabel sizeToFit];
        [_groupView addSubview:_dateLabel];
        */
        
        _dateView = [[UITextView alloc] initWithFrame:CGRectMake(100, 15, 190, 25)];
        _dateView.font = kApplicationFontBold(15.0f);
        //_dateView.backgroundColor = kColorRed;
        _dateView.text = [CGUtilHelper dateFromJSONStringWith:vehicleListResponse.createdDate];
        [_dateView setUserInteractionEnabled:NO];
        [_groupView addSubview:_dateView];
        
        
        _addressView = [[UITextView alloc] initWithFrame:CGRectMake(135,40,155,40)];
        _addressView.backgroundColor = [UIColor clearColor];
        _addressView.font = kApplicationFont(9.0f);
        _addressView.text = vehicleListResponse.location;
        [_addressView setUserInteractionEnabled:NO];
        [_groupView addSubview:_addressView];
        
        
        /*
        _addressLabel = [[CGLabel alloc] initWithFrame:CGRectMake(142, 46, 0, 0)];
        _addressLabel.font = kApplicationFont(13.0f);
        _addressLabel.text = vehicleListResponse.location;
        _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _addressLabel.numberOfLines = 2;
        [_addressLabel sizeToFit];
        [_groupView addSubview:_addressLabel];
        */
        
        self.accessoryView = [[UIImageView alloc] initWithImage:kApplicationImage(kResIconArrowDark)];
    }
    
    return self;
}

- (void)layoutSubviews
{
    //
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

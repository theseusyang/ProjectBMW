//
//  LocationManager.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/24/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *_manager;
    CLLocation *_currentLocation;
    CLGeocoder *_geocoder;
    CLPlacemark *_placemark;
}

@property (nonatomic, copy) NSString* location;

+ (LocationManager*)shared;

@end

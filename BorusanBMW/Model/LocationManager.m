//
//  LocationManager.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/24/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (LocationManager*)shared
{
    static LocationManager* instance = nil;
    if (!instance) {
        instance = [[LocationManager alloc] init];
    }
    
    return instance;
}

- (id)init{
    
    self = [super init];
    if (self) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyKilometer;
        _manager.distanceFilter = 500; // meters

        _geocoder = [[CLGeocoder alloc] init];
        
        [_manager startUpdatingLocation];
    }
    
    return self;
}

- (CLLocation*)currentLocation
{
    return _currentLocation;
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currentLocation = [locations lastObject];
    
    [_geocoder reverseGeocodeLocation:_currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        _placemark = [placemarks lastObject];
        
        NSString *strAdd = nil;
        
        if ([_placemark.subThoroughfare length] != 0) {
            strAdd = _placemark.subThoroughfare;
        }
        
        if ([_placemark.thoroughfare length] != 0) {
            if ([strAdd length] != 0) {
                strAdd = [NSString stringWithFormat:@"%@, %@", strAdd, [_placemark thoroughfare]];
            }
            else
            {
                strAdd = _placemark.thoroughfare;
            }
        }
        
        /*
        if ([_placemark.postalCode length] != 0) {
            if ([strAdd length] != 0) {
                strAdd = [NSString stringWithFormat:@"%@, %@", strAdd, [_placemark postalCode]];
            }
            else
            {
                strAdd = _placemark.postalCode;
            }
        }
        */
        
        if ([_placemark.locality length] != 0) {
            if ([strAdd length] != 0) {
                strAdd = [NSString stringWithFormat:@"%@, %@", strAdd, [_placemark locality]];
            }
            else
                strAdd = _placemark.locality;
        }
        
        if ([_placemark.administrativeArea length] != 0)
        {
            if ([strAdd length] != 0)
                strAdd = [NSString stringWithFormat:@"%@, %@",strAdd, [_placemark administrativeArea]];
            else
                strAdd = _placemark.administrativeArea;
        }
        
        if ([_placemark.country length] != 0)
        {
            if ([strAdd length] != 0)
                strAdd = [NSString stringWithFormat:@"%@, %@",strAdd, [_placemark country]];
            else
                strAdd = _placemark.country;
        }
        
        self.location = [NSString stringWithString:strAdd];
        
        [_manager stopUpdatingLocation];
    }];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location Manager has been zortladi! - error:%@", error);
    [_manager stopUpdatingLocation];
}

@end

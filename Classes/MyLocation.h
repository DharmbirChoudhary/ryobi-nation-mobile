//
//  MyLocation.h
//  iFixit
//
//  Created by iFixit Rocks on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
    NSString *_city;
    NSString *_phone;
    NSString *_hours;
}


@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy) NSString *city;
@property (copy) NSString *phone;
@property (copy) NSString *hours;

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate city:(NSString *)city phone:(NSString *)phone hours:(NSString *)hours;

- (NSString*)myCity;

@end

//
//  MyLocation.m
//  AEDLocaterTest
//
//  Created by iFixit Rocks on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize city = _city;
@synthesize phone = _phone;
@synthesize hours = _hours;

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate city:(NSString *)city phone:(NSString *)phone hours:(NSString *)hours{
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        _city = [city copy];
        _phone = [phone copy];
        _hours = [hours copy];
        
    }
    
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown oh snap";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (NSString *)myCity {
    return _city;
}

- (NSString *)myPhone {
    return _phone;
}

- (NSString *)myHours {
    return _hours;
}


@end

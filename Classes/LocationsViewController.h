//
//  LocationsViewController.h
//  iFixit
//
//  Created by iFixit Rocks on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344


@interface LocationsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *_mapView;
@property (retain, nonatomic) NSArray *locationsArray;

@property BOOL updateInitialLoad;

@end

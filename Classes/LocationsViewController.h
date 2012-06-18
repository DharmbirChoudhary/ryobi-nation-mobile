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
@class LocationsViewControllerInfo;

#define METERS_PER_MILE 1609.344


@interface LocationsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *_mapView;
@property (retain, nonatomic) NSArray *locationsArray;
@property (retain, nonatomic) LocationsViewControllerInfo *locationsViewControllerInfo;
@property (retain, nonatomic) NSMutableArray *aedLocationsSelected;

@property BOOL updateInitialLoad;

-(void)plotLocations;

@end

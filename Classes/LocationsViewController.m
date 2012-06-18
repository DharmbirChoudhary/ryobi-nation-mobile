//
//  LocationsViewController.m
//  iFixit
//
//  Created by iFixit Rocks on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationsViewController.h"
#import "MyLocation.h"
#import "LocationsViewControllerInfo.h"

@implementation LocationsViewController
@synthesize _mapView, updateInitialLoad, locationsArray;
@synthesize locationsViewControllerInfo = _locationsViewControllerInfo, aedLocationsSelected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    updateInitialLoad = TRUE;
    aedLocationsSelected = [[NSMutableArray alloc] init];
    self.title = @"Retail Locations";
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.767662;
    zoomLocation.longitude = -122.416127;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 8*METERS_PER_MILE, 8*METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    [_mapView setRegion:adjustedRegion animated:YES];
    [self plotLocations];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"Icon_Home_Depot_60x60.jpg"];
      //  annotationView.animatesDrop = TRUE;
        
        return annotationView;
    }
    
    return nil;    
}

- (void)plotLocations{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"HDLocations" ofType:@"plist"];
    
    NSArray *myArray = [[NSArray alloc]
                        initWithContentsOfFile:plistPath];
    
    NSDictionary *myDictionary;

    
    self.locationsArray = myArray;
    
    for (id<MKAnnotation> annotation in _mapView.annotations)
        [_mapView removeAnnotation:annotation];
    
    for (int i = 0; i < [self.locationsArray count]; i++)
    {
        myDictionary = [self.locationsArray objectAtIndex:i];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[myDictionary valueForKey:@"lat"] doubleValue];
        coordinate.longitude =  [[myDictionary valueForKey:@"lng"] doubleValue];
        
        MyLocation *annotation = [[MyLocation alloc] 
                                  initWithName:[myDictionary objectForKey:@"name"] 
                                  address:[myDictionary objectForKey:@"address"]
                                  coordinate:coordinate
                                  city:[myDictionary objectForKey:@"city"]
                                  phone:[myDictionary objectForKey:@"phone"]
                                  hours:[myDictionary objectForKey:@"hours"]];
        

        [_mapView addAnnotation:annotation];
            }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    MyLocation *myAnnotation = [view annotation];
    NSMutableDictionary *aedLocationsPList = [[NSMutableDictionary alloc] init];
    NSMutableArray *sectionHeaders = [[NSMutableArray alloc] init];
    NSMutableArray *currentCity = [[NSMutableArray alloc] init];
    CLLocation *currentLocation = self._mapView.userLocation.location;
    CLLocation *destination = [[CLLocation alloc] initWithLatitude:[myAnnotation coordinate].latitude longitude:[myAnnotation coordinate].longitude];
   // CLLocationDistance distance = [destination distanceFromLocation:currentLocation];
    
    [aedLocationsPList setObject:[myAnnotation hours] forKey:@"hours"];
    [aedLocationsPList setObject:[myAnnotation phone] forKey:@"phone"];
    [aedLocationsPList setObject:[myAnnotation address] forKey:@"address"];
        
  /*  float convertMe = [[NSString stringWithFormat:@"%f", distance] floatValue];
    
      if(convertMe < 1609.344) {
        [aedLocationsPList setObject:[NSString stringWithFormat:@"%.2f feet", (convertMe * 3.2808399)] forKey:@"distance"];
    } else {
        [aedLocationsPList setObject:[NSString stringWithFormat:@"%.2f miles", (convertMe / 1609.344)] forKey:@"distance"];
    }*/
    
    if (_locationsViewControllerInfo == nil) {
        _locationsViewControllerInfo = [[LocationsViewControllerInfo alloc]
                                       initWithNibName: @"LocationsViewControllerInfo" bundle: nil];
    }
        
    
    [aedLocationsSelected insertObject:aedLocationsPList atIndex:0];
    [sectionHeaders insertObject:[myAnnotation name] atIndex:0];
    [currentCity insertObject:[myAnnotation city] atIndex:0];
    
    _locationsViewControllerInfo.aedLocationsSelected = aedLocationsSelected;
    _locationsViewControllerInfo.sectionHeaders = sectionHeaders;
    _locationsViewControllerInfo.currentCity = currentCity;    
    [self.navigationController pushViewController:_locationsViewControllerInfo animated:YES];
    
    
}
- (void)viewDidUnload
{
    [self set_mapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [self set_mapView:nil];
}
@end

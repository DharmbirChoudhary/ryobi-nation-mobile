//
//  LocationsViewController.m
//  iFixit
//
//  Created by iFixit Rocks on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationsViewController.h"
#import "MyLocation.h"

@implementation LocationsViewController
@synthesize _mapView, updateInitialLoad, locationsArray;

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
    self.title = @"Retail Locations";
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.767662;
    zoomLocation.longitude = -122.416127;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    [_mapView setRegion:adjustedRegion animated:YES];
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
        annotationView.animatesDrop = TRUE;
        
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
        
        // Fix dis
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

- (void)viewDidUnload
{
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
    [self plotLocations];
    [super viewWillAppear:TRUE];
}
@end

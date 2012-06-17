//
//  LocationsViewControllerInfo.m
//  iFixit
//
//  Created by iFixit Rocks on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationsViewControllerInfo.h"

@implementation LocationsViewControllerInfo
@synthesize getDirectionsButton, aedLocationsSelected, gmapAddress, footerView, sectionHeaders, currentCity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [aedLocationsSelected count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[aedLocationsSelected objectAtIndex:section] allKeys].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionHeaders objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    
    
    NSDictionary *annotationInfo = [aedLocationsSelected objectAtIndex:(indexPath.section)];
    NSArray *myKeys = [annotationInfo allKeys];
    
    cell.textLabel.text = [myKeys objectAtIndex:row];
    cell.detailTextLabel.text = [annotationInfo objectForKey:[myKeys objectAtIndex:row]];    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [self.tableView reloadData];

    //if ([aedLocationsSelected count] == 1)
    // [self addWebView];
}

- (void)viewDidDisappear:(BOOL)animated {
    if(!aedLocationsSelected)
        [aedLocationsSelected removeAllObjects];
    [sectionHeaders removeAllObjects];
    [currentCity removeAllObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected %i", indexPath.row);
    
    if (indexPath.row == 0)
    {
        NSDictionary *annotationInfo = [aedLocationsSelected objectAtIndex:(indexPath.section)];
        NSArray *myKeys = [annotationInfo allKeys];
        
        NSString *phoneNumber = [annotationInfo objectForKey:[myKeys objectAtIndex:indexPath.row]]; // dynamically assigned
        
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        
        
        NSString *phoneURLString = [NSString stringWithFormat:@"telprompt://1-%@", phoneNumber];
        NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    else if (indexPath.row == 2)
    {
        NSString *sourceAddress = @"Current Location"; 
        NSString *destinationAddress = [NSString stringWithFormat:@"%@+%@+%@",
                                        [[aedLocationsSelected objectAtIndex:indexPath.section] objectForKey:@"address"],
                                        [currentCity objectAtIndex:indexPath.section],
                                        @"US"];
        
        
        
        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@&daddr=%@&dirflg=w",
                         
                         [sourceAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         [destinationAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end

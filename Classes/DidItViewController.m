//
//  DidItViewController.m
//  iFixit
//
//  Created by Adam Hintz on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DidItViewController.h"
#import "ShareStoryViewController.h"
#import "GuideCatchingWebView.h"

@implementation DidItViewController

@synthesize guide=_guide;
@synthesize shareButton;


- (IBAction)gotoSharer:(UIButton*)sender {
    NSURL* url = [NSURL URLWithString:@"http://ryobi.cdcline.cominor.com/Story/1/My_Sweet_Garden_Bench"];
    
    [[UIApplication sharedApplication] openURL:url];

}

- (id)initWithGuide:(Guide *)guide andNavigationController:(UINavigationController*)nc {
    if ((self = [super initWithNibName:@"DidItView" bundle:nil])) {
        self.guide = guide;
    }
    
    return self;
}


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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

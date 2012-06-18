//
//  DidItViewController.h
//  iFixit
//
//  Created by Adam Hintz on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guide.h"

@class GuideCatchingWebView;

@interface DidItViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton* shareButton;
@property (nonatomic, retain) Guide* guide;

- (IBAction)gotoSharer:(UIButton*)sender;

- (id)initWithGuide:(Guide*) guide andNavigationController:(UINavigationController*)nc;

@end

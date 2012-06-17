//
//  DidItViewController.h
//  iFixit
//
//  Created by Adam Hintz on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guide.h"

@interface DidItViewController : UIViewController

@property (nonatomic, retain) Guide* guide;

- (id)initWithGuide:(Guide*) guide;

@end

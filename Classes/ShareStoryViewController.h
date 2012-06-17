//
//  ShareStoryViewController.h
//  iFixit
//
//  Created by Adam Hintz on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingControl.h"
#import "Guide.h"

@interface ShareStoryViewController : UIViewController <StarRatingDelegate>

@property (nonatomic, retain) Guide* guide;

-(id) initWithGuide:(Guide*) guide;

@end

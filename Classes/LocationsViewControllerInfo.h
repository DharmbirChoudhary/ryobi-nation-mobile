//
//  LocationsViewControllerInfo.h
//  iFixit
//
//  Created by iFixit Rocks on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationsViewControllerInfo : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UIView *footerView;
@property (retain, nonatomic) UIButton *getDirectionsButton;
@property (retain, nonatomic) NSMutableArray *aedLocationsSelected;
@property (retain, nonatomic) NSString *gmapAddress;
@property (retain, nonatomic) NSMutableArray *sectionHeaders;
@property (retain, nonatomic) NSMutableArray *currentCity;



@end

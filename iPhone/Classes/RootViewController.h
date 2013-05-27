//
//  RootViewController.h
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NearbyAppDelegate, DetailViewController, AppData;

@interface RootViewController : UITableViewController {
	
	NearbyAppDelegate *appDelegate;
	DetailViewController *detailViewController;
	AppData	*appData;
}

@end

//
//  DetailViewController.h
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WebViewController.h"

@class Article, AppData, Annotation;

@interface DetailViewController : UIViewController <MKMapViewDelegate> {

	IBOutlet UITableView	*tableView;
	IBOutlet MKMapView		*mapView;
	
	AppData	*appData;
	Article	*anArticle;
	Annotation	*currentAnnotation;
	
	WebViewController *webViewController;
}

@property (nonatomic, retain) AppData	*appData;
@property (nonatomic, retain) Article	*anArticle;
@property (nonatomic, retain) Annotation	*currentAnnotation;
@property (nonatomic, retain) WebViewController *webViewController;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

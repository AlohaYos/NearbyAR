//
//  NearbyAppDelegate.m
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import "NearbyAppDelegate.h"
#import "RootViewController.h"
#import "XMLParser.h"
#import "AppData.h"
#import "Article.h"

@implementation NearbyAppDelegate

@synthesize window;
@synthesize navigationController, locationManager, appData, isLocationChanged;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // アプリケーションで扱うデータを管理するオブジェクトを生成
	appData = [[AppData alloc] init];

	// CLLocationManagerのインスタンスを作成
	isLocationChanged = NO;
	locationManager = [[CLLocationManager alloc] init];
	if ([CLLocationManager locationServicesEnabled]) {
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
		locationManager.distanceFilter = 1000.0;
		[locationManager startUpdatingLocation];
		[locationManager startUpdatingHeading];
	} else {
		NSLog(@"ロケーションサービスが利用できない");
	}

	// AR追加部分
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 20.0)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];

	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[appData release];
	[navigationController release];
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark Sort Function

NSComparisonResult DistanceSortClosestFirst(Article *a1, Article *a2, void *ignore) {
    long d1 = [a1.distance longLongValue];
	long d2 = [a2.distance longLongValue];

    if (d1 < d2) {
		return NSOrderedAscending;
	} else if (d1 > d2) {
		return NSOrderedDescending;
	} else {
		return NSOrderedSame;
	}
}

#pragma mark -
#pragma mark Information handling

- (void)getAndParseInfomation {

	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

	int	nearbyDistance = 10000;
	NSURL *url = [[NSURL alloc] initWithString:
				  [NSString stringWithFormat: 
				   @"http://newtonjapan.com/book/demo/NEARBY/get_nearby_xml.php?lat=%f&lon=%f&nearby=%d&count=50",
				   appData.coordinate.latitude,
				   appData.coordinate.longitude,
				   nearbyDistance]
				  ];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	XMLParser *parser = [[XMLParser alloc] init];
	[xmlParser setDelegate:(id)parser];
	if([xmlParser parse]) {
		[appData.articles sortUsingFunction:DistanceSortClosestFirst context:NULL];
		[[[[navigationController viewControllers] objectAtIndex:0] tableView] reloadData];
	}
	else {
		NSLog(@"パースに失敗");
	}

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark CoreLocation delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {


	// 緯度経度取得に成功した場合
	appData.coordinate = newLocation.coordinate;
/* */
	CLLocationCoordinate2D tmpCood;
	tmpCood.latitude = 35.658587;
	tmpCood.longitude = 139.745425;
	appData.coordinate = tmpCood;
/* */
	appData.course = newLocation.course;
	appData.speed = newLocation.speed;

	if(isLocationChanged == NO) {
		[self getAndParseInfomation];
		isLocationChanged = YES;
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	// 緯度経度取得に失敗した場合
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	appData.heading = newHeading.trueHeading;	// 北が0.0、東が90.0（倍精度浮動小数点）
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
	return YES;
}

// AR追加部分
#pragma mark -
#pragma mark Accelerometer delegate methods

UIAccelerationValue rollingX, rollingY, rollingZ;

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	rollingX = (acceleration.x * kFilteringFactor) + (rollingX * (1.0 - kFilteringFactor));
    rollingY = (acceleration.y * kFilteringFactor) + (rollingY * (1.0 - kFilteringFactor));
    rollingZ = (acceleration.z * kFilteringFactor) + (rollingZ * (1.0 - kFilteringFactor));

	double accY = -atan(rollingY /2);
	if(accY < ACCY_AT_HOLIZONTAL) accY = ACCY_AT_HOLIZONTAL;
	if(accY > ACCY_AT_HANDLING) accY = ACCY_AT_HANDLING;
	
	double k_y = Y_DISP_UPPER / (ACCY_AT_HANDLING-ACCY_AT_HOLIZONTAL);
	double deltaY  = (accY - ACCY_AT_HOLIZONTAL) * k_y;
	
	if(deltaY > Y_DISP_UPPER) deltaY = Y_DISP_UPPER;
	appData.mapBorderY = deltaY;
}


@end


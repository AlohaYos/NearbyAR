//
//  NearbyAppDelegate.h
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@class AppData;

// AR追加部分：UIAccelerometerDelegateに準拠
@interface NearbyAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate, UIAccelerometerDelegate> {
    
    UIWindow				*window;
    UINavigationController	*navigationController;
	CLLocationManager		*locationManager;
	AppData					*appData;
	BOOL					isLocationChanged;
}

@property (nonatomic, retain)	IBOutlet UIWindow *window;
@property (nonatomic, retain)	IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain)	AppData	*appData;
@property (nonatomic, retain)	CLLocationManager	*locationManager;
@property (nonatomic)			BOOL	isLocationChanged;

@end


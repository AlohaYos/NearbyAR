//
//  AppData.h
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class	CustomImagePicker;	// AR追加部分

@interface AppData : NSObject {

	CLLocationCoordinate2D	coordinate;	// 現在の緯度経度
	CLLocationDirection		heading;	// 　　　方角
	CLLocationDirection		course;		// 　　　進行方向
	CLLocationSpeed			speed;		// 　　　進行速度
	NSMutableArray			*articles;

	// AR追加部分
	CustomImagePicker		*picker;
	int						mapBorderY;		// マップの下端のY座標
}

@property (nonatomic)			CLLocationCoordinate2D	coordinate;
@property (nonatomic)			CLLocationDirection		heading;
@property (nonatomic)			CLLocationDirection		course;
@property (nonatomic)			CLLocationSpeed			speed;
@property (nonatomic, retain)	NSMutableArray			*articles;

// AR追加部分
@property (nonatomic, retain)	CustomImagePicker		*picker;
@property (nonatomic)			int						mapBorderY;

@end

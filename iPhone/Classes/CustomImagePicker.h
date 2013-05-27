//
//  CustomImagePicker.h
//  Nearby
//
//  Created by Yos Hashimoto
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppData.h"
#import "Article.h"
#import "InfoTagView.h"

@interface CustomImagePicker : UIImagePickerController {
	AppData		*appData;
	NSTimer		*arTimer;
	BOOL		timerInAction;

	// iOS 5.0 での変更
	id			delegate;
}

@property (nonatomic, retain)	AppData		*appData;
@property (nonatomic, retain)	NSTimer		*arTimer;
@property (nonatomic)			BOOL		timerInAction;
@property (nonatomic, weak)		id			delegate;

- (CGPoint)pointInViewForArtile:(Article *)article;

@end

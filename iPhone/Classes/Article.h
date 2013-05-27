//
//  Article.h
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoTagView.h"

@interface Article: NSObject {
	
	NSString *articleID;
	NSString *title;
	NSString *lat;
	NSString *lon;
	NSString *distance;
	
	NSMutableDictionary* propertyDic;

	InfoTagView*	infotag;	// AR追加部分
}

@property (nonatomic, retain) NSString *articleID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;
@property (nonatomic, retain) NSString *distance;
@property (nonatomic, retain) NSMutableDictionary *propertyDic;
@property (nonatomic, retain) InfoTagView	*infotag;	// AR追加部分

-(NSMutableDictionary *) makePropertyDictionary;
-(NSString*) getPropertyNameFor:(NSString*)elementName;

@end

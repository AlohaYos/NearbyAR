//
//  XMLParser.h
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NearbyAppDelegate, Article;

@interface XMLParser : NSObject {

	NSMutableString *currentElement;
	
	NearbyAppDelegate *appDelegate;
	Article *anArticle; 
}

- (XMLParser *) init;

@end

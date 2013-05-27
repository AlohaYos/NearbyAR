//
//  Article.m
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import <objc/objc.h>
#import <objc/runtime.h>
#import "Article.h"

#define kPrefix	@"im:"

@implementation Article

@synthesize articleID, title, lat, lon, distance, propertyDic;
@synthesize infotag;

#pragma mark -
#pragma mark Object lifecycle

// インスタンスを初期化する
-(id)init {
	propertyDic = [[NSMutableDictionary alloc] initWithDictionary:[self makePropertyDictionary]];
	return self;
}

#pragma mark -
#pragma mark Property handling

// クラスのプロパティ名称の一覧辞書を作成する
-(NSMutableDictionary *)makePropertyDictionary {     
	unsigned int outCount;
	
	objc_property_t *propList = class_copyPropertyList([self class], &outCount);
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithCapacity:outCount];
	
	int i;
	for (i=0; i < outCount; i++) {
		objc_property_t* aProp = propList + i;
		NSString *propName = [[NSString alloc] initWithCString:property_getName(*aProp) encoding:NSUTF8StringEncoding];
		[properties setValue:propName forKey:propName];
		[propName release];
	}

	[properties autorelease];	// オブジェクトの解放に注意！
	return properties;
}

// RSSのエレメントに対応するインスタンスプロパティ名を得る
-(NSString*)getPropertyNameFor:(NSString*)elementName {
	
	NSString* propName = [propertyDic objectForKey:elementName];
	return propName;
}

- (void) dealloc {

	[distance release];
	[lon release];
	[lat release];
	[title release];
	[articleID release];
	[super dealloc];
}

@end

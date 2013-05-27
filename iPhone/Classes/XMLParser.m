//
//  XMLParser.m
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import "XMLParser.h"
#import "NearbyAppDelegate.h"
#import "Article.h"
#import "AppData.h"

@implementation XMLParser

#pragma mark -
#pragma mark Object lifecycle

- (XMLParser *) init {
	[super init];
	appDelegate = (NearbyAppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.appData.articles = [[NSMutableArray alloc] init];
	anArticle = nil;
	
	return self;
}

- (void) dealloc {
	
	[anArticle release];
	[currentElement release];
	[super dealloc];
}


#pragma mark -
#pragma mark Parse delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	// "<article>"タグが出現するまで読み飛ばす
	if([elementName isEqualToString:@"article"]) {
		// Articleインスタンスの初期化
		anArticle = [[Article alloc] init];
		[appDelegate.appData.articles addObject:anArticle];
	}

	NSString* elName;
	// Articleクラスに対応するプロパティがある場合のみ文字列の格納領域を用意する
	if(anArticle) {
		elName = [anArticle getPropertyNameFor:elementName];
		if(elName) {
			currentElement = [[NSMutableString alloc] initWithString:@""];
		}
	}
	
	NSLog(@"タグエレメント: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
	if(currentElement) 
		[currentElement appendString:string];
	
	NSLog(@"値: %@", currentElement);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

	NSString* elName;
	// Musicクラスに対応するプロパティがある場合のみ処理する
	if(currentElement) {
		elName = [anArticle getPropertyNameFor:elementName];
		if(elName) {
			[anArticle setValue:currentElement forKey:elName];
		}
		[currentElement release];
		currentElement = nil;
	}
}

@end

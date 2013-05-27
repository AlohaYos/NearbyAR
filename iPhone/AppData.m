//
//  AppData.m
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import "AppData.h"


@implementation AppData

@synthesize	coordinate, heading, course, speed, articles;

// AR追加部分
@synthesize picker, mapBorderY;


-(AppData*)init {
	picker = nil;	// AR追加部分
	return self;
}


- (void)dealloc {
	[articles release], articles = nil;
	[picker release], picker = nil;	// AR追加部分
    [super dealloc];
}


@end

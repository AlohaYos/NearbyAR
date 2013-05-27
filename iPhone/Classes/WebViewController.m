//
//  WebViewController.m
//  Nearby
//
//  Created by Yos Hashimoto
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

@synthesize anArticle, webView;


- (void)viewDidLoad {
    [super viewDidLoad];

	UIBarButtonItem *safariButton = [[UIBarButtonItem alloc] initWithTitle:@"Safari" style:UIBarButtonItemStylePlain target:self action:@selector(safariButtonPushed)];
	self.navigationItem.rightBarButtonItem = safariButton;
	[safariButton release];
}

-(void)viewWillAppear:(BOOL)animated {
	NSString *targetURL = [NSString stringWithFormat:@"http://newtonjapan.com/book/demo/NEARBY/wp/?p=%@", anArticle.articleID];
	NSURL *theURL = [NSURL URLWithString:[targetURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[webView loadRequest:[NSURLRequest requestWithURL:theURL]];
}

- (void) safariButtonPushed {
	[[UIApplication sharedApplication] openURL:webView.request.URL];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

//
//  WebViewController.h
//  Nearby
//
//  Created by Yos Hashimoto
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface WebViewController : UIViewController {
	Article		*anArticle;
	UIWebView	*webView;
}

@property (nonatomic, retain)			Article		*anArticle;
@property (nonatomic, retain) IBOutlet	UIWebView	*webView;

@end

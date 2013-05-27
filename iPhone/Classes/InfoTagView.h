//
//  InfoTagView.h
//  Nearby
//
//  Created by Yos Hashimoto
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoTagView : UIImageView {
	UIView			*parentView;
	
	NSString		*title;
	NSString		*subtitle;
	UILabel			*titleLabel;
	UILabel			*subtitleLabel;

	CGPoint			centerPoint;
	CGPoint			centerPointBeforeTouch;
	int				brownMoveX;
	int				brownMoveY;
	int				deltaX;
	int				deltaY;
	BOOL			touchInProgress;
}

@property (nonatomic, retain)	UIView		*parentView;
@property (nonatomic, retain)	NSString	*title;
@property (nonatomic, retain)	NSString	*subtitle;
@property (nonatomic)			CGPoint		centerPoint;
@property (nonatomic)			CGPoint		centerPointBeforeTouch;
@property (nonatomic)			int			brownMoveX;
@property (nonatomic)			int			brownMoveY;
@property (nonatomic)			int			deltaX;
@property (nonatomic)			int			deltaY;
@property (nonatomic)			BOOL		touchInProgress;


- (void)setAnchorPoint:(CGPoint)fp8 boundaryRect:(CGRect)fp16 animate:(BOOL)fp32;
- (NSString*)title;
- (void)setTitle:(NSString*)tt;
- (NSString*)subtitle;
- (void)setSubtitle:(NSString*)stt;

@end

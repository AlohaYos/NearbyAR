//
//  InfoTagView.m
//  Nearby
//
//  Created by Yos Hashimoto
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import "InfoTagView.h"


@implementation InfoTagView

@synthesize	parentView, title, subtitle;
@synthesize	centerPoint, centerPointBeforeTouch, brownMoveX, brownMoveY, deltaX, deltaY;
@synthesize touchInProgress;


- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
		[self initWithImage:[UIImage imageNamed:@"infotag.png"]];
		self.alpha = 0.8;

		// インフォタグ内のラベルを生成
		CGRect  bounds, rect;
		bounds = self.bounds;
		titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
		titleLabel.adjustsFontSizeToFitWidth = YES;
		titleLabel.minimumScaleFactor = 10.0f;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		rect.origin.x = 5;
		rect.origin.y = 5;
		rect.size.width = bounds.size.width - 13;
		rect.size.height = 16;
		titleLabel.frame = rect;
		[self addSubview:titleLabel];

		subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		subtitleLabel.font = [UIFont systemFontOfSize:12.0f];
		subtitleLabel.adjustsFontSizeToFitWidth = YES;
		subtitleLabel.minimumScaleFactor = 10.0f;
		subtitleLabel.textColor = [UIColor whiteColor];
		subtitleLabel.backgroundColor = [UIColor clearColor];
		subtitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		subtitleLabel.textAlignment = NSTextAlignmentCenter;
		rect.origin.x = 5;
		rect.origin.y = 25;
		rect.size.width = bounds.size.width - 10;;
		rect.size.height = 16;
		subtitleLabel.frame = rect;
		[self addSubview:subtitleLabel];

		self.userInteractionEnabled = YES;

		// ブラウン運動の準備
		brownMoveX = 0;
		brownMoveY = 0;
		deltaX = 1;
		deltaY = 1;
		centerPoint.x = -1;
		centerPoint.y = -1;
		self.hidden = YES;

		[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timerJob) userInfo:nil repeats:YES];

	}
    return self;
}

- (void)timerJob {

	// タッチされている間はブラウン運動を起こさない
	if(touchInProgress==YES) {
		return;
	}
	
	brownMoveY += deltaY;
	if(brownMoveY > 1) {
		deltaY = -1;
	}
	if(brownMoveY < -1) {
		deltaY = 1;
	}
	
	CGPoint	point = centerPoint;
	point.x += brownMoveX;
	point.y += brownMoveY;
	
	self.center = point;
	self.hidden = NO;
}

- (void)setAnchorPoint:(CGPoint)point boundaryRect:(CGRect)boundrect animate:(BOOL)flag {
	centerPoint = point;
}

- (NSString*)title {
	return titleLabel.text;
}

- (void)setTitle:(NSString*)tt {
	[titleLabel setText:tt];
}

- (NSString*)subtitle {
	return subtitleLabel.text;
}

- (void)setSubtitle:(NSString*)stt {
	[subtitleLabel setText:stt];
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark Touch handling

// タッチ開始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	touchInProgress = YES;
	// インフォタグ（自分）を最前面に持ってくる
	[[self superview] bringSubviewToFront:self];

	UITouch *touch = [touches anyObject];
	centerPointBeforeTouch = centerPoint;
	// タッチされたViewをアニメーションで拡大表示する
	[self animateFirstTouchAtPoint:[touch locationInView:parentView] forView:self];
}

// タッチしたまま移動
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  
	UITouch *touch = [touches anyObject];
	self.center = [touch locationInView:parentView];
}

// 放された
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	// Viewをアニメーションで元の大きさに戻す
	[self animateView:self toPosition:[touch locationInView:parentView]];
	centerPoint = centerPointBeforeTouch;
	touchInProgress = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	centerPoint = centerPointBeforeTouch;
	touchInProgress = NO;
}

#pragma mark -
#pragma mark Touch Animation

- (void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView 
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.5, 1.5);
	theView.transform = transform;
	[UIView commitAnimations];
}

- (void)animateView:(UIImageView *)theView toPosition:(CGPoint) thePosition
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.15];
	theView.center = thePosition;
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}


@end

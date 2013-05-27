//
//  CustomCell.m
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

#pragma mark -
#pragma mark Object lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		nameOfPlace = [[UILabel alloc] initWithFrame:CGRectZero];
		nameOfPlace.font = [UIFont boldSystemFontOfSize:20.0f];
		[self addSubview:nameOfPlace];
		
		distanceToPlace = [[UILabel alloc] initWithFrame:CGRectZero];
		distanceToPlace.font = [UIFont systemFontOfSize:18.0f];
		distanceToPlace.textColor = [UIColor grayColor];
		[self addSubview:distanceToPlace];
    }
    return self;
}

- (void)dealloc {
    [distanceToPlace removeFromSuperview];
    [distanceToPlace release], distanceToPlace = nil;
    [nameOfPlace removeFromSuperview];
    [nameOfPlace release], nameOfPlace = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Property handling

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	// 親クラスのメソッドを呼び出す
    [super setSelected:selected animated:animated];
    
    // ラベルの色を設定する
    if (selected) {
        nameOfPlace.textColor = [UIColor whiteColor];
        distanceToPlace.textColor = [UIColor whiteColor];
    }
    else {
        nameOfPlace.textColor = [UIColor blackColor];
	//	nameOfPlace.backgroundColor = [UIColor clearColor];
        distanceToPlace.textColor = [UIColor grayColor];
	//	distanceToPlace.backgroundColor = [UIColor clearColor];
    }
}

- (NSString*)nameOfPlace
{
    return nameOfPlace.text;
}

- (void)setNameOfPlace:(NSString*)name
{
    nameOfPlace.text = name;
    [self setNeedsLayout];
}

- (int)distanceToPlace
{
    return [distanceToPlace.text intValue];
}

- (void)setDistanceToPlace:(NSString*)distance
{
    distanceToPlace.text = [NSString stringWithFormat:@"%@ m", distance];
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark Cell layout

- (void)layoutSubviews
{
	[super layoutSubviews];
    
    CGRect  bounds, rect;
    bounds = self.bounds;
    
    rect.origin.x = 8.0f;
    rect.origin.y = 10.0f;
    rect.size.width = 200.0f;
    rect.size.height = 20.0f;
    nameOfPlace.frame = rect;
    
    rect.origin.x = 220.0f;
    rect.origin.y = 10.0f;
    rect.size.width = CGRectGetWidth(bounds) - 220.0f;
    rect.size.height = 20.0f;
    distanceToPlace.frame = rect;
}


@end

//
//  CustomCell.h
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright 2009 Newton Japan Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
	UILabel	*nameOfPlace;
	UILabel	*distanceToPlace;
}

- (NSString*)nameOfPlace;
- (void)setNameOfPlace:(NSString*)name;
- (int)distanceToPlace;
- (void)setDistanceToPlace:(NSString*)distance;

@end

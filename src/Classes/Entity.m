//
//  Entity.m
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "Entity.h"


@implementation Entity
@synthesize direction;
@synthesize velocity;

- (NSString*) directionToString {
	NSString *result = [NSString string];
	switch (direction) {
		case DIRECTION_UP:
			result = @"up";
			break;
		case DIRECTION_RIGHT:
			result = @"right";
			break;
		case DIRECTION_DOWN:
			result = @"down";
			break;
		case DIRECTION_LEFT:
			result = @"left";
			break;
		default:
			NSLog(@"Error. Direction not set!");
	}
	return result;
}
@end

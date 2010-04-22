//
//  Entity.m
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "Entity.h"


@implementation Entity
@synthesize direction, velocity, image, destination;

- (id) initWithX:(float) x 
			   y:(float) y 
	   direction:(DirectionType) _direction 
		velocity:(float) _velocity 
		   image:(SPImage*) _image; {
	if (self = [super init]) {
		self.x = x;
		self.y = y;
		self.direction = _direction;
		self.velocity = _velocity;
		self.image = _image;
		self.destination = [SPPoint pointWithX:x y:y];
		[self addChild:image];
	}
	return self;
}

- (NSString*) directionToString 
{
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

+ (Entity*) entityWithX:(float) x 
					  y:(float) y 
			  direction:(DirectionType) direction 
			   velocity:(float) velocity 
				  image:(SPImage*) image {
	return [[[Entity alloc] initWithX:x	y:y direction:direction velocity:velocity image:image] autorelease];
}

- (void) dealloc {
	self.image = nil;
	self.destination = nil;
	[super dealloc];
}	
   
@end

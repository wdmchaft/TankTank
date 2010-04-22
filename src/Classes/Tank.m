//
//  Tank.m
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "Tank.h"


@implementation Tank
@synthesize direction, velocity, destination, images;

- (id) initWithX:(float)_x y:(float)_y direction:(DirectionType)_direction velocity:(float)_velocity {
	if (self = [super init]) {
		self.x = _x;
		self.y = _y;
		self.direction = _direction;
		self.velocity = _velocity;
		self.destination = [SPPoint pointWithX:_x y:_y];
		
		SPTextureAtlas* atlas = [[SPTextureAtlas alloc] initWithContentsOfFile:@"atlas.xml"];
		NSLog(@"found %d textures.", atlas.count);
		
		images = [[NSMutableDictionary alloc] init];
		[images setObject:[SPImage imageWithTexture:[atlas textureByName:@"tank_right"]] forKey:@"tank_right"];
		[images setObject:[SPImage imageWithTexture:[atlas textureByName:@"tank_left"]] forKey:@"tank_left"];
		[images setObject:[SPImage imageWithTexture:[atlas textureByName:@"tank_up"]] forKey:@"tank_up"];
		[images setObject:[SPImage imageWithTexture:[atlas textureByName:@"tank_down"]] forKey:@"tank_down"];
		NSLog(@"Images: %@", images);
		[self addChild:[images objectForKey:[NSString stringWithFormat:@"tank_%@", [self directionToString]]]];
		
		[atlas release];
	}
	return self;
}

- (id) initWithX:(float)_x y:(float)_y {
	if (self = [super init]) {
		self.x = _x;
		self.y = _y;
	}
	return [self initWithX:_x y:_y direction:DIRECTION_UP velocity:0.0f];
}

- (id) init {
	return [self initWithX:0.0f y:0.0f];
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

+ (Tank*) tankWithX:(float) x y:(float) y direction:(DirectionType) direction velocity:(float) velocity {
	return [[[Tank alloc] initWithX:x y:y direction:direction velocity:velocity] autorelease];
}

+ (Tank*) tankWithX:(float) x y:(float) y {
	return [[[Tank alloc] initWithX:x y:y direction:DIRECTION_UP velocity:0.0f] autorelease];
}

+ (Tank*) tank {
	return [[[Tank alloc] initWithX:0.0f y:0.0f] autorelease];
}

- (void) dealloc {
	self.destination = nil;
	self.images = nil;
	[super dealloc];
}	
   
@end

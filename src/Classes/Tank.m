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
		NSArray* textureNames = [[NSArray alloc] initWithObjects:@"tank_east", @"tank_west", @"tank_north", @"tank_south", nil];
		for (NSString* textureName in textureNames) {
			[images setObject:[SPImage imageWithTexture:[atlas textureByName:textureName]] 
					   forKey:textureName];
		}
		[textureNames release];
		[atlas release];
		
		NSLog(@"Images: %@", images);
		[self addChild:[images objectForKey:[NSString stringWithFormat:@"tank_%@", [self directionToString:self.direction]]]];
		
		
	}
	return self;
}

- (id) initWithX:(float)_x y:(float)_y {
	if (self = [super init]) {
		self.x = _x;
		self.y = _y;
	}
	return [self initWithX:_x y:_y direction:DIRECTION_NORTH velocity:0.0f];
}

- (id) init {
	return [self initWithX:0.0f y:0.0f];
}

- (void) move
{
	if (self.destination.x > self.x)
	{
		self.x++;
		[self face:DIRECTION_WEST];
	} 
	else if (self.destination.x < self.x)
	{
		self.x--;
		[self face:DIRECTION_EAST];
	} 
	else if (self.destination.y > self.y)
	{
		self.y++;
		[self face:DIRECTION_SOUTH];
	} 
	else if (self.destination.y < self.y)
	{
		self.y--;
		[self face:DIRECTION_NORTH];
	}
}

- (void) face:(DirectionType)newFacing
{
	if (newFacing != self.direction) {
		NSLog(@"Changing facing from %@ to: %@", [self directionToString:self.direction], [self directionToString:newFacing]);
		SPImage *oldImage = [images objectForKey:[NSString stringWithFormat:@"tank_%@", [self directionToString:self.direction]]];
		SPImage *newImage = [images objectForKey:[NSString stringWithFormat:@"tank_%@", [self directionToString:newFacing]]];
		NSLog(@"Old image: %@. New Image %@", oldImage, newImage);
		self.direction = newFacing;
		[self removeChild:oldImage];
		[self addChild:newImage];
		
		// TODO figure out why swapChild doesn't work, but removeChild/addChild does
		//[self swapChild:oldImage withChild:newImage];
	}
	
}

- (NSString*) directionToString:(DirectionType)facing
{
	NSString *result = [NSString string];
	switch (facing) {
		case DIRECTION_NORTH:
			result = @"north";
			break;
		case DIRECTION_WEST:
			result = @"west";
			break;
		case DIRECTION_SOUTH:
			result = @"south";
			break;
		case DIRECTION_EAST:
			result = @"east";
			break;
		default:
			NSLog(@"Error. Direction not set!");
	}
	return result;
}


- (void) dealloc {
	self.destination = nil;
	self.images = nil;
	[super dealloc];
}

+ (Tank*) tankWithX:(float) x y:(float) y direction:(DirectionType) direction velocity:(float) velocity {
	return [[[Tank alloc] initWithX:x y:y direction:direction velocity:velocity] autorelease];
}

+ (Tank*) tankWithX:(float) x y:(float) y {
	return [[[Tank alloc] initWithX:x y:y direction:DIRECTION_NORTH velocity:0.0f] autorelease];
}

+ (Tank*) tank {
	return [[[Tank alloc] initWithX:0.0f y:0.0f] autorelease];
}
   
@end

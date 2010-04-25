//
//  DGTank.m
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//
#import "DGTank.h"
#import "DGGame.h"


@implementation DGTank
@synthesize direction, velocity, destination, images;

- (id) initWithX:(float)anX y:(float)anY direction:(DGDirection)aDirection velocity:(float)aVelocity 
{
	if (self = [super init]) 
	{
		self.x = anX;
		self.y = anY;
		self.direction = aDirection;
		self.velocity = aVelocity;
		self.destination = [SPPoint pointWithX:anX y:anY];
		
		SPTextureAtlas* atlas = [[SPTextureAtlas alloc] initWithContentsOfFile:@"atlas.xml"];
		NSLog(@"found %d textures.", atlas.count);
		
		self.images = [[NSMutableDictionary alloc] init];
		NSArray* textureNumbers = [[NSArray alloc] initWithObjects:
								 [NSNumber numberWithInt:DIRECTION_NORTH], 
								 [NSNumber numberWithInt:DIRECTION_WEST],
								 [NSNumber numberWithInt:DIRECTION_SOUTH],
								 [NSNumber numberWithInt:DIRECTION_EAST], nil];
					
		for (NSNumber* textureNumber in textureNumbers) 
		{
			[self.images setObject:[SPImage imageWithTexture:[atlas textureByName:[NSString stringWithFormat:@"tank_dir_%@", textureNumber]]] 
					   forKey:[NSString stringWithFormat:@"tank_dir_%@", textureNumber]];
		}
		[textureNumbers release];
		[atlas release];
		
		NSLog(@"Images: %@", self.images);
		[self addChild:[self.images objectForKey:[NSString stringWithFormat:@"tank_dir_%d", (int)self.direction]]];		
	}
	return self;
}

- (id) initWithX:(float)anX y:(float)anY 
{
	if (self = [super init]) 
	{
		self.x = anX;
		self.y = anY;
	}
	return [self initWithX:anX y:anY direction:DIRECTION_NORTH velocity:0.0f];
}

- (id) init 
{
	return [self initWithX:0.0f y:0.0f];
}

- (void) moveBy:(float)amount
{
	if ((self.destination.x > self.x) && (abs(self.destination.x - self.x) > DG_MOVEMENT_THRESHOLD))
	{
		self.x = self.x + amount;
		[self changeDirection:DIRECTION_WEST];
	} 
	else if ((self.destination.x < self.x) && (abs(self.destination.x - self.x) > DG_MOVEMENT_THRESHOLD))
	{
		self.x = self.x - amount;
		[self changeDirection:DIRECTION_EAST];
	} 
	else if ((self.destination.y > self.y) && (abs(self.destination.y - self.y) > DG_MOVEMENT_THRESHOLD))
	{
		self.y = self.y + amount;
		[self changeDirection:DIRECTION_SOUTH];
	} 
	else if ((self.destination.y < self.y) && (abs(self.destination.y - self.y) > DG_MOVEMENT_THRESHOLD))
	{
		self.y = self.y - amount;
		[self changeDirection:DIRECTION_NORTH];
	}
}

- (void) changeDirection:(DGDirection)newDirection
{
	if (newDirection != self.direction) 
	{
		NSLog(@"Old direction: %@", [DGGame stringFromDirection:self.direction]);
		NSLog(@"New direction: %@", [DGGame stringFromDirection:newDirection]);
		
		SPImage *oldImage = [images objectForKey:[NSString stringWithFormat:@"tank_dir_%d", (int)direction]];
		SPImage *newImage = [images objectForKey:[NSString stringWithFormat:@"tank_dir_%d", (int)newDirection]];
		self.direction = newDirection;
		[self removeChild:oldImage];
		[self addChild:newImage];
	}
	
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tank: x=%f, y=%f, direction=%@, velocity=%f", self.x, self.y, [DGGame stringFromDirection:self.direction], self.velocity];
}

- (void) dealloc 
{
	self.destination = nil;
	self.images = nil;
	[destination release];
	[images release];
	[super dealloc];
}

+ (DGTank*) tankWithX:(float)anX y:(float)anY direction:(DGDirection)aDirection velocity:(float)aVelocity 
{
	return [[[DGTank alloc] initWithX:anX y:anY direction:aDirection velocity:aVelocity] autorelease];
}

+ (DGTank*) tankWithX:(float)anX y:(float)anY 
{
	return [[[DGTank alloc] initWithX:anX y:anY direction:DIRECTION_NORTH velocity:0.0f] autorelease];
}

+ (DGTank*) tank 
{
	return [[[DGTank alloc] initWithX:0.0f y:0.0f] autorelease];
}
   
@end

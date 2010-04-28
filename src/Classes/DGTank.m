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
					
		for (NSNumber* oneTextureNumber in textureNumbers) 
		{
			[self.images setObject:[SPImage imageWithTexture:[atlas textureByName:[NSString stringWithFormat:@"tank_dir_%@", oneTextureNumber]]] 
					   forKey:[NSString stringWithFormat:@"tank_dir_%@", oneTextureNumber]];
		}
		[textureNumbers release];
		[atlas release];
		
		for (NSString* key in self.images)
		{
			SPImage *image = [self.images objectForKey:key];
			image.scaleX = DG_SCALE_AMOUNT;
			image.scaleY = DG_SCALE_AMOUNT;
			image.x = -(image.width / 2);
			image.y = -(image.height / 2);
		}
		
		NSLog(@"Images: %@", self.images);
		[self addChild:[self.images objectForKey:[NSString stringWithFormat:@"tank_dir_%d", (int)self.direction]]];
		NSLog(@"Width: %f", self.width);
		
		[self addEventListener:@selector(onTouch:) 
					  atObject:self 
					   forType:SP_EVENT_TYPE_TOUCH];
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
	SPPoint* currentPos = [SPPoint pointWithX:self.x y:self.y];
	float radius = self.width/2;
	if ([SPPoint distanceFromPoint:currentPos toPoint:self.destination] < radius || [currentPos isEqual:self.destination]) return;
	
	float diffY = self.destination.y - self.y;
	float diffX = self.destination.x - self.x;
	
	float angle = atan2f(diffY, diffX);
	self.rotation = angle;
	
	// TODO make tank move according to rotation
}

- (void) changeDirection:(DGDirection)newDirection
{
	if (newDirection != self.direction) 
	{		
		SPImage *oldImage = [images objectForKey:[NSString stringWithFormat:@"tank_dir_%d", (int)direction]];
		SPImage *newImage = [images objectForKey:[NSString stringWithFormat:@"tank_dir_%d", (int)newDirection]];
		self.direction = newDirection;
		[self removeChild:oldImage];
		[self addChild:newImage];
	}
	
}

- (void) onTouch:(SPTouchEvent*) event 
{
	SPTouch *touch = [[event touchesWithTarget:self 
									  andPhase:SPTouchPhaseBegan] anyObject];
    if (touch) 
	{
		NSLog(@"Tank was touched");
		NSLog(@"%@", self);
    }	
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tank: x=%f, y=%f, direction=%@, velocity=%f, rotation=%f", self.x, self.y, [DGGame stringFromDirection:self.direction], self.velocity, SP_R2D(self.rotation)];
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

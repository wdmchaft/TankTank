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
@synthesize speed, destination, images;

- (id) initWithX:(float)anX y:(float)anY speed:(float)aSpeed 
{
	if (self = [super init]) 
	{
		self.x = anX;
		self.y = anY;
		self.speed = aSpeed;
		self.destination = [SPPoint pointWithX:anX y:anY];
		
		SPTextureAtlas* atlas = [[SPTextureAtlas alloc] initWithContentsOfFile:@"atlas.xml"];
		NSLog(@"found %d textures.", atlas.count);
		
		self.images = [[NSMutableDictionary alloc] init];
		[self.images setObject:[SPImage imageWithTexture:[atlas textureByName:DG_TEXTURE_TANK]] 
					   forKey:DG_TEXTURE_TANK];
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
		[self addChild:[self.images objectForKey:DG_TEXTURE_TANK]];
		NSLog(@"Width: %f", self.width);
		
		[self addEventListener:@selector(onTankTouch:) 
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
	return [self initWithX:anX y:anY speed:0.0f];
}

- (id) init 
{
	return [self initWithX:0.0f y:0.0f];
}

- (void) moveBy:(float)amount
{
	SPPoint* currentPos = [SPPoint pointWithX:self.x y:self.y];
	float radius = self.width/2;
	if ([SPPoint distanceFromPoint:currentPos toPoint:self.destination] < radius) return;
	
	float diffY = self.destination.y - self.y;
	float diffX = self.destination.x - self.x;
	
	float angle = atan2f(diffY, diffX);
	
	if (angle == self.rotation) return;
	
	SPTween *tween = [SPTween tweenWithTarget:self time:1.0f];
	[tween animateProperty:@"rotation" targetValue:angle];
	[self.stage.juggler addObject:tween];
	[tween addEventListener:@selector(onRotationTweenCompleted:)
				   atObject:self 
					forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
}

- (void) onRotationTweenCompleted:(SPEvent*) event
{
	NSLog(@"Tween completed.");
	float xVelocity = cosf(self.rotation) * self.speed;
	float yVelocity = sinf(self.rotation) * self.speed;
	
	self.x = self.x + xVelocity;
	self.y = self.y + yVelocity;	
}

- (void) onTankTouch:(SPTouchEvent*) event 
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
    return [NSString stringWithFormat:@"I am a tank with an x of %.2f, y of %.2f, speed of %.2f, and rotation of %.2f", self.x, self.y, self.speed, SP_R2D(self.rotation)];
}

- (void) dealloc 
{
	self.destination = nil;
	self.images = nil;
	[destination release];
	[images release];
	[super dealloc];
}

+ (DGTank*) tankWithX:(float)anX y:(float)anY speed:(float)aSpeed 
{
	return [[[DGTank alloc] initWithX:anX y:anY speed:aSpeed] autorelease];
}

+ (DGTank*) tankWithX:(float)anX y:(float)anY 
{
	return [[[DGTank alloc] initWithX:anX y:anY speed:0.0f] autorelease];
}

+ (DGTank*) tank 
{
	return [[[DGTank alloc] initWithX:0.0f y:0.0f] autorelease];
}
   
@end

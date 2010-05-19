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
@synthesize speed, destination, images, blocked, willMove, movingImages;

- (id) initWithX:(float)anX y:(float)anY speed:(float)aSpeed 
{
	if (self = [super init]) 
	{
		self.x = anX;
		self.y = anY;
		self.speed = aSpeed;
		self.destination = [SPPoint pointWithX:anX y:anY];
		self.blocked = FALSE;
		
		
		self.images = [[NSMutableDictionary alloc] init];
		[self.images setObject:[SPImage imageWithTexture:[DGMedia atlasTexture:DG_TEXTURE_TANK_IDLE]] 
					   forKey:DG_TEXTURE_TANK_IDLE];
		[self.images setObject:[SPImage imageWithTexture:[DGMedia atlasTexture:DG_TEXTURE_TANK_MOVE_01]] 
						forKey:DG_TEXTURE_TANK_MOVE_01];
		[self.images setObject:[SPImage imageWithTexture:[DGMedia atlasTexture:DG_TEXTURE_TANK_MOVE_02]] 
						forKey:DG_TEXTURE_TANK_MOVE_02];
		
		self.movingImages = [[NSMutableArray alloc] init];
		for (NSString* key in self.images)
		{
			SPImage *image = [self.images objectForKey:key];
			image.x = -(image.width / 2);
			image.y = -(image.height / 2);
			image.scaleX = DG_SCALING;
			image.scaleY = DG_SCALING;
			
			if (key != DG_TEXTURE_TANK_IDLE)
			{
				[self.movingImages addObject:image];
			}
		}
		[self addChild:[self.images objectForKey:DG_TEXTURE_TANK_IDLE]];
		
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

- (void) destinationFromTouch:(SPPoint*)touchPosition willMove:(BOOL)movingStatus
{
	SPPoint* currentPos = [SPPoint pointWithX:self.x y:self.y];
	if (![touchPosition isEqual:currentPos] || self.blocked)
	{
		self.destination = touchPosition;
		[self rotateToNewAngle];
		self.willMove = movingStatus;
	}
}

- (void) rotateToNewAngle
{
	self.blocked = TRUE;
	float diffY = self.destination.y - self.y;
	float diffX = self.destination.x - self.x;
	
	float angle = atan2f(diffY, diffX);
	float angleInDegrees = SP_R2D(angle);
	float currentRotationInDegrees = SP_R2D(self.rotation);
	if (angleInDegrees < 0)
	{
		NSLog(@"angle < 0: %.2f", angleInDegrees);
		angleInDegrees = 360 + angleInDegrees;
		angle = SP_D2R(angleInDegrees);
	}
	NSLog(@"Current rotation: %.2f, new angle: %.2f", 
		  currentRotationInDegrees, angleInDegrees);
	
	SPTween *tween = [SPTween tweenWithTarget:self time:1.0f];
	[tween animateProperty:@"rotation" targetValue:angle];
	[self.stage.juggler addObject:tween];
	[tween addEventListener:@selector(onRotationTweenCompleted:)
				   atObject:self 
					forType:SP_EVENT_TYPE_TWEEN_COMPLETED];


}

- (BOOL) canMove
{
	SPPoint* currentPos = [SPPoint pointWithX:self.x y:self.y];
	float radius = self.width/2;
	BOOL status = TRUE;
	float distance = [SPPoint distanceFromPoint:currentPos toPoint:self.destination];
	if ( distance < radius || self.blocked || !self.willMove)
	{
		status = FALSE;
	}
	return status;
}

- (void) moveBy:(float)amount
{
	if ([self canMove])
	{
		
		float xVelocity = cosf(self.rotation) * self.speed;
		float yVelocity = sinf(self.rotation) * self.speed;
		
		self.x = self.x + xVelocity;
		self.y = self.y + yVelocity;
	}
}

- (void) onRotationTweenCompleted:(SPEvent*) event
{
	NSLog(@"Tween completed.");
	self.blocked = FALSE;
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
    return [NSString stringWithFormat:@"I am a tank with an x of %.2f, y of %.2f, speed of %.2f, width/height of %.2f/%.2f and rotation of %.2f", 
			self.x, self.y, self.speed, self.width, self.height, SP_R2D(self.rotation)];
}

- (void) dealloc 
{
	self.destination = nil;
	self.images = nil;
	self.movingImages = nil;
	[destination release];
	[images release];
	[movingImages release];
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

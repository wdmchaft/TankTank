//
//  DGGame.m
//  AppScaffold
//
//  Created by Nathan Koch on 4.25.10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "DGGame.h" 

@implementation DGGame

@synthesize sprite, tank;

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height]) {
		self.tank = [DGTank tankWithX:10 y:100 direction:DIRECTION_WEST velocity:20];
		[self addChild:tank];
		
		[self addEventListener:@selector(onEnterFrame:) 
					  atObject:self 
					   forType:SP_EVENT_TYPE_ENTER_FRAME];
		
		[self addEventListener:@selector(onTouch:) 
					  atObject:self 
					   forType:SP_EVENT_TYPE_TOUCH];
    }
    return self;
}

- (void) onEnterFrame:(SPEnterFrameEvent*) event 
{
	[self.tank moveBy:(event.passedTime * self.tank.velocity)];
}

- (void) onTouch:(SPTouchEvent*) event 
{
	SPTouch *touch = [[event touchesWithTarget:self 
									  andPhase:SPTouchPhaseBegan] anyObject];
    if (touch) 
	{
        SPPoint *touchPosition = [touch locationInSpace:self];
		NSLog(@"Touched position (%f, %f)", touchPosition.x, touchPosition.y);
		self.tank.destination = touchPosition;
    }	
}

- (void) dealloc 
{
	self.sprite = nil;
	self.tank = nil;
	[sprite release];
	[tank release];
	[super dealloc];
}

+ (NSString*) stringFromDirection:(DGDirection)aDirection
{
	NSString* result = nil;
	switch (aDirection)
	{
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
			NSLog(@"Invalid direction type!");
	}
	return result;
}

@end

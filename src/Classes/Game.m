//
//  Game.m
//  AppScaffold
//
//  Created by Daniel Sperl on 14.01.10.
//  Copyright 2010 Incognitek. All rights reserved.
//

#import "Game.h" 

@implementation Game

@synthesize sprite, tank;

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height]) {
		self.tank = [Tank tankWithX:10 y:100 direction:DIRECTION_WEST velocity:1];
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
	[self.tank move];
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

@end

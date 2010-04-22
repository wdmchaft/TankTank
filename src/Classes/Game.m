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
		tank = [Tank tankWithX:10 y:100 direction:DIRECTION_RIGHT velocity:1];
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

- (void) onEnterFrame:(SPEnterFrameEvent*) event {
	if (tank.x < tank.destination.x)
		tank.x++;
	else if (tank.x > tank.destination.x)
		tank.x--;
	else if (tank.y < tank.destination.y)
		tank.y++;
	else if (tank.y > tank.destination.y)
		tank.y--;
}

- (void) onTouch:(SPTouchEvent*) event {
	SPTouch *touch = [[event touchesWithTarget:self 
									  andPhase:SPTouchPhaseBegan] anyObject];
    if (touch) {
        SPPoint *touchPosition = [touch locationInSpace:self];
		tank.destination = touchPosition;
        NSLog(@"Touched position (%f, %f)", tank.destination.x, tank.destination.y);
    }	
}

- (void) dealloc {
	self.sprite = nil;
	self.tank = nil;
	[super dealloc];
}

@end

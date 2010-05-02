//
//  DGGame.m
//  AppScaffold
//
//  Created by Nathan Koch on 4.25.10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "DGGame.h" 

@implementation DGGame

@synthesize tank, contents;

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height]) {
		
		self.contents = [[SPSprite alloc] init];
		self.contents.rotation = SP_D2R(90);
		self.contents.x = 320;
		[self addChild:self.contents];
		
		self.tank = [DGTank tankWithX:100 y:200 speed:DG_BASE_SPEED];
		[self.contents addChild:self.tank];
		
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
	[self.tank moveBy:(event.passedTime * self.tank.speed)];
}

- (void) onTouch:(SPTouchEvent*) event 
{
	SPTouch *touch = [[event touchesWithTarget:self 
									  andPhase:SPTouchPhaseBegan] anyObject];
    if (touch) 
	{
        SPPoint *touchPosition = [touch locationInSpace:self.contents];
		NSLog(@"Touched position (%f, %f)", touchPosition.x, touchPosition.y);
		self.tank.destination = touchPosition;
    }	
}

- (void) dealloc 
{
	self.contents = nil;
	self.tank = nil;
	[contents release];
	[tank release];
	[super dealloc];
}

@end

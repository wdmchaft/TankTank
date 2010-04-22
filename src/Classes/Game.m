//
//  Game.m
//  AppScaffold
//
//  Created by Daniel Sperl on 14.01.10.
//  Copyright 2010 Incognitek. All rights reserved.
//

#import "Game.h" 

@implementation Game

@synthesize sprite;
@synthesize entity;

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height]) {
		SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"atlas.xml"];
		NSLog(@"found %d textures.", atlas.count);
		
		SPImage *tank_right = [SPImage imageWithTexture:[atlas textureByName:@"tank_right"]];
		
		entity = [Entity entityWithX:10 y:100 direction:DIRECTION_RIGHT velocity:1 image:tank_right];
		[self addChild:entity];
		
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
	if (entity.x < entity.destination.x)
		entity.x++;
	else if (entity.x > entity.destination.x)
		entity.x--;
	
	if (entity.y < entity.destination.y)
		entity.y++;
	else if (entity.y > entity.destination.y)
		entity.y--;
}

- (void) onTouch:(SPTouchEvent*) event {
	SPTouch *touch = [[event touchesWithTarget:self 
									  andPhase:SPTouchPhaseBegan] anyObject];
    if (touch) {
        SPPoint *touchPosition = [touch locationInSpace:self];
		entity.destination = touchPosition;
        NSLog(@"Touched position (%f, %f)", entity.destination.x, entity.destination.y);
    }	
}

- (void) dealloc {
	self.sprite = nil;
	self.entity = nil;
	[super dealloc];
}

@end

//
//  DGGame.m
//  AppScaffold
//
//  Created by Nathan Koch on 4.25.10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "DGGame.h" 

@implementation DGGame

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height]) {
		
		// translate the game into landscape mode
		SPSprite* contents = [[SPSprite alloc] init];
		contents.rotation = SP_D2R(90);
		contents.x = 320;
		[self addChild:contents];
		
		// create game world
		DGWorld *world = [[DGWorld alloc] init];
		[contents addChild:world];
		
		[contents release];
		[world release];
    }
    return self;
}

- (void) dealloc 
{
	[super dealloc];
}

@end

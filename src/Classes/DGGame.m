//
//  DGGame.m
//  AppScaffold
//
//  Created by Nathan Koch on 4.25.10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "DGGame.h" 
#import "DGMedia.h"

@implementation DGGame

@synthesize contents, world, fireButton;

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height]) {
		
		// load texture atlas
		[DGMedia initTextures];
		
		// translate the game into landscape mode
		self.contents = [[SPSprite alloc] init];
		self.contents.rotation = SP_D2R(90);
		self.contents.x = 320;
		[self addChild:self.contents];
		
		// create game world
		self.world = [[DGWorld alloc] init];
		[self.contents addChild:world];
		
		self.fireButton = [SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"fire_button.png"]];
		self.fireButton.x = self.world.width - self.fireButton.width;
		self.fireButton.y = self.world.height - self.fireButton.height;
		[self.contents addChild:self.fireButton];
		
		[self.fireButton addEventListener:@selector(onFireButtonPressed:) 
								 atObject:self 
								  forType:SP_EVENT_TYPE_TRIGGERED];
		
		
    }
    return self;
}

- (void) onFireButtonPressed:(SPEvent*) event
{
	NSLog(@"Fire Button Pressed!");
}

- (void) dealloc 
{
	[DGMedia releaseTextures];
	self.world = nil;
	self.contents = nil;
	self.fireButton = nil;
	[world release];
	[contents release];
	[fireButton release];
	[super dealloc];
}

@end

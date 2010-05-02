//
//  DGGame.m
//  AppScaffold
//
//  Created by Nathan Koch on 4.25.10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "DGGame.h" 

@implementation DGGame

@synthesize contents, world, goButton, fireButton;

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height]) {
		
		// translate the game into landscape mode
		self.contents = [[SPSprite alloc] init];
		self.contents.rotation = SP_D2R(90);
		self.contents.x = 320;
		[self addChild:self.contents];
		
		// create game world
		self.world = [[DGWorld alloc] init];
		[self.contents addChild:world];
		
		self.goButton = [SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"go_button.png"]];
		self.goButton.x = 0;
		self.goButton.y = self.world.height - self.goButton.height;
		[self.contents addChild:self.goButton];
	
		[self.goButton addEventListener:@selector(onGoButtonPressed:) 
					  atObject:self 
					   forType:SP_EVENT_TYPE_TRIGGERED];
		
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

- (void) onGoButtonPressed:(SPEvent*) event 
{
	NSLog(@"Go Button Pressed!");
}

- (void) onFireButtonPressed:(SPEvent*) event
{
	NSLog(@"Fire Button Pressed!");
}

- (void) dealloc 
{
	self.goButton = nil;
	self.world = nil;
	self.contents = nil;
	[goButton release];
	[world release];
	[contents release];
	[super dealloc];
}

@end

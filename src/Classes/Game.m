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

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height])
    {
		SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"atlas.xml"];
		NSLog(@"found %d textures.", atlas.count);
		
		SPImage *tank_right = [SPImage imageWithTexture:[atlas textureByName:@"tank_right"]];
		
		sprite = [SPSprite sprite];
		[sprite addChild:tank_right];
		[self addChild:sprite];
		
		float spriteWidth = sprite.width;
		sprite.x = 100;
		sprite.y = 100;
		NSLog(@"Sprite width: %@", [NSNumber numberWithFloat:spriteWidth]);
		NSLog(@"Stage width: %@", [NSNumber numberWithFloat:width]);
		NSLog(@"Sprite x: %d", sprite.x);
		
		[self addEventListener:@selector(onEnterFrame:) 
					  atObject:self 
					   forType:SP_EVENT_TYPE_ENTER_FRAME];
        
    }
    return self;
}

- (void)onEnterFrame:(SPEnterFrameEvent*) event {
	NSLog(@"Time passed since last frame: %f", event.passedTime);
	if (sprite.x < (self.width - sprite.width)) {
		sprite.x = sprite.x + 1;
	}
}

@end

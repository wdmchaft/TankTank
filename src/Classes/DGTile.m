//
//  DGTile.m
//  TankTank
//
//  Created by nathan_laptop on 6/1/10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import "DGTile.h"


@implementation DGTile

@synthesize image, isWalkable, tileType;

- (id) initWithX:(float)theX y:(float)theY tileType:(int)theTileType {
	if (self = [super init]) 
	{
		self.x = theX;
		self.y = theY;
		self.width = DG_SINGLE_TILE_WIDTH;
		self.height = DG_SINGLE_TILE_HEIGHT;
		self.tileType = theTileType;
		switch (self.tileType)
		{
			case DG_TILE_WALL:
				self.image = [SPImage imageWithTexture:[DGMedia atlasTexture:DG_TEXTURE_WALL]];
				[self addChild:self.image];
				self.isWalkable = FALSE;
				break;
			default:
				self.image = nil;
				self.isWalkable = TRUE;
				break;
		}
	}
	return self;
}

- (id) initWithX:(float)theX y:(float)theY {
	return [self initWithX:theX y:theY tileType:DG_TILE_EMPTY];
}

- (id)init {
    return [self initWithX:0 y:0];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n I am a tile with: \n\t type: %d \n\t walkable: %d \n\t image: %@ \n",
			self.tileType, self.isWalkable, self.image];
}

- (void)dealloc {
	self.image = nil;
	[image release];
    [super dealloc];
}

@end


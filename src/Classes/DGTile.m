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
			case DG_TILE_BLUE_WALL:
				self.image = [SPImage imageWithTexture:[DGMedia atlasTexture:DG_TEXTURE_BLUE_WALL]];
				[self addChild:self.image];
				self.isWalkable = FALSE;
				break;
			case DG_TILE_GREEN_WALL:
				self.image = [SPImage imageWithTexture:[DGMedia atlasTexture:DG_TEXTURE_GREEN_WALL]];
				[self addChild:self.image];
				self.isWalkable = FALSE;
			default:
				self.image = nil;
				self.isWalkable = TRUE;
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

- (NSString *)tileTypeAsString
{
	NSString* tileAsString;
	switch (self.tileType)
	{
		case DG_TILE_BLUE_WALL:
			tileAsString = @"Blue Wall";
			break;
		case DG_TILE_GREEN_WALL:
			tileAsString = @"Green Wall";
			break;
		default:
			tileAsString = @"Empty";
	}
	return tileAsString;
}

- (NSString *)isWalkableAsString
{
	NSString* output;
	if (self.isWalkable)
	{
		output = @"True";
	}
	else
	{
		output = @"False";
	}
	return output;
}

- (NSString *)description
{
    NSUInteger tileX = (NSUInteger) (self.x / 32);
	NSUInteger tileY = (NSUInteger) (self.y / 32);
	return [NSString stringWithFormat:@"\n I am a tile at location: %d,%d with: \n\t type: %@ \n\t walkable: %@ \n\t image: %@ \n",
			tileX, tileY, self.tileTypeAsString, self.isWalkableAsString, self.image];
}

- (void)dealloc {
	self.image = nil;
	[image release];
    [super dealloc];
}

@end


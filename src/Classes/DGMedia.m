//
//  DGMedia.m
//  TankTank
//


#import "DGMedia.h"


@implementation DGMedia
static SPTextureAtlas* atlas;

+ (void) initTextures
{
	atlas = [[SPTextureAtlas alloc] initWithContentsOfFile:@"atlas.xml"];
	NSLog(@"found %d textures.", atlas.count);
}

+ (SPTexture*) atlasTexture:(NSString*)textureName
{
	return [atlas textureByName:textureName];
}

+ (void) releaseTextures
{
	[atlas release];
}

@end

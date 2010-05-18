//
//  DGMedia.h
//  TankTank
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"

@interface DGMedia : NSObject 
{
}

+ (void) initTextures;
+ (SPTexture*) atlasTexture:(NSString*)textureName;
+ (void) releaseTextures;

@end

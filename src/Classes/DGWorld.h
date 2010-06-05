//
//  DGWorld.h
//  TankTank
//

#import <Foundation/Foundation.h>
#import "DGTank.h"
#import "DGTile.h"
#import "DGMedia.h"


@interface DGWorld : SPSprite {
	DGTank *tank;
	NSMutableArray *tiles;
	
}

@property (nonatomic, retain) NSMutableArray *tiles;
@property (nonatomic, retain) DGTank *tank;


- (id) init;

@end

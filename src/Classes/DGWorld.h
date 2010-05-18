//
//  DGWorld.h
//  TankTank
//

#import <Foundation/Foundation.h>
#import "DGTank.h"
#import "DGMedia.h"


@interface DGWorld : SPSprite {
	DGTank *tank;
}

@property (nonatomic, retain) DGTank *tank;

- (id) init;

@end

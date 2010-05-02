//
//  DGWorld.h
//  TankTank
//

#import <Foundation/Foundation.h>
#import "DGTank.h"

@interface DGWorld : SPSprite {
	DGTank *tank;
}

@property (nonatomic, retain) DGTank *tank;

- (id) init;

@end

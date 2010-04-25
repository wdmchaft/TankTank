//
//  DGTank.h
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Developmet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "DGDirection.h"

@class DGGame;
@interface DGTank : SPSprite 
{
	DGDirection direction;
	float velocity;
	SPPoint* destination;
	NSMutableDictionary* images;
}

@property (nonatomic, assign) DGDirection direction;
@property (nonatomic, assign) float velocity;
@property (nonatomic, retain) SPPoint* destination;
@property (nonatomic, retain) NSMutableDictionary* images;

// designated initializer
- (id) initWithX:(float)anX y:(float)anY direction:(DGDirection)aDirection velocity:(float)aVelocity;
- (id) initWithX:(float)anX y:(float)anY;
- (id) init;
- (void) move;
- (void) changeDirection:(DGDirection)newDirection;

+ (DGTank*) tankWithX:(float)anX y:(float)anY direction:(DGDirection)aDirection velocity:(float)aVelocity;
+ (DGTank*) tankWithX:(float)anX y:(float)anY;
+ (DGTank*) tank;
@end

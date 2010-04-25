//
//  Tank.h
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Developmet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "DirectionType.h"

@class Game;
@interface Tank : SPSprite 
{
	DirectionType direction;
	float velocity;
	SPPoint* destination;
	NSMutableDictionary* images;
}

@property (nonatomic, assign) DirectionType direction;
@property (nonatomic, assign) float velocity;
@property (nonatomic, retain) SPPoint* destination;
@property (nonatomic, retain) NSMutableDictionary* images;

// designated initializer
- (id) initWithX:(float)anX y:(float)anY direction:(DirectionType)aDirection velocity:(float)aVelocity;
- (id) initWithX:(float)anX y:(float)anY;
- (id) init;
- (void) move;
- (void) changeDirection:(DirectionType)newDirection;

+ (Tank*) tankWithX:(float)anX y:(float)anY direction:(DirectionType)aDirection velocity:(float)aVelocity;
+ (Tank*) tankWithX:(float)anX y:(float)anY;
+ (Tank*) tank;
@end

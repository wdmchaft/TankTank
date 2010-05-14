//
//  DGTank.h
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Developmet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "DGConstants.h"

@class DGGame;
@interface DGTank : SPSprite 
{
	float speed;
	SPPoint* destination;
	NSMutableDictionary* images;
	BOOL blocked;
	BOOL willMove;
}

@property (nonatomic, assign) float speed;
@property (nonatomic, retain) SPPoint* destination;
@property (nonatomic, retain) NSMutableDictionary* images;
@property (nonatomic, assign) BOOL blocked;
@property (nonatomic, assign) BOOL willMove;

// designated initializer
- (id) initWithX:(float)anX y:(float)anY speed:(float)aSpeed;
- (id) initWithX:(float)anX y:(float)anY;

- (void) destinationFromTouch:(SPPoint*)point willMove:(BOOL)movingStatus;
- (void) rotateToNewAngle;
- (BOOL) canMove;
- (void) moveBy:(float)amount;

+ (DGTank*) tankWithX:(float)anX y:(float)anY speed:(float)aSpeed;
+ (DGTank*) tankWithX:(float)anX y:(float)anY;
+ (DGTank*) tank;
@end

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
	NSMutableArray* movingImages;
	BOOL blocked;
	BOOL moving;
}

@property (nonatomic, assign) float speed;
@property (nonatomic, retain) SPPoint* destination;
@property (nonatomic, retain) NSMutableDictionary* images;
@property (nonatomic, retain) NSMutableArray* movingImages;
@property (nonatomic, assign) BOOL blocked;
@property (nonatomic, assign) BOOL moving;

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

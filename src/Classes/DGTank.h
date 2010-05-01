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
#import "DGConstants.h"

@class DGGame;
@interface DGTank : SPSprite 
{
	float speed;
	SPPoint* destination;
	NSMutableDictionary* images;
}

@property (nonatomic, assign) float speed;
@property (nonatomic, retain) SPPoint* destination;
@property (nonatomic, retain) NSMutableDictionary* images;

// designated initializer
- (id) initWithX:(float)anX y:(float)anY speed:(float)aSpeed;
- (id) initWithX:(float)anX y:(float)anY;
- (id) init;
- (void) moveBy:(float)amount;

+ (DGTank*) tankWithX:(float)anX y:(float)anY speed:(float)aSpeed;
+ (DGTank*) tankWithX:(float)anX y:(float)anY;
+ (DGTank*) tank;
@end

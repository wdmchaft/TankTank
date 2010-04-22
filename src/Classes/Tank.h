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
- (id) initWithX:(float)x y:(float)y direction:(DirectionType)direction velocity:(float)velocity;
- (id) initWithX:(float)_x y:(float)_y;
- (id) init;
- (NSString*) directionToString;

+ (Tank*) tankWithX:(float)x y:(float)y direction:(DirectionType)direction velocity:(float)velocity;
+ (Tank*) tankWithX:(float)x y:(float)y;
+ (Tank*) tank;
@end

//
//  Entity.h
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Developmet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "DirectionType.h"

@interface Entity : SPSprite 
{
	DirectionType direction;
	float velocity;
	SPImage* image;
	SPPoint* destination;
}

@property (nonatomic, assign) DirectionType direction;
@property (nonatomic, assign) float velocity;
@property (nonatomic, retain) SPImage* image;
@property (nonatomic, retain) SPPoint* destination;

- (id) initWithX:(float)x y:(float)y direction:(DirectionType)direction velocity:(float)velocity image:(SPImage*)image;
- (NSString*) directionToString;

+ (Entity*) entityWithX:(float)x y:(float)y direction:(DirectionType)direction velocity:(float)velocity image:(SPImage*)image;
@end

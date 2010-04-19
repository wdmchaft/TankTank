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

@interface Entity : SPSprite {
	DirectionType direction;
	float velocity;
}

@property (nonatomic, assign) DirectionType direction;
@property (nonatomic, assign) float velocity;

- (NSString*) directionToString;

@end

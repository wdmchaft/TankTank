//
//  DGTile.h
//  TankTank
//
//  Created by nathan_laptop on 6/1/10.
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "DGConstants.h"
#import "DGMedia.h"

@interface DGTile : SPSprite {
	SPImage* image;
	BOOL isWalkable;
	int tileType;
}

@property (nonatomic, retain) SPImage *image;
@property (nonatomic, assign) BOOL isWalkable;
@property (nonatomic, assign) int tileType;

// designated initializer
- (id) initWithX:(float)theX y:(float)theY tileType:(int)theTileType;
- (id) initWithX:(float)theX y:(float)theY;

@end

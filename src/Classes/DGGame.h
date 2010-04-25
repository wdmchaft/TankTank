//
//  DGGame.h
//  AppScaffold
//
//  Created by Nathan Koch on 4.25.10
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "DGTank.h"


@interface DGGame : SPStage
{
	SPSprite *sprite;
	DGTank *tank;
}

@property (nonatomic, retain) SPSprite *sprite;
@property (nonatomic, retain) DGTank *tank;

+ (NSString*) stringFromDirection:(DGDirection)aDirection;

@end